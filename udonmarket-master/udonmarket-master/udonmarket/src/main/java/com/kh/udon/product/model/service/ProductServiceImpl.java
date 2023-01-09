package com.kh.udon.product.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.member.model.vo.Wish;
import com.kh.udon.product.model.dao.ProductDao;
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

@Service
public class ProductServiceImpl implements ProductService
{
    @Autowired
    private ProductDao dao;

    @Override
    public List<CategoryVO> selectAllCategory()
    {
        return dao.selectAllCategory();
    }

    @Override
    public List<Integer> selectAllCategoryCount(String userId)
    {
        return dao.selectAllCategoryCount(userId);
    }

    @Override
    public int selectTotalCount(String userId)
    {
        return dao.selectTotalCount(userId);
    }

    @Override
    public int selectCategoryCount(Map<String, Object> map)
    {
        return dao.selectCategoryCount(map);
    }

    @Override
    public CouponDTO selectCoupon(String userId)
    {
        return dao.selectCoupon(userId);
    }

    @Override
    public int insert(ProductVO product)
    {
        return dao.insert(product);
    }

    @Override
    public List<ProductDTO> selectAll(PageInfo pi, String userId)
    {
        return dao.selectAll(pi, userId);
    }

    @Override
    public List<ProductDTO> selectCategoryProducts(Map<String, Object> map, PageInfo pi)
    {
        return dao.selectCategoryProducts(map, pi);
    }

    @Override
    public int addToWish(Wish wish)
    {
        return dao.addToWish(wish);
    }

    @Override
    public List<ProductDTO> search(Map<String, Object> map, PageInfo pi)
    {
        return dao.search(map, pi);
    }

    @Override
    public int selectSearchCount(Map<String, Object> map)
    {
        return dao.selectSearchCount(map);
    }

    @Override
    public ProductDTO selectDTOByPCode(int pCode)
    {
        return dao.selectOneByPCode(pCode);
    }

    @Override
    public SellerDTO selectSeller(String id)
    {
        return dao.selectSeller(id);
    }

    @Override
    public int changeStatus(Map<String, Object> map)
    {
        return dao.changeStatus(map);
    }

    @Override
    public ProductVO selectVOByPCode(int pCode)
    {
        return dao.selectVOByPCode(pCode);
    }

    @Override
    @Transactional
    public int update(Map<String, Object> map)
    {
        /*
         *      1. 수정 사진 pCode 업데이트
         *      2. 게시판 수정
         */
        int result = 0;
        
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("uuids", (String[])map.get("uuids"));
        param.put("pCode", ((ProductVO) map.get("product")).getPCode());
        
        result = dao.updateProductCode(param);
        result = dao.update((ProductVO) map.get("product"));
        
        return result;
    }

    @Override
    public int delete(int pCode)
    {
        return dao.delete(pCode);
    }

    @Override
    public int pull(int pCode)
    {
        return dao.pull(pCode);
    }

    @Override
    public int pull(Map<String, Object> param)
    {
        return dao.pull(param);
    }

    @Override
    public List<ProductVO> selectSimilarProducts(Map<String, Object> map)
    {
        return dao.selectSimilarProducts(map);
    }

    @Override
    public List<ProductDTO> selectOtherProducts(Map<String, Object> map)
    {
        return dao.selectOtherProducts(map);
    }

    public List<ReasonReportVO> selectReasonReport()
    {
        return dao.selectReasonReport();
    }

    @Override
    public List<ReasonReportVO> selectReportListByRCode(int reasonCode)
    {
        return dao.selectReportListByRCode(reasonCode);
    }

    @Override
    public int reportProduct(ReportVO report)
    {
        return dao.reportProduct(report);
    }

    @Override
    public int reportUser(ReportVO report)
    {
        return dao.reportUser(report);
    }

	@Override
	public List<String> selectWishUserId(int pCode) {
		return dao.selectWishUserId(pCode);
	}

    @Override
    public int insert(ProductPhotoVO photoDTO)
    {
        return dao.insert(photoDTO);
    }

    @Override
    public int updateProductCode(Map<String, Object> map)
    {
        return dao.updateProductCode(map);
    }

    @Override
    public void deleteFile(String uuid)
    {
        dao.deleteFile(uuid);
    }

    @Override
    public List<ProductPhotoVO> selectPhotos(int pCode)
    {
        return dao.selectPhotos(pCode);
    }

    @Override
    public ProductPhotoVO selectFile(ProductPhotoVO photo)
    {
        return dao.selectFile(photo);
    }

	@Override
	public List<Report> selectProductList(int limit, int offset) {
		
		return dao.selectProductList(limit, offset);
		
	}

    @Override
    public List<String> selectBuyer(Map<String, Object> map)
    {
        return dao.selectBuyer(map);
    }

    @Override
    public List<Evaluation> selectEvaList(int kind)
    {
        return dao.selectEvaList(kind);
    }

    @Override
    @Transactional
    public int insertReview(ReviewDTO review)
    {
        /*
         *      1. 평가
         *      2. score(거래온도)
         *      3. review
         *      4. product buyer update
         */
        
        int result = 0;
        
        result = dao.insertEva(review);
        result = dao.insertScore(review);
        result = dao.insertReview(review);
        result = dao.updateBuyer(review);
                
        return result;
    }
    
    @Override
    public int insertReviewByBuyer(ReviewDTO review)
    {
        int result = 0;
        
        result = dao.insertEva(review);
        result = dao.insertScore(review);
        result = dao.insertReviewByBuyer(review);
        result = dao.updateSeller(review);
        
        return result;
    }

    @Override
    public List<Evaluation> selectEvaListforBuyer(int kind)
    {
        return dao.selectEvaListforBuyer(kind);
    }

    @Override
    public String reviewISent(int reviewCode)
    {
        return dao.reviewIsent(reviewCode);
    }

    @Override
    public List<ProductDTO> oneToTen()
    {
        return dao.oneToTen();
    }

    @Override
    public List<ProductDTO> elevenToTwenty()
    {
        return dao.elevenToTwenty();
    }

    @Override
    public int hide(int pCode)
    {
        return dao.hide(pCode);
    }

    @Override
    public List<ProductDTO> popular(String userId)
    {
        return dao.popular(userId);
    }

	@Override
	public int show(int pCode) {
		return dao.show(pCode);
	}



    
    
    
    
}
