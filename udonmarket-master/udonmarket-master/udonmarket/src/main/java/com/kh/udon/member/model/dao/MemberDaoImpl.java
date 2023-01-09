package com.kh.udon.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.member.model.vo.Block;
import com.kh.udon.member.model.vo.Coupon;
import com.kh.udon.member.model.vo.Evaluate;
import com.kh.udon.member.model.vo.Keyword;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.Noti;
import com.kh.udon.member.model.vo.Review;
import com.kh.udon.member.model.vo.Wish;
import com.kh.udon.member.model.vo.announce;
import com.kh.udon.member.model.vo.rankSeller;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MemberDaoImpl implements MemberDao
{
    @Autowired
    private SqlSessionTemplate session;

	@Override
	public int updateLocation(Map<String, Object> map) {
		return session.update("member.updateLocation", map);
	}

	@Override
	public List<Keyword> selectKeywordList(String userId) {
		return session.selectList("member.selectKeywordList", userId);
	}

	@Override
	public int selectTotalKeywordContent(String userId) {
		return session.selectOne("member.selectTotalKeywordContent", userId);
	}

	@Override
	public int deleteKeyword(int keyCode) {
		return session.delete("member.deleteKeyword", keyCode);
	}

	@Override
	public Member selectOneMember(String userId) {
		return session.selectOne("member.selectOneMember", userId);
	}

	@Override
	public int selectRadius(String userId) {
		return session.selectOne("member.selectRadius", userId);
	}

	@Override
	public int updateRadius(Map<String, Object> map) {
		return session.update("member.updateRadius", map);
	}

	@Override
	public int updateAddr(Map<String, Object> map) {
		return session.update("member.updateAddr", map);
	}

	@Override
	public int selectKeyword(Map<String, Object> key) {
		return session.selectOne("member.selectKeyword", key);
	}

	@Override
	public List<Evaluate> selectAllEva(String userId) {
		return session.selectList("member.selectAllEva", userId);
	}

	@Override
	public int selectTotalReview(String userId) {
		return session.selectOne("member.selectTotalReview", userId);
	}

	@Override
	public List<Review> selectAllReview(String userId) {
		return session.selectList("member.selectAllReview", userId);
	}

	@Override
	public List<announce> selectAnnounceList(String userId) {
		return session.selectList("member.selectAnnounceList", userId);
	}

	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}
	public int insertMember(Map<String, Object> map) {
		return session.insert("member.insertMember", map);
	}

	@Override
	public int insertLocation(Map<String, Object> map) {
		return session.insert("member.insertLocation", map);
	}
	
	@Override
	public int insertAuthority(Map<String, Object> map) {
		return session.insert("member.insertAuthority", map);
	}
	
	@Override
	public int insertScore(Map<String, Object> map) {
		return session.insert("member.insertScore", map);
	}

	
	public List<Wish> selectAllSalesPro(String userId) {
		return session.selectList("member.selectAllSalesPro", userId);
	}

	@Override
	public List<Wish> selectAllBuyPro(String userId) {
		return session.selectList("member.selectAllBuyPro", userId);
	}

	@Override
	public List<Wish> selectAllWishPro(String userId) {
		return session.selectList("member.selectAllWishPro", userId);
	}

	@Override
	public int insertKeyword(Keyword key) {
		return session.insert("member.insertKeyword", key);
	}

	@Override
	public int deleteWish(int wishCode) {
		return session.delete("member.deleteWish", wishCode);
	}

	@Override
	public int insertWish(Map<String, Object> map) {
		return session.insert("member.insertWish", map);
	}

	@Override
	public List<Member> selectMemberList(int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("member.selectMemberList", null, rowBounds);
	}

	@Override
	public int selectMemberTotalContents() {
		return session.selectOne("member.selectMemberTotalContents");
	}

	@Override
	public int updateQuitMember(String userId) {
		return session.update("member.updateQuitMember", userId);
	}

	@Override
	public int announceEnroll(announce announce) {
		return session.insert("member.announceEnroll", announce);
	}

	@Override
	public announce selectOneAnnounce(int bCode,String userId) {
		return session.selectOne("member.selectOneAnnounce",bCode);
	}
	
    @Override
    public int insertEvaluate(Map<String, Object> map)
    {
        return session.update("member.insertEvaluate", map);
    }

	@Override
	public int updateNick(Member member) {
		return session.update("member.updateNick",member);
	}
	
	public List<Noti> selectAllNoti(String userId) {
		return session.selectList("socket.selectAllNoti", userId);
	}

	@Override
	public List<Community> selectPostList(String userId) {
		return session.selectList("member.selectPostList",userId);
	}
	
	public int insertNoti(Noti n) {
		return session.insert("socket.insertNoti", n);
	}

	@Override
	public List<Reply> selectReplyList(String userId) {
		return session.selectList("member.selectReplyList",userId);
	}
	
	public int updateNotiCheck(int notiCode) {
		return session.update("socket.updateNotiCheck", notiCode);
	}

	@Override
	public List<Coupon> selectCouponList(int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("coupon.selectCouponList", null, rowBounds);
	}

	@Override
	public int selectCouponTotalContents() {
		return session.selectOne("coupon.selectCouponTotalContents");
	}

	@Override
	public int updatePassword(Map<String, Object> paramMap) {
		return session.update("member.updatePassword", paramMap);
	}

	@Override
	public String selectGetPassword(Map<String, Object> paramMap) {
		return session.selectOne("member.selectGetPassword", paramMap);
	}

	@Override
	public int updateEncrpytPassword(Map<String, Object> paramMap) {
		return session.update("member.updateEncrpytPassword", paramMap);
	}

	public List<Block> selectAllBlockUser(String userId) {
		return session.selectList("member.selectAllBlockUser", userId);
	}

	@Override
	public int userIdCheck(String userId) {
		return session.selectOne("member.userIdCheck", userId);
	}

	@Override
	public int delete(int bCode) {
		return session.delete("member.delete", bCode);
	}
	
	public List<Report> selectDeclareMemberList(int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("member.selectDeclareMemberList", null, rowBounds);
	}
	
	@Override
	public List<Noti> selectAllNoti(String userId, int limit, int offset) {
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("socket.selectAllNoti", userId, rowBounds);
	}

	@Override
	public int selectNotiTotalContents(String userId) {
		return session.selectOne("socket.selectNotiTotalContents", userId);
	}

	@Override
	public boolean checkPwd(String userId,String password) {
		boolean result = false;
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("password", password);
		int count = session.selectOne("member.checkPwd",map);
		if(count == 1) 
			result = true;
		return result;
	}

	@Override
	public void updatePwd(Member member) {
		session.update("member.updatePwd", member);
	}
	
	public int insertBlockUser(Map<String, Object> map) {
		return session.insert("member.insertBlockUser", map);
	}

	@Override
	public int deleteBlockUser(Map<String, Object> map) {
		return session.delete("member.deleteBlockUser", map);
	}

	@Override
	public List<Keyword> selectAllkeywordList() {
		return session.selectList("member.selectAllkeywordList");
	}

	@Override
	public Member selectOnePasswordMember(String password) {
		return session.selectOne("member.selectOnePasswordMember", password);
	}

	@Override
	public int updateProfile(Member member) {
		return session.update("member.udpateProfile", member);
	}

	@Override
	public List<rankSeller> selectRankSeller(String format) {
		return session.selectList("member.selectRankSeller", format);
	}

	public int insertCoupon(Coupon coupon) {
		return session.insert("coupon.insertCoupon", coupon);
	}
}
