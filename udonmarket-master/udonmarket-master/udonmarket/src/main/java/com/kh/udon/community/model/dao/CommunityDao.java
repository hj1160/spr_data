package com.kh.udon.community.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.udon.common.model.vo.PageInfo;
import com.kh.udon.community.model.vo.Boardphoto;
import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.LikeThis;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.community.model.vo.Search;
import com.kh.udon.product.model.vo.ReasonReportVO;
import com.kh.udon.product.model.vo.ReportVO;


public interface CommunityDao
{

	List<Community> selectCommunityList(Search search, PageInfo pi);
	List<Community> selectCommunityNewList(Search search);
	/* List<Community> selectCommunityList(int categoryCode); */
	
	int selectCount(Map<String, Object> map);
	
	Community selectOneCommunityCollection(int bCode);
	
//	Community selectCategory(int categoryCode);
	
	public List<Reply> ReplyList(int bCode) throws Exception;

	

	public int saveReply(Reply reply) throws Exception;

	

	public int updateReply(Reply reply) throws Exception;

	

	public int deleteReply(int replyCode) throws Exception;

	List<Report> selectReportList(int limit, int offset);

	List<Report> selectReplyList(int limit, int offset);
	
	List<ReasonReportVO> selectReasonReport();
	
	List<ReasonReportVO> selectReasonReport2();
	
	
	List<ReasonReportVO> selectReportListByRCode(int reasonCode);

	
	
	int insert(Community community);
	
	int insert(Boardphoto boardphoto);
	
	List<Boardphoto> selectPhotos(int bCode);
	
	void deleteFile(String uuid);
	
	Community selectByBCode(int bCode);
	
	int update(Community community);
	
	int delete(int bCode);
	
	int likeThis(LikeThis like);
	
	int updateCommunityCode(Map<String, Object> map);
	
	int reportBoard(ReportVO report);
	
	List<ReasonReportVO> selectReportListByRCode2(int reasonCode);
	
	int reportReply(ReportVO report);

    int reportUser(ReportVO report);

	
}
