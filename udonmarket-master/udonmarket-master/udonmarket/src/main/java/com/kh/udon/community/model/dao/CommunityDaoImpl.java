package com.kh.udon.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.community.model.vo.Boardphoto;
import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.LikeThis;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.community.model.vo.Search;
import com.kh.udon.product.model.vo.ProductPhotoVO;
import com.kh.udon.product.model.vo.ReasonReportVO;
import com.kh.udon.product.model.vo.ReportVO;


@Repository
public class CommunityDaoImpl implements CommunityDao
{
    @Autowired
    private SqlSessionTemplate session;
    
    @Override
	public List<Community> selectCommunityList(Search search, PageInfo pi) {
//		RowBounds rowBounds = new RowBounds();
    	
    	int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        
		return session.selectList("community.selectCommunityList", search, rowBounds);
	}
    
    @Override
	public List<Community> selectCommunityNewList(Search search) {
//		
        
		return session.selectList("community.selectCommunityNewList", search);
	}
    
    @Override
    public int selectCount(Map<String, Object> map)
    {
        return session.selectOne("community.selectCount", map);
    }
	/*
	 * @Override public List<Community> selectCommunityList(int categoryCode) { //
	 * RowBounds rowBounds = new RowBounds(); return
	 * session.selectList("community.selectCommunityList", categoryCode); }
	 */
    
    @Override
	public Community selectOneCommunityCollection(int bCode) {
		return session.selectOne("community.selectOneCommunityCollection", bCode);
	}
    
//    @Override
//	public Community selectCategory(int categoryCode) {
//		return session.selectOne("community.selectCategory", categoryCode);
//	}
    
    @Override

	public List<Reply> ReplyList(int bCode) throws Exception {

		return session.selectList("communityReply.ReplyList", bCode);

	}



	@Override

	public int saveReply(Reply reply) throws Exception {

		return session.insert("communityReply.saveReply", reply);

	}



	@Override

	public int updateReply(Reply reply) throws Exception {

		return session.update("communityReply.updateReply", reply);

	}



	@Override

	public int deleteReply(int replyCode) throws Exception {

		return session.delete("communityReply.deleteReply", replyCode);

	}
	
	 @Override
	    public int insert(Community community)
	    {
	        session.insert("community.insert", community);
	        return community.getBCode();
	    }
	 
	 @Override
	    public int insert(Boardphoto boardphoto)
	    {
	        return session.insert("community.insertPhoto", boardphoto);
	    }
	 
	 @Override
	    public List<Boardphoto> selectPhotos(int bCode)
	    {
	        return session.selectList("community.selectPhotos", bCode);
	    }
	 
	 @Override
	    public void deleteFile(String uuid)
	    {
	        session.delete("community.deletePhoto", uuid);
	    }
	 
	 @Override
	    public Community selectByBCode(int bCode)
	    {
	        return session.selectOne("community.selectByBCode", bCode);
	    }
	 
	 @Override
	    public int update(Community community)
	    {
	        return session.update("community.update", community);
	    }

	 @Override
	    public int delete(int bCode)
	    {
	        return session.delete("community.delete", bCode);
	    }

	 @Override
	    public int likeThis(LikeThis like)
	    {
	        return session.insert("community.createBoardLike", like);
	    }
	 
	 @Override
	    public int updateCommunityCode(Map<String, Object> map)
	    {
	        return session.update("community.updateCommunityCode", map);
	    }

	 
	@Override
	
	public List<Report> selectReportList(int limit, int offset) {
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("community.selectReportList", null, rowBounds);
		
	}


	@Override
	
	public List<Report> selectReplyList(int limit, int offset) {

		RowBounds rowBounds = new RowBounds(offset, limit);

		return session.selectList("communityReply.selectReplyList", null, rowBounds);
		
	}
	
	@Override
    public List<ReasonReportVO> selectReasonReport()
    {
        return session.selectList("community.reasonReport");
    }
	@Override
    public List<ReasonReportVO> selectReasonReport2()
    {
        return session.selectList("community.reasonReport2");
    }
	
	@Override
    public List<ReasonReportVO> selectReportListByRCode(int reasonCode)
    {
        return session.selectList("community.reportListByRCode", reasonCode);
    }
	
	@Override
    public int reportBoard(ReportVO report)
    {
        return session.insert("community.reportBoard", report);
    }
	
	@Override
    public List<ReasonReportVO> selectReportListByRCode2(int reasonCode)
    {
        return session.selectList("community.reportListByRCode2", reasonCode);
    }
	
	@Override
    public int reportReply(ReportVO report)
    {
        return session.insert("community.reportReply", report);
    }


    @Override
    public int reportUser(ReportVO report)
    {
        return session.insert("community.reportUser", report);
    }
	
	
}
