package com.kh.udon.product.model.dao;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.member.model.vo.Wish;
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

@Repository
public class ProductDaoImpl implements ProductDao
{
    @Autowired
    private SqlSessionTemplate session;

    @Override
    public List<CategoryVO> selectAllCategory()
    {
        return session.selectList("product.selectAllCategory");
    }

    @Override
    public List<Integer> selectAllCategoryCount(String userId)
    {
        return session.selectList("product.selectAllCategoryCount", userId);
    }

    @Override
    public int selectTotalCount(String userId)
    {
        return session.selectOne("product.selectTotalCount", userId);
    }

    @Override
    public int selectCategoryCount(Map<String, Object> map)
    {
        return session.selectOne("product.selectCategoryCount", map);
    }

    @Override
    public CouponDTO selectCoupon(String userId)
    {
        return session.selectOne("product.selectCoupon", userId);
    }

    @Override
    public int insert(ProductVO product)
    {
        session.insert("product.insert", product);
        
        return product.getPCode();
    }

    @Override
    public List<ProductDTO> selectAll(PageInfo pi, String userId)
    {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
        return session.selectList("product.selectAll", userId, rowBounds);
    }

    @Override
    public List<ProductDTO> selectCategoryProducts(Map<String, Object> map, PageInfo pi)
    {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
        return session.selectList("product.selectCategoryProducts", map, rowBounds);
    }

    @Override
    public int addToWish(Wish wish)
    {
        return session.insert("product.addToWish", wish);
    }

    @Override
    public List<ProductDTO> search(Map<String, Object> map, PageInfo pi)
    {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
        return session.selectList("product.search", map, rowBounds);
    }

    @Override
    public int selectSearchCount(Map<String, Object> map)
    {
        return session.selectOne("product.selectSearchCount", map);
    }

    @Override
    public ProductDTO selectOneByPCode(int pCode)
    {
        return session.selectOne("product.selectDTOByPCode", pCode);
    }

    @Override
    public SellerDTO selectSeller(String id)
    {
        return session.selectOne("product.selectSeller", id);
    }

    @Override
    public int changeStatus(Map<String, Object> map)
    {
        return session.update("product.changeStatus", map);
    }

    @Override
    public ProductVO selectVOByPCode(int pCode)
    {
        return session.selectOne("product.selectVOByPCode", pCode);
    }

    @Override
    public int update(ProductVO productVO)
    {
        return session.update("product.update", productVO);
    }

    @Override
    public int delete(int pCode)
    {
        return session.update("product.delete", pCode);
    }

    @Override
    public int pull(int pCode)
    {
        return session.update("product.pull", pCode);
    }

    @Override
    public int pull(Map<String, Object> param)
    {
        return session.update("product.pullWithPrice", param);
    }

    @Override
    public List<ProductVO> selectSimilarProducts(Map<String, Object> map)
    {
        return session.selectList("product.selectSimilarProduct", map);
    }

    @Override
    public List<ProductDTO> selectOtherProducts(Map<String, Object> map)
    {
        return session.selectList("product.selectOtherProducts", map);
    }

    @Override
    public List<ReasonReportVO> selectReasonReport()
    {
        return session.selectList("product.reasonReport");
    }

    @Override
    public List<ReasonReportVO> selectReportListByRCode(int reasonCode)
    {
        return session.selectList("product.reportListByRCode", reasonCode);
    }

    @Override
    public int reportProduct(ReportVO report)
    {
        return session.insert("product.reportProduct", report);
    }

    @Override
    public int reportUser(ReportVO report)
    {
        return session.insert("product.reportUser", report);
    }
	
	@Override
	public List<String> selectWishUserId(int pCode) {
		return session.selectList("product.selectWishUserId",pCode);
	}

    @Override
    public int insert(ProductPhotoVO photoDTO)
    {
        return session.insert("product.insertPhoto", photoDTO);
    }

    @Override
    public int updateProductCode(Map<String, Object> map)
    {
        return session.update("product.updateProductCode", map);
    }

    @Override
    public void deleteFile(String uuid)
    {
        session.delete("product.deletePhoto", uuid);
    }

    @Override
    public List<ProductPhotoVO> selectPhotos(int pCode)
    {
        return session.selectList("product.selectPhotos", pCode);
    }

    @Override
    public ProductPhotoVO selectFile(ProductPhotoVO photo)
    {
        return session.selectOne("product.selectPhotos", photo);
    }

	@Override
	public List<Report> selectProductList(int limit, int offset) {
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("product.selectProductList", null,rowBounds);
	}

    @Override
    public List<String> selectBuyer(Map<String, Object> map)
    {
        return session.selectList("product.selectBuyer", map);
    }

    @Override
    public List<Evaluation> selectEvaList(int kind)
    {
        return session.selectList("product.selectEvaList", kind);
    }

    @Override
    public int insertEva(ReviewDTO review)
    {
        return session.update("product.insertEva", review);
    }

    @Override
    public int insertScore(ReviewDTO review)
    {
        return session.update("product.insertScore", review);
    }

    @Override
    public int insertReview(ReviewDTO review)
    {
        return session.insert("product.insertReview", review);
    }

    @Override
    public int updateBuyer(ReviewDTO review)
    {
        return session.update("product.updateBuyer", review);
    }

    @Override
    public List<Evaluation> selectEvaListforBuyer(int kind)
    {
        return session.selectList("product.selectEvaListForBuyer", kind);
    }

    @Override
    public int insertReviewByBuyer(ReviewDTO review)
    {
        return session.insert("product.insertReivewByBuyer", review);
    }

    @Override
    public int updateSeller(ReviewDTO review)
    {
        return session.update("product.updateSeller", review);
    }

    @Override
    public String reviewIsent(int reviewCode)
    {
        return session.selectOne("product.reviewISent", reviewCode);
    }

    @Override
    public List<ProductDTO> oneToTen()
    {
        return session.selectList("product.oneToTen");
    }

    @Override
    public List<ProductDTO> elevenToTwenty()
    {
        return session.selectList("product.elevenToTwenty");
    }

    @Override
    public int hide(int pCode)
    {
        return session.update("product.hide", pCode);
    }

    @Override
    public List<ProductDTO> popular(String userId)
    {
        return session.selectList("product.popular", userId);
    }

	@Override
	public int show(int pCode) {
		return session.update("product.show", pCode);
	}









    
    
    
}
