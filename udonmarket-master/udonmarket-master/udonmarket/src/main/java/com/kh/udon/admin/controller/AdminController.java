package com.kh.udon.admin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.udon.common.util.Utils;
import com.kh.udon.community.model.service.CommunityService;
import com.kh.udon.community.model.vo.Report;
import com.kh.udon.member.model.service.MemberService;
import com.kh.udon.member.model.vo.Coupon;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.announce;
import com.kh.udon.member.model.vo.rankSeller;
import com.kh.udon.product.model.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
    @Autowired
    private ProductService productService;
	
	/**
	 * 페이징의 컨텐츠영역에 대한 기능구현을 
	 * mybatis에서 지원하는 rowbounds를 사용한다.
	 * - offset : 건너뛸 게시물수 (cPage - 1) * numPerPage
	 * 		- 1page : 1~10 (offset : 0)
	 * 		- 2page : 11~20 (offset : 10)
	 * 		- 3page : 21~30 (offset : 20)
	 * - limit : 한페이지에 표시될 게시물 수 (numPerPage)
	 * 
	 * @param mav
	 * @return
	 */
	
	@GetMapping("/memberList")
	public ModelAndView memberList(ModelAndView mav, @RequestParam(defaultValue = "1", value = "cPage") int cPage, HttpServletRequest request) {
	
		
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		List<Member> list = memberService.selectMemberList(limit, offset); 
		log.debug("list = {}", list);
		
		//전체 컨텐츠 수
		int totalContents = memberService.selectMemberTotalContents();
		
		String userId = "admin";
		
		String url = request.getRequestURI() + "?userId=" + userId + "&";
		String pageBar = Utils.getPageBarHtml(cPage, limit, totalContents, url);
		
		mav.addObject("pageBar", pageBar);
		mav.addObject("totalContents", totalContents);
		mav.addObject("list", list);
		mav.setViewName("admin/memberList");
		
		return mav;
		
	}
	
	@RequestMapping(value="/adminMemberEnroll", method = RequestMethod.GET)
	public String adminMemberEnroll() {
		
		return "admin/memberList";
	}
	
	@RequestMapping(value="/adminMemberEnroll", method = RequestMethod.POST)
	public String adminMemberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member@controller = {}", member);
		
		String rawPassword = member.getPassword();
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encryptPassword);
		
		log.debug("rawPassword@controller = {}", rawPassword);
		log.debug("encryptPassword@controller = {}", encryptPassword);
		
		
		List<Integer> num = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		
		for(int i=0;i<=26; i++) {
			num.add(i);
		}
		
		map.put("list", num);
		map.put("userId", member.getUserId());
		map.put("password", member.getPassword());
		map.put("email", member.getEmail());
		map.put("nickName", member.getNickName());
		
		
				
		int result = memberService.insertMemberLocAuthScoreEvaluate(map);
		
		log.debug("result@controller = {}", result);
		
		String msg = (result > 0) ? "회원가입성공!" : "회원가입실패!";
		log.debug("msg@controller = " + msg);
		redirectAttr.addFlashAttribute("msg", msg);
		
		
		return "redirect:/admin/memberList";
	}
	

	
	@RequestMapping(value="/adminMemberQuit", method = RequestMethod.POST)
	public String adminMemberQuit(@RequestParam("userId") String userId, RedirectAttributes redirectAttr) {
		
		int result = memberService.updateQuitMember(userId);
		log.debug("result = {}", result);
		redirectAttr.addFlashAttribute("msg",result > 0  ? "회원 탈퇴 성공!" : "회원 탈퇴 실패");
		
		return "redirect:/admin/memberList";
	}
	
	//공지사항 글쓰기 폼
	@RequestMapping("/announceForm")
	public ModelAndView announceForm(ModelAndView mav,
									@RequestParam("userId") String userId) {
		
		Member member = memberService.selectOneMember(userId);
		
		mav.addObject("member",member);
		mav.setViewName("admin/announceForm");
		return mav;
	}
	
	//공지사항 등록
	@PostMapping("/announceEnroll")
	public String announceEnroll(announce announce,RedirectAttributes redirectAttr) {
		
		
		int result = memberService.announceEnroll(announce);
		
		redirectAttr.addFlashAttribute("msg",result > 0  ? "공지사항 등록 성공!" : "공지사항 등록 실패!");
		
		return "redirect:/member/announce";
	}
	
	@GetMapping("/declareBoardList")
	public ModelAndView declareBoardList(ModelAndView mav, @RequestParam(defaultValue = "1", value="cPage") int cPage) {
		
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		List<Report> list = communityService.selectReportList(limit, offset); 
		log.debug("list = {}", list);
		
		
		mav.addObject("list", list);
		mav.setViewName("admin/declareBoardList");
		
		return mav;
	}
	
	@GetMapping("/declareReplyList")
	public ModelAndView declareReplyList(ModelAndView mav, @RequestParam(defaultValue = "1", value="cPage") int cPage) {
		
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		List<Report> list = communityService.selectReplyList(limit, offset); 
		log.debug("list = {}", list);
		
		
		mav.addObject("list", list);
		mav.setViewName("admin/declareReplyList");
		
		return mav;
	}
	
	
	@RequestMapping("/CouponList")
	public ModelAndView CouponList(ModelAndView mav,@RequestParam(defaultValue = "1", value = "cPage") int cPage, HttpServletRequest request) {
	
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		List<Coupon> list = memberService.selectCouponList(limit, offset); 
		log.debug("list = {}", list);
	
		Date now = new Date();
		SimpleDateFormat fmt = new SimpleDateFormat ("yyyy/MM");
		List<rankSeller> rankSeller = memberService.selectRankSeller(fmt.format(now));
		
		//전체 컨텐츠 수
		int totalContents = memberService.selectCouponTotalContents();
		
		String userId = "admin";
		
		String url = request.getRequestURI() + "?userId=" + userId + "&";
		String pageBar = Utils.getPageBarHtml(cPage, limit, totalContents, url);
		
		mav.addObject("pageBar", pageBar);
		mav.addObject("totalContents", totalContents);
		mav.addObject("list", list);
		mav.addObject("rank", rankSeller);
		mav.setViewName("admin/CouponList");
		
		return mav;
		
	}
	
	@RequestMapping(value="/adminCouponEnroll", method = RequestMethod.GET)
	public String adminCouponEnroll() {
		
		return "admin/CouponList";
	}
	
	@RequestMapping(value="adminCouponEnroll",method = RequestMethod.POST)
	public String adminCouponEnroll(Coupon coupon, RedirectAttributes redirectAttr) {
		
		
		int result = memberService.insertCoupon(coupon);
		
		String msg = (result > 0) ? "쿠폰등록성공!" : "쿠폰등록실패!";
		log.debug("msg@controller = " + msg);
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/admin/CouponList";
	}
	
	@RequestMapping("/declareProductList")
	public ModelAndView declareProductList(ModelAndView mav, @RequestParam(defaultValue = "1", value = "cPage") int cPage) {
		
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		List<Report> list = productService.selectProductList(limit, offset);
		
		
		mav.addObject("list", list);
		mav.setViewName("admin/declareProductList");
		
		
		return mav;
	}
	
	@RequestMapping("/declareMemberList")
	public ModelAndView declareMemberList(ModelAndView mav, @RequestParam(defaultValue = "1", value = "cPage") int cPage) {
		
		
		final int limit = 10;
		int offset = (cPage - 1) * limit;
		
		
		List<Report> list = memberService.selectDeclareMemberList(limit, offset);
		
		mav.addObject("list", list);
		mav.setViewName("admin/declareMemberList");
		
		
		return mav;
	}
	
	
	
}
