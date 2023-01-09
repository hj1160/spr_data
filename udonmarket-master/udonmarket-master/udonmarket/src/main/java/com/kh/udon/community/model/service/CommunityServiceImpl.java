package com.kh.udon.community.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.community.model.dao.CommunityDao;
import com.kh.udon.community.model.vo.Boardphoto;
import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.LikeThis;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.community.model.vo.Search;
import com.kh.udon.product.model.vo.ReasonReportVO;
import com.kh.udon.product.model.vo.ReportVO;

@Service
public class CommunityServiceImpl implements CommunityService
{
    @Autowired
    private CommunityDao dao;
    
    @Override
	public List<Community> selectCommunityList(Search search, PageInfo pi) {
		return dao.selectCommunityList(search, pi);
	}
    
    @Override
   	public List<Community> selectCommunityNewList(Search search) {
   		return dao.selectCommunityNewList(search);
   	}
    
    @Override
    public int selectCount(Map<String, Object> map)
    {
        return dao.selectCount(map);
    }
    
	/*
	 * @Override public List<Community> selectCommunityList(int categoryCode) {
	 * return dao.selectCommunityList(categoryCode); }
	 */
    
    @Override
	public Community selectOneCommunityCollection(int bCode) {
		return dao.selectOneCommunityCollection(bCode);
	}
    
//    @Override
//   	public Community selectCategory(int categoryCode) {
//   		return dao.selectCategory(categoryCode);
//   	}
    
    @Override

	public List<Reply> ReplyList(int bCode) throws Exception {

		return dao.ReplyList(bCode);

	}



	@Override

	public int saveReply(Reply reply) throws Exception {

		return dao.saveReply(reply);

	}



	@Override

	public int updateReply(Reply reply) throws Exception {

		return dao.updateReply(reply);

	}



	@Override

	public int deleteReply(int replyCode) throws Exception {

		return dao.deleteReply(replyCode);

	}
	
	@Override
    public int updateCommunityCode(Map<String, Object> map)
    {
        return dao.updateCommunityCode(map);
    }

	@Override
	
	public List<Report> selectReportList(int limit, int offset) {
		
		return dao.selectReportList(limit, offset);
		
	}

	@Override
	
	public List<Report> selectReplyList(int limit, int offset) {
		
		return dao.selectReplyList(limit,offset);
		
	}




	 @Override
	    public int insert(Community community)
	    {
	        return dao.insert(community);
	    }
	 
	 @Override
	    public int insert(Boardphoto boardphoto)
	    {
	        return dao.insert(boardphoto);
	    }
	 
	 @Override
	    public List<Boardphoto> selectPhotos(int bCode)
	    {
	        return dao.selectPhotos(bCode);
	    }
	 
	 @Override
	    public void deleteFile(String uuid)
	    {
	        dao.deleteFile(uuid);
	    }
	 
	 
	 @Override
	    public Community selectByBCode(int bCode)
	    {
	        return dao.selectByBCode(bCode);
	    }
	 
	 @Override
	    public int update(Community community)
	    {
	        return dao.update(community);
	    }

	 @Override
	    public int delete(int bCode)
	    {
	        return dao.delete(bCode);
	    }
    
	 @Override
	    public int likeThis(LikeThis like)
	    {
	        return dao.likeThis(like);
	    }
	 
	 @Override
	 public List<ReasonReportVO> selectReasonReport()
	    {
	        return dao.selectReasonReport();
	    }
	 
	 @Override
	 public List<ReasonReportVO> selectReasonReport2()
	    {
	        return dao.selectReasonReport2();
	    }
	 
	 @Override
	    public List<ReasonReportVO> selectReportListByRCode(int reasonCode)
	    {
	        return dao.selectReportListByRCode(reasonCode);
	    }
	 
	 @Override
	    public int reportBoard(ReportVO report)
	    {
	        return dao.reportBoard(report);
	    }

	    @Override
	    public int reportUser(ReportVO report)
	    {
	        return dao.reportUser(report);
	    }
	    
	    @Override
	    public List<ReasonReportVO> selectReportListByRCode2(int reasonCode)
	    {
	        return dao.selectReportListByRCode2(reasonCode);
	    }
	 
	 @Override
	    public int reportReply(ReportVO report)
	    {
	        return dao.reportReply(report);
	    }
}
