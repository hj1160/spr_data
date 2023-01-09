package com.kh.udon.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.udon.member.model.vo.Coupon;
import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.member.model.vo.Block;
import com.kh.udon.member.model.vo.Evaluate;
import com.kh.udon.member.model.vo.Keyword;
import com.kh.udon.member.model.vo.Location;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.Noti;
import com.kh.udon.member.model.vo.Review;
import com.kh.udon.member.model.vo.announce;
import com.kh.udon.member.model.vo.rankSeller;
import com.kh.udon.member.model.vo.Wish;
import com.kh.udon.product.model.vo.ProductVO;

public interface MemberDao
{

	int updateLocation(Map<String, Object> map);

	List<Keyword> selectKeywordList(String userId);

	int selectTotalKeywordContent(String userId);

	int deleteKeyword(int keyCode);

	Member selectOneMember(String userId);

	int selectRadius(String userId);

	int updateRadius(Map<String, Object> map);

	int updateAddr(Map<String, Object> map);

	int selectKeyword(Map<String, Object> key);

	List<Evaluate> selectAllEva(String userId);

	int selectTotalReview(String userId);

	List<Review> selectAllReview(String userId);

	int insertMember(Member member);
	
	int insertMember(Map<String, Object> map);

	int insertLocation(Map<String, Object> map);

	int insertAuthority(Map<String, Object> map);

	int insertScore(Map<String, Object> map);
	
	List<Wish> selectAllSalesPro(String userId);

	List<Wish> selectAllBuyPro(String userId);

	List<Wish> selectAllWishPro(String userId);

	int insertKeyword(Keyword key);

	int deleteWish(int wishCode);

	int insertWish(Map<String, Object> map);

	List<Member> selectMemberList(int limit, int offset);

	int selectMemberTotalContents();

	int updateQuitMember(String userId);

	int announceEnroll(announce announce);

	announce selectOneAnnounce(int bCode, String userId);

    int insertEvaluate(Map<String, Object> map);

	int updateNick(Member member);

	List<Community> selectPostList(String userId);

	List<Reply> selectReplyList(String userId);

	List<Noti> selectAllNoti(String userId);

	int insertNoti(Noti n);

	int updateNotiCheck(int notiCode);

	List<Coupon> selectCouponList(int limit, int offset);

	int selectCouponTotalContents();

	int updatePassword(Map<String, Object> paramMap);

	String selectGetPassword(Map<String, Object> paramMap);

	int updateEncrpytPassword(Map<String, Object> paramMap);
	
	List<Block> selectAllBlockUser(String userId);

	int userIdCheck(String userId);

	List<announce> selectAnnounceList(String userId);

	int delete(int bCode);

	List<Report> selectDeclareMemberList(int limit, int offset);

	List<Noti> selectAllNoti(String userId, int limit, int offset);

	int selectNotiTotalContents(String userId);

	boolean checkPwd(String userId,String password);

	void updatePwd(Member member);

	int insertBlockUser(Map<String, Object> map);

	int deleteBlockUser(Map<String, Object> map);

	List<Keyword> selectAllkeywordList();

	Member selectOnePasswordMember(String password);

	int updateProfile(Member member);

	List<rankSeller> selectRankSeller(String format);

	int insertCoupon(Coupon coupon);

}
