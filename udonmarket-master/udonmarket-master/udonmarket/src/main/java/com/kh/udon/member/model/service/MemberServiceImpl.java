package com.kh.udon.member.model.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.member.model.dao.MemberDao;

import com.kh.udon.member.model.vo.Coupon;

import com.kh.udon.member.model.vo.Block;

import com.kh.udon.member.model.vo.Evaluate;
import com.kh.udon.member.model.vo.Keyword;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.Noti;
import com.kh.udon.member.model.vo.Review;
import com.kh.udon.member.model.vo.announce;
import com.kh.udon.member.model.vo.rankSeller;
import com.kh.udon.member.model.vo.Wish;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService
{
    @Autowired
    private MemberDao memberDao;
    
    @Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	public List<Keyword> selectKeywordList(String userId) {
		return memberDao.selectKeywordList(userId);
	}

	@Override
	public int selectTotalKeywordContent(String userId) {
		return memberDao.selectTotalKeywordContent(userId);
	}

	@Override
	public int deleteKeyword(int keyCode) {
		return memberDao.deleteKeyword(keyCode);
	}

	@Override
	public Member selectOneMember(String userId) {
		return memberDao.selectOneMember(userId);
	}

	@Override
	public int selectRadius(String userId) {
		return memberDao.selectRadius(userId);
	}

	@Override
	public int updateRadius(Map<String, Object> map) {
		return memberDao.updateRadius(map);
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int updateAddrAndLoc(Map<String, Object> map) {
		int result = 0;
		
		result = memberDao.updateLocation(map);		
		if(result > 0) { 
			result = memberDao.updateAddr(map);
		}else {
//			throw new MemberException("주소 변경 오류!");
		}
		
		return result;
	}

	@Override
	public int selectKeyword(Map<String, Object> key) {
		return memberDao.selectKeyword(key);
	}

	@Override
	public List<Evaluate> selectAllEva(String userId) {
		return memberDao.selectAllEva(userId);
	}

	@Override
	public int selectTotalReview(String userId) {
		return memberDao.selectTotalReview(userId);
	}

	@Override
	public List<Review> selectAllReview(String userId) {
		return memberDao.selectAllReview(userId);
	}

	@Override
	public List<announce> selectAnnounceList(String userId) {
		return memberDao.selectAnnounceList(userId);
	}
		
	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int insertMemberLocAuthScoreEvaluate(Map<String, Object> map) {
		
		int result = 0;
				
		result = memberDao.insertMember(map);
		log.debug("result = {}", result);
		log.debug("map = {}", map);

		
		if(result > 0) {
			result = memberDao.insertLocation(map);
			log.debug("result = {}", result);
			result = memberDao.insertAuthority(map);
			log.debug("result = {}", result);
			result = memberDao.insertScore(map);
			log.debug("result = {}", result);
			result = memberDao.insertEvaluate(map);
			log.debug("result = {}", result);
		}
		
		return result;
	}
	@Override
	public List<Wish> selectAllSalesPro(String userId) {
		return memberDao.selectAllSalesPro(userId);
	}

	@Override
	public List<Wish> selectAllBuyPro(String userId) {
		return memberDao.selectAllBuyPro(userId);
	}

	@Override
	public List<Wish> selectAllWishPro(String userId) {
		return memberDao.selectAllWishPro(userId);
	}

	@Override
	public int insertKeyword(Keyword key) {
		return memberDao.insertKeyword(key);
	}

	@Override
	public int deleteWish(int wishCode) {
		return memberDao.deleteWish(wishCode);
	}

	@Override
	public int insertWish(Map<String, Object> map) {
		return memberDao.insertWish(map);
	}

	@Override
	public List<Member> selectMemberList(int limit, int offset) {
		return memberDao.selectMemberList(limit, offset);
	}

	@Override
	public int selectMemberTotalContents() {
		return memberDao.selectMemberTotalContents();
	}

	@Override
	public int updateQuitMember(String userId) {
		return memberDao.updateQuitMember(userId);
	}

	@Override
	public int announceEnroll(announce announce) {
		return memberDao.announceEnroll(announce);
	}

	@Override
	public announce selectOneAnnounce(int bCode,String userId) {
		return memberDao.selectOneAnnounce(bCode,userId);
	}

	@Override
	public int insertMemberLocAuth(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteMember(String userId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateNick(Member member) {
		return memberDao.updateNick(member);
		
	}

	@Override
	public List<Community> selectPostList(String userId) {
		return memberDao.selectPostList(userId);
	}

	@Override
	public List<Reply> selectReplyList(String userId) {
		return memberDao.selectReplyList(userId);
	}

	public List<Noti> selectAllNoti(String userId) {
		return memberDao.selectAllNoti(userId);
	}

	@Override
	public int insertNoti(Noti n) {
		return memberDao.insertNoti(n);
	}

	@Override
	public int updateNotiCheck(int notiCode) {
		return memberDao.updateNotiCheck(notiCode);
	}

	@Override
	public List<Coupon> selectCouponList(int limit, int offset) {
		return memberDao.selectCouponList(limit, offset);
	}

	@Override
	public int selectCouponTotalContents() {
		return memberDao.selectCouponTotalContents();
	}

	@Override
	public int updatePasswordEncrypt(Map<String, Object> paramMap) {
		
		int result =0;
		
		result = memberDao.updatePassword(paramMap);
		log.debug("result1 = {}", result);
		
		if(result > 0 ) {
			String convertPassword = memberDao.selectGetPassword(paramMap);
			String encryptConvertPassword = bcryptPasswordEncoder.encode(convertPassword);
			paramMap.put("param1", encryptConvertPassword);
			log.debug("paramMap = {}", paramMap);
			result = memberDao.updateEncrpytPassword(paramMap);
			log.debug("result2 = {}", result);	
		}
		return	result;
	}

	public List<Block> selectAllBlockUser(String userId) {
		return memberDao.selectAllBlockUser(userId);
	}

	@Override
	public int userIdCheck(String userId) {
		return memberDao.userIdCheck(userId);
	}

	@Override
	public int delete(int bCode) {
		return memberDao.delete(bCode);
	}
	
	@Override
	public List<Report> selectDeclareMemberList(int limit, int offset) {
		return memberDao.selectDeclareMemberList(limit,offset);
	}
	
	@Override
	public List<Noti> selectAllNoti(String userId, int limit, int offset) {
		return memberDao.selectAllNoti(userId, limit, offset);
	}

	@Override
	public int selectNotiTotalContents(String userId) {
		return memberDao.selectNotiTotalContents(userId);
	}
	
	@Override
	public boolean checkPwd(String userId,String password) {
		return memberDao.checkPwd(userId,password);
	}

	@Override
	public void updatePwd(Member member) {
		memberDao.updatePwd(member);
	}

	@Override
	public int insertBlockUser(Map<String, Object> map) {
		return memberDao.insertBlockUser(map);
	}

	@Override
	public int deleteBlockUser(Map<String, Object> map) {
		return memberDao.deleteBlockUser(map);
	}

	@Override
	public List<Keyword> selectAllKeywordList() {
		return memberDao.selectAllkeywordList();
	}

//	@Override
//	public boolean loadUserByUsername(String username) throws UsernameNotFoundException {
//		Member member = memberDao.loadUserByUsername(username);
//		
//		return member;
//		
//	}

	@Override
	public Member selectOnePasswordMember(String password) {
		return memberDao.selectOnePasswordMember(password);
	}

	@Override
	public int updateProfile(Member member) {
		return memberDao.updateProfile(member);
	}

	@Override
	public List<rankSeller> selectRankSeller(String format) {
		return memberDao.selectRankSeller(format);
	}


	public int insertCoupon(Coupon coupon) {
		return memberDao.insertCoupon(coupon);
	}
}
