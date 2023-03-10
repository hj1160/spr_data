package com.kh.udon.community.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.common.template.Pagination;
import com.kh.udon.community.model.service.CommunityService;
import com.kh.udon.community.model.vo.Boardphoto;
import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.LikeThis;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Search;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.product.model.vo.ReasonReportVO;
import com.kh.udon.product.model.vo.ReportVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/community")
@Slf4j
public class CommunityController
{
    @Autowired
    private CommunityService service;
    
//    @Autowired
//	ServletContext servletContext;
//	
//	@Autowired
//	ResourceLoader resourceLoader;
    
    // ????????? ????????? & ??????
    @RequestMapping("/communityListView")
	public String CommunityList(/* @RequestParam int categoryCode, */
    						Model model, int currentPage
    						, @RequestParam(required = false, defaultValue = "board_title") String searchType
    						, @RequestParam(required = false) String keyword
    						, @RequestParam(required = false) String categoryCode
    						, @RequestParam(required = false) String hashtagCode
    						, @RequestParam(required = false, value="userId") String userId) {

    	
		    	Search search = new Search();
		    	
		    	Map<String, Object> map = new HashMap<String, Object>();
		        map.put("categoryCode", categoryCode);
		        map.put("userId", userId);

		
				search.setSearchType(searchType);
		
				search.setKeyword(keyword);
				
				search.setCategoryCode(categoryCode);
				
				search.setHashtagCode(hashtagCode);
				
				search.setUserId(userId);
				
				int totalCount = service.selectCount(map);
				
			
				PageInfo pi = Pagination.getPageInfo(totalCount, currentPage, 10, 10);
				List<Community> list = service.selectCommunityList(search, pi);

				log.debug("list = {}", list);

				model.addAttribute("list", list);
				model.addAttribute("pi", pi);

				return "community/communityListView";
    }
    
    // ????????? ????????????
    @RequestMapping("/communityDetailView")
    public String communityDetail(@RequestParam(value="bCode") int bCode, @RequestParam(value="userId") String userId,
			  Model model,
			  @RequestParam(required = false, defaultValue = "board_title") String searchType
				, @RequestParam(required = false) String keyword,Member member) throws Exception {
		
    	Search search = new Search();
		
		search.setSearchType(searchType);

		search.setKeyword(keyword);
		
		search.setUserId(userId);
		
		
		
    	
    			Community community = service.selectOneCommunityCollection(bCode);
    			List<Community> list = service.selectCommunityNewList(search);
    			List<Reply> replyList = service.ReplyList(bCode);
    			List<ReasonReportVO> reasonReport = service.selectReasonReport();
    			List<ReasonReportVO> reasonReport2 = service.selectReasonReport2();
    			List<Boardphoto> photos = service.selectPhotos(bCode);
    			log.debug("Community = {}", community);
				log.debug("list = {}", list);
				
				

    			model.addAttribute("community", community);
    			model.addAttribute("list", list);
    			model.addAttribute("replyList", replyList);
    			model.addAttribute("reasonReport", reasonReport);
    			model.addAttribute("reasonReport2", reasonReport2);
    			model.addAttribute("photos", photos);
    			model.addAttribute("member", member);
    			
    			return "community/communityDetailView";
    }
    
    /* ?????? ???????????? */
    @GetMapping(value = "/getPhotos", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<Boardphoto>> getPhotos(int bCode)
    {
        return new ResponseEntity<List<Boardphoto>>(service.selectPhotos(bCode), HttpStatus.OK);
    }
    
    // ????????? ??????
    @GetMapping("/communityForm")
	public String communityForm(/* @RequestParam String userId */) {
    	
    	return "community/communityForm";
    	
    }
    @PostMapping("/communityForm")
    public String register(Community community, HttpServletRequest req, RedirectAttributes rttr)
    {
    	
    	 int result = 0;
         
         // -------------------- uuid ?????? --------------------
         String[] uuid = req.getParameterValues("uploadFile"); 
         
         for(String s : uuid)
             log.debug("uuid = {}", s);
         
         int bCode = service.insert(community);
         
         if (uuid.length > 0) 
         {
             Map<String, Object> map = new HashMap<>();
             map.put("bCode", bCode);
             map.put("uuids", uuid);
             
             result = service.updateCommunityCode(map);

         }
         
        
		
//		rttr.addFlashAttribute("msg", result > 0 ? "????????? ?????? ?????? ????" : "????????? ?????? ?????? ????");
		rttr.addFlashAttribute("msg", "????????? ?????? ?????? ????");
		rttr.addAttribute("userId", community.getUserId());
		 
        
        return "redirect:/community/communityListView?currentPage=1";
    }
    
    //?????????
    @RequestMapping("/likeThis")
    public String likeThis(@RequestParam int bCode, @RequestParam String userId, Model model) {
    	
    	LikeThis like = new LikeThis();
    	
    	like.setBCode(bCode);
    	like.setUserId(userId);
    	
    	service.likeThis(like);
    	
    	return "redirect:/community/communityDetailView?userId=" + userId + "&bCode=" + bCode;
    	
    }

    // ?????? ??????
	@RequestMapping(value="/saveReply", method = RequestMethod.POST)
	public String saveReply(Reply reply, @RequestParam(value="userId") String userId, RedirectAttributes rttr) throws Exception {
		log.info("saveReply");
		
		service.saveReply(reply);
		
		rttr.addAttribute("bCode", reply.getBCode());

		
		return "redirect:/community/communityDetailView?userId=" + userId + "&bCode={bCode}";
	}
	
	// ?????? ??????
	@RequestMapping("/deleteReply")
    public String deleteReply(@RequestParam int replyCode, @RequestParam int bCode, @RequestParam String userId, Model model)
    {
//        Map<String, Object> map = new HashMap<>();
        
//        String msg = "????????????????????? ????";
        
        try 
        {
            int result = service.deleteReply(replyCode);
        } 
        catch(Exception e) 
        {
//        	e.printStackTrace();
//            log.error("?????? ?????? ??????", e);
//            msg = "????????? ??????????????? ????";
        }
        
//        map.put("msg", msg);
        
        
        return "redirect:/community/communityDetailView?userId=" + userId + "&bCode=" + bCode;
        
    }
	
	 // ????????? ??????
    @PutMapping("/{bCode}")
    @ResponseBody
    public Map<String, Object> deleteBoard(@PathVariable int bCode)
    {
        Map<String, Object> map = new HashMap<>();
        
        String msg = "????????????????????? ????";
        
        try 
        {
            int result = service.delete(bCode);
        } 
        catch(Exception e) 
        {
        	e.printStackTrace();
            log.error("?????? ?????? ??????", e);
            msg = "????????? ??????????????? ????";
        }
        
        map.put("msg", msg);
        
        return map;
    }
    
    // ????????? ??????
    @GetMapping("/updateBoard")
    public String updateBoard(@RequestParam int bCode, Model model)
    {
        Community community = service.selectByBCode(bCode);
        
        model.addAttribute("community", community);
        
        return "community/communityUpdateForm";
    }
    @PostMapping("/update")
    public String update(Community community, @RequestParam String userId, RedirectAttributes rttr)
    {
        log.debug("community = {}", community);
        
        int result = service.update(community);
        
        
        rttr.addFlashAttribute("msg", result > 0 ? "????????? ?????? ?????? ????" : "????????? ?????? ?????? ????");
        
        return "redirect:/community/communityListView?currentPage=1&userId=" + userId;
    }
    
    
    // ????????? ?????? ?????????
    @GetMapping("/report/{reasonCode}")
    @ResponseBody
    public List<ReasonReportVO> reportList(@PathVariable int reasonCode)
    {
        List<ReasonReportVO> reasonList = service.selectReportListByRCode(reasonCode);
        
        return reasonList;
    }
    
    // ????????? ??????
    @PostMapping(value = "/reportBoard", produces = "application/text; charset=utf8")
    @ResponseBody
    public String reportBoard(ReportVO report)
    {
        int result = service.reportBoard(report);
        
        return result > 0 ? "????????? ?????????????????????." : "?????? ??????????????????.";
    }
    
 // ?????? ?????? ?????????
    @GetMapping("/report2/{reasonCode}")
    @ResponseBody
    public List<ReasonReportVO> reportList2(@PathVariable int reasonCode)
    {
        List<ReasonReportVO> reasonList2 = service.selectReportListByRCode2(reasonCode);
        
        return reasonList2;
    }
    
    // ?????? ??????
    @PostMapping(value = "/reportReply", produces = "application/text; charset=utf8")
    @ResponseBody
    public String reportReply(ReportVO report)
    {
        int result = service.reportReply(report);
        
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
    
	/*
	 * @GetMapping("/getData")
	 * 
	 * @ResponseBody public List<Integer> getData(@RequestParam int page) { int
	 * start = (page * 10) + 1; int end = start + 10;
	 * 
	 * log.info("page={}, {}..{}",page,start,end);
	 * 
	 * List<Integer> list = new ArrayList()<>(); for (int i = start; i < end; i++) {
	 * list.add(i); }
	 * 
	 * return list; }
	 */
    
    
    
    
    /* ????????? ?????? ?????? ????????? */
    private String getFolder()
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String str = sdf.format(date);
        
        return str.replace("-", File.separator);
    }
    
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
               Boardphoto boardphoto = new Boardphoto();
              
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
                 
                 boardphoto.setOriginalFilename(uploadFileName);
                 boardphoto.setUuid(uuid.toString());
                 boardphoto.setUploadPath(uploadFolderPath);
                 
                 // ?????? ?????? ???????????? insert
                 // ????????? ??? ?????? ????????? ????????? ????????? ??????
                 service.insert(boardphoto);
                 
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
        
        file.delete();

        // DB ??????
        String uuid = fileId.substring(0, fileId.indexOf("_"));
        service.deleteFile(uuid);

        return "File removed!";
    }
    
   
    
}







