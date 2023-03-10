package com.kh.udon.product.controller;

import java.io.File;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.common.template.Pagination;
import com.kh.udon.member.model.vo.Keyword;
import com.kh.udon.member.model.vo.Wish;
import com.kh.udon.product.model.service.ProductService;
import com.kh.udon.product.model.vo.CategoryVO;
import com.kh.udon.product.model.vo.CouponDTO;
import com.kh.udon.product.model.vo.Evaluation;
import com.kh.udon.product.model.vo.ProductDTO;
import com.kh.udon.product.model.vo.ProductPhotoVO;
import com.kh.udon.product.model.vo.ProductVO;
import com.kh.udon.product.model.vo.ReasonReportVO;
import com.kh.udon.product.model.vo.ReportVO;
import com.kh.udon.product.model.vo.ReviewDTO;
import com.kh.udon.product.model.vo.SellerDTO;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController
{
    @Autowired
    private ProductService service;

    // ?????? ?????????
    @RequestMapping("/productListView")
    public String productList(String userId, int currentPage, Model model)
    {
        /*
         *      1. ???????????? ??????
         *      2. ???????????? ????????? ??????
         *      3. ?????? ?????? ??????
         *      4. ?????? ?????????
         */
        
        List<CategoryVO> category = service.selectAllCategory();
        List<Integer> categoryCount = service.selectAllCategoryCount(userId);
        int totalCount = service.selectTotalCount(userId);
        List<ProductDTO> popular = service.popular(userId);
        
        // --- pagination ---
        PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, 10, 9);
        List<ProductDTO> products = service.selectAll(pi, userId);
        
        model.addAttribute("category", category);
        model.addAttribute("categoryCount", categoryCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("products", products);
        model.addAttribute("selectedCategory", 0);
        model.addAttribute("pi", pi);
        model.addAttribute("popular", popular);
        
        return "product/productListView";
    }
    
    // ??????????????? ?????????
    @GetMapping("/categoryList")
    public String categoryList(@RequestParam("category") String categoryCode, 
                               String userId, int currentPage, Model model)
    {
        /*
         *      1. ???????????? ??????
         *      2. ???????????? ????????? ??????
         *      3. ?????? ?????? ??????
         *      4. ????????? ???????????? ?????? ?????????
         */
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("categoryCode", categoryCode);
        map.put("userId", userId);
        
        List<CategoryVO> category = service.selectAllCategory();
        List<Integer> categoryCount = service.selectAllCategoryCount(userId);
        int totalCount = service.selectCategoryCount(map);
        List<ProductDTO> popular = service.popular(userId);
        
        // --- pagination ---
        PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, 10, 9);
        List<ProductDTO> products = service.selectCategoryProducts(map, pi);
        
        model.addAttribute("category", category);
        model.addAttribute("categoryCount", categoryCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("products", products);
        model.addAttribute("selectedCategory", categoryCode);
        model.addAttribute("pi", pi);
        model.addAttribute("popular", popular);
        
        return "product/productListView";
    }
    
    // ??????
    @GetMapping("/search")
    public String search(String keyword, int category, String userId, int currentPage, Model model)
    {
        /*
         *      1. ???????????? ??????
         *      2. ???????????? ????????? ??????
         *      3. ?????? ?????? ??????
         *      4. ????????? ???????????? ?????? ?????????
         */
        
        Map<String, Object> map = new HashMap<>();
        map.put("keyword", keyword);
        map.put("category", category);
        map.put("userId", userId);
        
        List<CategoryVO> categoryList = service.selectAllCategory();
        List<Integer> categoryCount = service.selectAllCategoryCount(userId);
        int totalCount = service.selectSearchCount(map);
        List<ProductDTO> popular = service.popular(userId);
        
        // --- pagination ---
        PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, 10, 9);
        List<ProductDTO> products = service.search(map, pi);
        
        model.addAttribute("category", categoryList);
        model.addAttribute("categoryCount", categoryCount);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("products", products);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("pi", pi);
        if(products == null || products.size() == 0)
            model.addAttribute("msg", "????????? ????????? ????????????.");
        model.addAttribute("popular", popular);
        
        return "product/productListView";
    }
    
    // ?????? ?????? ??????
    @GetMapping("/register")
    public void register(@RequestParam String userId, Model model, HttpSession session) 
    {
        CouponDTO coupon = service.selectCoupon(userId);
        List<CategoryVO> category = service.selectAllCategory();

        //List??? json ????????????
        List<Keyword> keyword = (List<Keyword>) session.getAttribute("keywordList");
        JSONArray jsonArr = new JSONArray();
        log.debug("keywordList = {}", jsonArr.fromObject(keyword));
        
        model.addAttribute("keyword", jsonArr.fromObject(keyword));
        model.addAttribute("category", category);
        model.addAttribute("coupon", coupon);
    }
    
    // ????????? ??????
    @PostMapping("/register")
    public String register(ProductVO product,HttpServletRequest req,RedirectAttributes rttr)
    {
        int result = 0;
        
        // -------------------- uuid ?????? --------------------
        String[] uuid = req.getParameterValues("uploadFile"); 
        
        for(String s : uuid)
            log.debug("uuid = {}", s);
        
        int pCode = service.insert(product);
        
        if (uuid.length > 0) 
        {
            Map<String, Object> map = new HashMap<>();
            map.put("pCode", pCode);
            map.put("uuids", uuid);
            
            result = service.updateProductCode(map);
        }
        
        rttr.addFlashAttribute("msg", result > 0 ? "?????? ?????? ?????? ????" : "?????? ?????? ?????? ????");
        rttr.addAttribute("userId", product.getSeller());
        rttr.addAttribute("currentPage", 1);
        
        return "redirect:/product/productListView";
    }
    
    @PostMapping("/update")
    public String update(ProductVO product, HttpServletRequest req, RedirectAttributes rttr)
    {
        String[] uuid = req.getParameterValues("uploadFile");
        Map<String, Object> map = new HashMap<String, Object>();
        
        map.put("uuids", uuid);
        map.put("product", product);
        
        int result = service.update(map);
        
        rttr.addFlashAttribute("msg", result > 0 ? "?????? ?????? ?????? ????" : "?????? ?????? ?????? ????");
        rttr.addAttribute("userId", product.getSeller());
        rttr.addAttribute("currentPage", 1);
        
        return "redirect:/product/productListView";
    }

    /*      ????????? ????????????        */
    @RequestMapping("/productDetailView")
    public String productDetail(int pCode, String userId, Model model)
    {
        /*
         *      1. ?????? ??????
         *      2. ????????? ??????
         *      3. ????????? ??????
         *      4. ????????? ?????? ??????
         *      5. ?????? ??????
         *      6. ?????? ??????
         *      7. ???????????? ?????????
         */
        
        ProductDTO product = service.selectDTOByPCode(pCode);
        SellerDTO seller = service.selectSeller(product.getSeller());
        List<ReasonReportVO> reasonReport = service.selectReasonReport();
        List<ProductPhotoVO> photos = service.selectPhotos(pCode);
        
        // --- ????????? ?????? ---
        String[] keywords = product.getTitle().split(" ");
        int category = product.getCategoryCode();

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("keywords", keywords);
        map.put("category", category);
        map.put("pCode", pCode);
        map.put("userId", userId);
        map.put("seller", product.getSeller());
        
        List<ProductVO> similar = service.selectSimilarProducts(map);
        
        // --- ????????? ?????? ?????? ---
        List<ProductDTO> other = service.selectOtherProducts(map);
        
        // --- ?????? ??? ????????? ---
        long timeMillis = System.currentTimeMillis() - product.getOriginalRegDate().getTime();
        product.setTimeMillis(timeMillis);
        
        // --- ???????????? ????????? ---
        List<String> buyerList = service.selectBuyer(map);

        model.addAttribute("product", product);
        model.addAttribute("seller", seller);
        model.addAttribute("similar", similar);
        model.addAttribute("other", other);
        model.addAttribute("reasonReport", reasonReport);
        model.addAttribute("photos", photos);
        model.addAttribute("buyerList", buyerList);
        if(product.isCoupon())
            model.addAttribute("msg", "?????? ?????? ??????????????? ???????????");  
        return "product/productDetailView";
    }
    
    /* ?????? ???????????? */
    @GetMapping(value = "/getPhotos", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<ProductPhotoVO>> getPhotos(int pCode)
    {
        return new ResponseEntity<List<ProductPhotoVO>>(service.selectPhotos(pCode), HttpStatus.OK);
    }
    
    // ???????????? ??????
    @PostMapping(value = "/addToWish", produces = "application/text; charset=utf8")
    @ResponseBody
    public String addToWish(Wish wish)
    {
        int result = service.addToWish(wish);
        
        return result > 0 ? "??????????????? ??????????????? ????" : "???????????? ????????? ??????????????? ????";
    }
    
    // ?????? ?????? ??????
    @PostMapping(value = "/changeStatus", produces = "application/text; charset=utf8")
    @ResponseBody
    public String changeStatus(String status, int pCode)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("status", status);
        map.put("pCode", pCode);
        
        int result = service.changeStatus(map);
        
        return result > 0 ? "????????? ?????????????????? ????" : "?????? ????????? ??????????????? ????";
    }
    
    // ?????? ??????
    @GetMapping("/updateProduct")
    public String updateProduct(@RequestParam int pCode, @RequestParam String categoryName, Model model)
    {
        ProductVO product = service.selectVOByPCode(pCode);
        CouponDTO coupon = service.selectCoupon(product.getSeller());
        List<CategoryVO> category = service.selectAllCategory();
        List<ProductPhotoVO> photos = service.selectPhotos(pCode);
        
        for(ProductPhotoVO photo : photos)
            photo.setUploadPath(photo.getUploadPath().replace(File.separator, "/"));
        
        //?????? ????????? ???????????? ????????? ????????? ?????????
        List<String> userIdList = service.selectWishUserId(pCode);
        
        String userId = "";
        for(int i=0; i<userIdList.size(); i++) {
        	userId += userIdList.get(i) + " ";
        }
        
        model.addAttribute("userId", userId);
        model.addAttribute("product", product);
        model.addAttribute("coupon", coupon);
        model.addAttribute("category", category);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("photos", photos);
        model.addAttribute("pCode", pCode);
        
        return "product/update";
    }
    // ?????? ??????
    @PutMapping("/{pCode}")
    @ResponseBody
    public Map<String, Object> deleteMenu(@PathVariable int pCode)
    {
        Map<String, Object> map = new HashMap<>();
        
        String msg = "????????????????????? ????";
        
        try 
        {
            int result = service.delete(pCode);
        } 
        catch(Exception e) 
        {
            log.error("?????? ?????? ??????", e);
            msg = "????????? ??????????????? ????";
        }
        
        map.put("msg", msg);
        
        return map;
    }
    
    // ?????? ?????????
    @PostMapping("/hide/{pCode}")
    @ResponseBody
    public Map<String, Object> hideMenu(@PathVariable int pCode)
    {
        Map<String, Object> map = new HashMap<>();
        
        String msg = "???????????? ?????? ????";
        
        try 
        {
            int result = service.hide(pCode);
        } 
        catch(Exception e) 
        {
            log.error("????????? ??????", e);
            msg = "???????????? ??????????????? ????";
        }
        
        map.put("msg", msg);
        
        return map;
    }
    
    // ?????? ????????? ??????
    @PostMapping("/show/{pCode}")
    @ResponseBody
    public Map<String, Object> showMenu(@PathVariable int pCode)
    {
    	Map<String, Object> map = new HashMap<>();
    	
    	String msg = "?????? ?????? ?????? ????";
    	
    	try 
    	{
    		int result = service.show(pCode);
    	} 
    	catch(Exception e) 
    	{
    		log.error("????????? ?????? ??????", e);
    		msg = "????????? ????????? ??????????????? ????";
    	}
    	
    	map.put("msg", msg);
    	
    	return map;
    }
    
    // ??????
    @PutMapping("/pull/{price}/{pCode}")
    @ResponseBody
    public Map<String, Object> pull(@PathVariable String price, @PathVariable int pCode)
    {
        Map<String, Object> map = new HashMap<String, Object>();
        int result = 0;
        
        Map<String, Object> param = new HashMap<String, Object>();
        
        if(price.equals("x"))
            result = service.pull(pCode);
        else
        {
            param.put("price", Integer.parseInt(price));
            param.put("pCode", pCode);
            
            result = service.pull(param);
        }
        
        String msg = result > 0 ? "??????????????? ?????? ????" : "?????????????????? ??????????????? ????";
        
        map.put("msg", msg);
        
        return map;
    }   
    
    // ?????? ?????????
    @GetMapping("/report/{reasonCode}")
    @ResponseBody
    public List<ReasonReportVO> reportList(@PathVariable int reasonCode)
    {
        List<ReasonReportVO> reasonList = service.selectReportListByRCode(reasonCode);
        
        return reasonList;
    }
    
    // ?????? ????????? ??????
    @PostMapping(value = "/reportProduct", produces = "application/text; charset=utf8")
    @ResponseBody
    public String reportProduct(ReportVO report)
    {
        int result = service.reportProduct(report);
        
        return result > 0 ? "????????? ?????????????????????." : "?????? ??????????????????.";
    }
    
    // ?????? ??????
    @PostMapping(value = "/reportUser", produces = "application/text; charset=utf8")
    @ResponseBody
    public String reportUser(ReportVO report)
    {
        int result = service.reportUser(report);
        
        return result > 0 ? "????????? ?????????????????????." : "?????? ??????????????????.";
    }
    
    /* ======================== filepond ========================  */
    
    /*
     *      ?????????????????? ??????
     *      filepond??? ????????? ????????? ?????? ??????????????? ??????(?????????)????????? ????????? ???????????? ???????????? ???????????? ??????.
     */
    @RequestMapping("/boardSaveFile.do")
    @ResponseBody
    public String boardSaveFile(MultipartHttpServletRequest multipartReq,
                                HttpServletRequest request,
                                Model model, 
                                HttpSession session) throws Exception 
    {
        UUID uuid = UUID.randomUUID();

        // ------ make folder(yyyy/MM/dd) ------
        String uploadFolder = request.getServletContext().getRealPath("/resources/upload/");
        String uploadFolderPath = getFolder();
        File uploadPath = new File(uploadFolder, uploadFolderPath+File.separator+uuid);
        
        if(uploadPath.exists() == false)
            uploadPath.mkdirs();
        
        // ??? ?????? ????????? ?????? ??? ??????????????? ??????
        // filepond?????? ????????? ??????????????? ???????????? ????????? 1?????? ????????????.
        Map<String, MultipartFile> files = multipartReq.getFileMap();

        String uploadFileName = ""; // ???????????? ??????????????? ??????ID, filepond??? ??? ????????? ????????????.
        
        if (!files.isEmpty()) 
        {
              ProductPhotoVO photoDTO = new ProductPhotoVO();
             
            if (files != null) 
            {
                // ---------- iterator??? MultipartFile ????????? ----------
                Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
                MultipartFile multipartFile = null;
                
                while(itr.hasNext())
                {
                    Entry<String, MultipartFile> entry = itr.next();
                    multipartFile = entry.getValue();
                }
                
                // --------------- UUID ---------------
                uploadFileName = multipartFile.getOriginalFilename();
                uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
                
                photoDTO.setOriginalFilename(uploadFileName);
                photoDTO.setUuid(uuid.toString());
                photoDTO.setUploadPath(uploadFolderPath);
                
                // ?????? ?????? ???????????? insert
                // ????????? ??? ?????? ????????? ????????? ????????? ??????
                service.insert(photoDTO);
                
                // local??? ??????
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);
            }
        }
        
        return uuid.toString();
    }
    
    /*
     *      ???????????? ???????????? ????????????
     *      ?????? ????????? ???????????? ??????????????? ?????? ???????????? ??????????????? ??????
     *      ??????ID??? ????????? ????????? @RequestParam??? ??????????????? ??????. 
     */
    @PostMapping("/boardDeleteFile.do")
    @ResponseBody
    public String boardDeleteFiles(@RequestParam(value="fileId", required=true) String fileId, 
                                   Model model,
                                   HttpServletRequest request,
                                   HttpSession session) throws Exception 
    {
        // ?????? ?????? ??????
        String uploadFolder = request.getServletContext().getRealPath("/resources/upload/");
        File file = new File(uploadFolder + getFolder() +"\\" + URLDecoder.decode(fileId, "UTF-8"));
        
        File[] childFile = file.listFiles();
        for(File f : childFile)
            f.delete();
        
        file.delete();

        // DB ??????
        service.deleteFile(fileId);

        return "File removed!";
    }
    
    /* ????????? ?????? ?????? ????????? */
    private String getFolder()
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        
        return str.replace("-", File.separator);
    }
    
    /* ?????? ?????? ???????????? */
    @GetMapping("/evaList/{score}")
    @ResponseBody
    private List<Evaluation> evaList(@PathVariable int score)
    {
        int kind = score > 36 ? 1 : 0;
        
        List<Evaluation> evaList = service.selectEvaList(kind);
        
        return evaList;
    }
    @GetMapping("/evaListforBuyer/{score}")
    @ResponseBody
    private List<Evaluation> evaListforBuyer(@PathVariable int score)
    {
        int kind = score > 36 ? 1 : 0;
        
        List<Evaluation> evaList = service.selectEvaListforBuyer(kind);
        
        return evaList;
    }
    @GetMapping(value = "/{reviewCode}", produces = "application/text; charset=utf8")
    @ResponseBody
    private String reviewISent(@PathVariable int reviewCode)
    {
        String review = service.reviewISent(reviewCode);
        
        return review;
    }
    
    /* ???????????? - ?????? */
    @PostMapping("/insertReview")
    private String insertReview(ReviewDTO review, RedirectAttributes rttr)
    {
    	
    	log.debug("review = {}" , review);
    	
        int result = service.insertReview(review);
        
        rttr.addFlashAttribute("msg", result > 0 ? "?????? ?????? ?????? ????" : "?????? ?????? ?????? ????");
        rttr.addAttribute("pCode", review.getPCode());
        rttr.addAttribute("userId", review.getSender());
        
        return "redirect:/product/productDetailView";
    }
    @PostMapping("/insertReviewByBuyer")
    private String insertReviewByBuyer(ReviewDTO review, RedirectAttributes rttr)
    {
        int result = service.insertReviewByBuyer(review);
        
        rttr.addFlashAttribute("msg", result > 0 ? "?????? ?????? ?????? ????" : "?????? ?????? ?????? ????");
        rttr.addAttribute("userId", review.getSender());
        
        return "redirect:/member/buyList";
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}