package com.kh.udon.member.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.email.Email;
import com.kh.email.EmailSender;
import com.kh.security.model.service.CustomAuthenticationProvider;
import com.kh.security.model.service.SecurityService;
import com.kh.udon.common.util.Utils;
import com.kh.udon.community.model.vo.Community;
import com.kh.udon.community.model.vo.Reply;
import com.kh.udon.member.model.service.MemberService;
import com.kh.udon.member.model.vo.Block;
import com.kh.udon.member.model.vo.Evaluate;
import com.kh.udon.member.model.vo.Keyword;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.Noti;
import com.kh.udon.member.model.vo.Review;
import com.kh.udon.member.model.vo.Wish;
import com.kh.udon.member.model.vo.announce;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@SessionAttributes(value = { "loginMember" })
@Slf4j
public class MemberController {
	@Autowired
    private UserDetailsService userDeSer;
	
	@Autowired
	private SecurityService seService;
	
	@Autowired
	private MemberService service;
	
	@Autowired 
	private CustomAuthenticationProvider Custom;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private EmailSender emailSender;
	
	@Autowired
	private Email emailVo;
	
	
	@RequestMapping(value="/memberLoginSuccess.do")
	public ModelAndView memberLoginSuccess(ModelAndView mav, 
										   HttpSession session, 
										   @RequestParam String userId, 
										   @RequestParam String password){
		if(log.isDebugEnabled()) {
			log.debug("/member/memberLoginSuccess.do");
//			log.debug("userId = {}", userId);
//			log.debug("password = {}", password);
		}
		//???????????? ??????????????? ???????????? ?????? ??????, ????????? ????????? ??????
		//SavedRequest??? 
		String loc = "";
		SavedRequest savedRequest =
			    (SavedRequest)session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		Optional<SavedRequest> maybeSavedRequest = Optional.ofNullable(savedRequest);
		loc = maybeSavedRequest.map(o -> o.getRedirectUrl())
							   .orElse("/");
		//log.debug("loc@loginSuccess="+loc);
		
		//?????? keyword?????? ???????????? ????????? ???????????????
		List<Keyword> keywordList = service.selectAllKeywordList();
		session.setAttribute("keywordList", keywordList);
		//log.debug("session:keywordList = {}", session.getAttribute("keywordList"));
		
		//view??? ??????
//		mav.setViewName("redirect:"+loc);
		mav.setViewName("redirect:/");
		return mav;
	}
	
	// ?????????
	@RequestMapping("/loginForm")
	public String memberLoginForm() {
		return "member/memberLoginForm";
	}

	// ????????????
	@RequestMapping(value = "/signupForm", method = RequestMethod.GET)
	public String memberSignup() {
		return "member/memberSignupForm";
	}

	@RequestMapping(value = "/signupForm", method = RequestMethod.POST)
	public String memberSignup(Member member, RedirectAttributes redirectAttr) {
		log.debug("member@controller = {}", member);

		String rawPassword = member.getPassword();
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encryptPassword);

		log.debug("rawPassword@controller = {}", rawPassword);
		log.debug("encryptPassword@controller = {}", encryptPassword);
		
		
		Map<String, Object> map = new HashMap<>();
		List<Integer> list = new ArrayList<>();
		
		for(int i = 1; i <= 26; i++)
		    list.add(i);

		map.put("list", list);
		map.put("userId", member.getUserId());
		map.put("password", member.getPassword());
		map.put("email", member.getEmail());
		map.put("nickName", member.getNickName());

		
				
		int result = service.insertMemberLocAuthScoreEvaluate(map);
		
		
		log.debug("result@controller = {}", result);

		String msg = (result > 0) ? "??????????????????! ??????????????? ???????????? ??????????????? ?????? ???????????? ????????????." : "??????????????????!";
		log.debug("msg@controller = " + msg);
		redirectAttr.addAttribute("msg", msg);

		return "redirect:/";
	}

//	@RequestMapping(value="/login" ,method=RequestMethod.POST)
//	public String memberLogin(@RequestParam String userId, @RequestParam String password, Model model,
//			RedirectAttributes redirectAttr, HttpSession session) {
//
//		log.debug("userId = {}, password = {}", userId, password);
//		Member member = service.selectOneMember(userId);
//		log.debug("member = {}", member);
//
//		String location = "/";
//
//		// ????????? ??????
//		 if(member != null && bcryptPasswordEncoder.matches(password,member.getPassword())) { 
//			//???????????? 
//			model.addAttribute("loginMember", member);
//			
//			//???????????? next??? ???????????? 
//		    String next = (String)session.getAttribute("next");
//			location = next != null ? next : location; session.removeAttribute("next"); }
//		  //????????? ?????? 
//		  else { 
//			  redirectAttr.addFlashAttribute("msg", "????????? ?????? ??????????????? ???????????????.");
//		  }
//		return "redirect:" + location;
//	}

	@PostMapping("/memberLoginFailure")
	public String memberLoginFailure(RedirectAttributes redirectAttr) {
		redirectAttr.addFlashAttribute("msg", "????????? ?????? ??????????????? ???????????? ????????????.");
		return "redirect:/member/loginForm";
	}

	@RequestMapping("/logout")
	public String memberLogout(SessionStatus sessionStatus) {
		if (sessionStatus.isComplete() == false) {
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			sessionStatus.setComplete();
		}

		return "redirect:/";
	}
	
	/*
	 * @RequestMapping(value="/checkIdDuplicate", method = RequestMethod.GET)
	 * 
	 * @ResponseBody public int checkIdDuplicate(@RequestParam("userId") String
	 * userId) {
	 * 
	 * int result =service.userIdCheck(userId); log.debug("result = {}", result);
	 * 
	 * return result;
	 * 
	 * }
	 */
	
	
	
	/**
	 * ?????????????????? command vo??? ???????????? ??? ???????????????.
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, 
									new CustomDateEditor(sdf, true));
	}
	
	@GetMapping("/checkIdDuplicate")
	public ModelAndView checkIdDuplicate1(ModelAndView mav,
										  @RequestParam("userId") String userId) {
		
		//1. ???????????? : ????????????
		Member member = service.selectOneMember(userId);
		boolean isUsable = member == null;
		
		//2. model??? ????????????
		mav.addObject("isUsable", isUsable);
		
		//3. viewName : jsonView??? ??????
		mav.setViewName("jsonView");// /WEB-INF/views/jsonView.jsp
		
		return mav;
	}
	
	// ???????????? ??????
		@RequestMapping(value = "/passwordFind", method = RequestMethod.GET)
		public String passwordSearch() {
			return "member/passwordFind";
		}
	
	@RequestMapping(value="/passwordFind",method= RequestMethod.POST)
	public String passwordSearch(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		String userId = (String)paramMap.get("userId");
		String email = (String)paramMap.get("email");
		
		int result = service.updatePasswordEncrypt(paramMap);
		log.debug("result = {} " ,result);
		
		if(result > 0) {
			emailVo.setSubject(userId + "?????? ???????????? ?????? ???????????????.");
			emailVo.setReceiver(email);
			emailVo.setContent("?????? ??????????????? 1234 ?????????.");
			emailSender.SendEmail(emailVo);
		}
		
		
		return "redirect:/";
	}
		
	//??? ??????????????? or ?????? ???????????? ??????????????? (view ??? ?????? ?????? ??? ???)
	@RequestMapping("/mypage")
    public Model mypage(@RequestParam("userId") String userId,
    					Model model){
		
		Member member = service.selectOneMember(userId);
		model.addAttribute("member", member);
        return model;
    }
	
	@RequestMapping("/yourpage")
	public String yourpage(@RequestParam("searchId") String searchId,
					       @RequestParam("userId") String userId,
					       RedirectAttributes rttr,
						Model model) {
		
		int result = 0;
		Member member = service.selectOneMember(searchId);
		model.addAttribute("member",member);
		
		List<Block> list = service.selectAllBlockUser(userId);
		for(int i=0; i<list.size();i++) {
			if(list.get(i).getBlockUserId().equals(searchId)) {
				rttr.addFlashAttribute("msg","????????? ???????????????.");
				result++;
				log.debug("????????????:",list.get(i).getBlockUserId());
			}
						
			else 
				result = 0;
			
			}
//		log.debug("?????????=" ,result);
		System.out.println(result);
  		return result == 0? "/member/mypage?" + userId :"redirect:/";
	}

    //????????? ??????
	@RequestMapping("/editprofile" )
	public String editProfile(@RequestParam("userId") String userId, 
							  Model model)
	{
		
		 Member member = service.selectOneMember(userId); 
		 model.addAttribute("member",member);
		 
		return "/member/editProfile";
	}
	
	@PostMapping("/pwdCheck")
	public String pwdCheck(Member member,
						   @RequestParam("userId") String userId,
						   @RequestParam("password") String password,
						   RedirectAttributes rttr,
						   String username,
						   Authentication authentication)
	{
		/* boolean result = service.checkPwd(userId,member.getPassword()); */
		
//		log.debug("result = {} " ,result);
//		if(result) {
		System.out.println("???????????? = "+ member.getPassword());
		
		if(authentication != null) {
			log.debug("?????? ??????  = ", authentication.getClass() );
			System.out.println("?????? ??????  = "+ authentication.getClass());
			
			
			//?????? ?????? ?????? ??????
			WebAuthenticationDetails web = (WebAuthenticationDetails)authentication.getDetails();
			log.debug("?????? ID = ", web.getSessionId());
			System.out.println("?????? ID  = "+ web.getSessionId());
			log.debug("?????? IP = ", web.getRemoteAddress());
			System.out.println("?????? IP = "+ authentication.getClass());
			
			//UsernamePasswordAuthenticationToken??? ????????? member ?????? ??????
			member = (Member)authentication.getPrincipal();
			log.debug("ID??????  = ", member.getUserId());
			System.out.println("ID?????? = "+ member.getUserId());
			log.debug("password?????? = ", member.getPassword());
			System.out.println("password?????? = "+ member.getPassword());
			
			if(!bcryptPasswordEncoder.matches(password, member.getPassword())) {
				log.debug("matchPassword :::::::: false!");
				System.out.println("matchPassword :::::::: false!");
				rttr.addFlashAttribute("msg","???????????? ?????? ??????");
				rttr.addAttribute("userId", member.getUserId());
				return "redirect:/member/mypage";
			}
			else {
				System.out.println("matchPassword :::::::: success!");
				rttr.addAttribute("userId", member.getUserId());
				rttr.addFlashAttribute("msg","???????????? ?????? ??????");
				return "redirect:/member/updatePwd";
			}
		}
		rttr.addAttribute("userId", member.getUserId());
		System.out.println("matchPassword :::::::: success!");
		return "redirect:/member/updatePwd";
		}
//		else
//		{
//			rttr.addFlashAttribute("msg","???????????? ?????? ??????");
//			rttr.addAttribute("userId", member.getUserId());
//			return "redirect:/member/mypage";
//		}
//			
//	}
//	}
//		userDeSer.loadUserByUsername(username);
//		
//		boolean result = service.loadUserByUsername(username);
//		 
//		return username;
//
//	}
//	public String pwdCheck(Member member,
//						   @RequestParam("userId") String userId,
//						   @RequestParam("password") String password,
//						   RedirectAttributes rttr)
//	{
//		/* boolean result = service.checkPwd(userId,member.getPassword()); */
//		/* boolean result = AuthenticationManager.authenticate(Authentication); */
//		log.debug("result = {} " ,result);
//		if(result) {
//		rttr.addAttribute("userId", member.getUserId());
//		return "redirect:/member/updatePwd";
//		}
//		else
//		{
//			rttr.addFlashAttribute("msg","???????????? ?????? ??????");
//			rttr.addAttribute("userId", member.getUserId());
//			return "redirect:/member/mypage";
//		}
//			
//	}
	
	
	//???????????? ??????
	@RequestMapping(value = "/updatePwd")
	public String updatePwd(@RequestParam("userId") String userId, 
							  Model model)
	{
		
		 Member member = service.selectOneMember(userId); 
		 model.addAttribute("member",member);
		 
		return "/member/updatePwd";
	}
	@PostMapping("/pwdUpdate" )
	public String pwdUpdate(Member member,@RequestParam("userId") String userId,@RequestParam("password") String password,RedirectAttributes rttr,SessionStatus sessionStatus)
	{
		String rawPassword = member.getPassword();
		String encryptPassword = bcryptPasswordEncoder.encode(rawPassword);
		member.setPassword(encryptPassword);
		log.debug("member = {}", member);
		
		if(member != null && bcryptPasswordEncoder.matches(password,encryptPassword)) {
			
			/* boolean result = service.checkPwd(userId,member.getPassword()); */
			log.debug("userId = {}", userId);
			/* if(result) { */
				service.updatePwd(member);
				System.out.println("update success!!!!!!!!!!!!!!");
				rttr.addFlashAttribute("msg","??????????????? ?????????????????????");
				System.out.println("$$$$$$$$$$$$");
				if (sessionStatus.isComplete() == false) {
				memberLogout(sessionStatus);
				}
				System.out.println("%%%%%%%%%%%%");
				rttr.addAttribute("userId", member.getUserId());
				
				SecurityContextHolder.clearContext();
				sessionStatus.setComplete();
				
				return "/member/memberLoginForm";
		}
		return "redirect:/member/logout";
//				rttr.addAttribute("userId", member.getUserId());
		}

	
	//????????? ??????
	@PostMapping("/nickUpdate" )
	public String nickUpdate(Member member,RedirectAttributes rttr,HttpServletRequest req)
	{
		//===========================????????? ??????
		log.debug("member = {}", member);
		
		int result = service.updateNick(member);
		rttr.addFlashAttribute("msg", result > 0 ? "????????? ?????? ??????" : "????????? ?????? ??????");
		rttr.addAttribute("userId", member.getUserId());
		//===========================????????? ??????
		
		
		return "redirect:/member/mypage";
		
	}
	
	@RequestMapping(value = "/imgUpdate",
				method = RequestMethod.POST,
				produces = "text/plain; charset=utf-8")
public String imgUpdate(
						HttpServletRequest request,
						RedirectAttributes rttr,
						Member member, @RequestParam("userId") String userId, @RequestParam(value = "file", required=false) MultipartFile[] renamedFileNames){


//		List<Member> memberList = new ArrayList<>();
		String saveDirectory = request.getServletContext()
									  .getRealPath("/resources/img/member");
		
		System.out.println("saveDirectory = " + saveDirectory);
		
		
		for(MultipartFile f : renamedFileNames) {
			
			if(!f.isEmpty() && f.getSize() != 0) {
				
				String renamedFileName = Utils.getRenamedFileName(f.getOriginalFilename());
				
				System.out.println("renamedFileName = " + renamedFileName);
				
				File newFile = new File(saveDirectory , renamedFileName);
				
				System.out.println("newFile = " + newFile);
				
				try {
					f.transferTo(newFile);
				} catch(IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				member.setOriginalFileName(f.getOriginalFilename());
				member.setRenamedFileName(renamedFileName);
				
				System.out.println("member = " + member);
//				memberList.add(member);
			}
		}
		
		try {
			int result = service.updateProfile(member);
			
		} catch(Exception e) {
			log.error("????????? ??????  ??????", e);
		}
		
	rttr.addAttribute("userId", member.getUserId());

	return "redirect:/member/mypage";
}       
	
    //????????????
    @RequestMapping("/wishList")
    public Model wishList(@RequestParam("userId") String userId,
    					  Model model){
    	
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	List<Wish> list = service.selectAllWishPro(userId);
    	log.debug("ProductWishList = {}", list);
    	
    	model.addAttribute("member", member);
    	model.addAttribute("list", list);  	
    	
        return model;
    }
    
    //???????????? ??????
    @PostMapping("/deleteWish")
    @ResponseBody
    public Map<String, Object> deleteWish(@RequestParam("wishCode") int wishCode){
    	
    	log.debug("wishCode = {}", wishCode);
    	int result = service.deleteWish(wishCode);

    	log.debug("result = {}", result);
    	Map<String, Object> map = new HashMap<>();
    	map.put("wishCode", wishCode);
    	
    	return map;
    }

    //???????????? ?????????
    @PostMapping("/insertWish")
    @ResponseBody
    public Map<String, Object> insertWish(@RequestParam("userId") String userId,
    									  @RequestParam("wishCode") int wishCode,
    									  @RequestParam("pCode") int pCode){
    	
    	log.debug("userId = {}", userId);
    	log.debug("pCode = {}", pCode);
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("pCode", pCode);
    	map.put("wishCode", wishCode);

    	int result = service.insertWish(map);
    	
    	return map;
    }
    
    //????????????
    @RequestMapping("/salesList")
    public Model salseList(@RequestParam("userId") String userId,
    					   Model model){

    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	List<Wish> list = service.selectAllSalesPro(userId);
    	log.debug("ProductSalesList = {}", list);
    	
    	//?????????, ????????????, ?????? ??????
    	List<Wish> sale = new ArrayList<>();
    	List<Wish> complete = new ArrayList<>();
    	List<Wish> hidden = new ArrayList<>();
    	
    	for(Wish w : list) {
    		if(!w.isOpenStatus()) hidden.add(w);
    		else if(w.getTradeStatus().equals("C")) complete.add(w);
    		else sale.add(w);
    	}
    	
    	model.addAttribute("member", member);
    	model.addAttribute("sale", sale);
    	model.addAttribute("complete", complete);
    	model.addAttribute("hidden", hidden);
    	
        return model;
    }
    
    //????????????
    @RequestMapping("/buyList")
    public Model buyList(@RequestParam("userId") String userId,
    					 Model model){
    	
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	List<Wish> list = service.selectAllBuyPro(userId);
    	log.debug("ProductBuyList = {}", list);
    	
    	model.addAttribute("member", member);
    	model.addAttribute("list", list);
    	
        return model;
    }
    
    //??? ?????? ?????? ????????? ?????????
    @RequestMapping("/settingsArea")
    public Model settingsArea(@RequestParam("userId") String userId,
    					      Model model) {
    	
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	int radius = service.selectRadius(userId);
    	log.debug("radius = {}",String.valueOf(radius));
    	
    	model.addAttribute("member", member);
    	model.addAttribute("radius", radius);
    	
    	return model;
    }
    
    //?????? ????????? location ????????? update
    //?????? ??????(??????)??? member ????????? update
    @PostMapping("/updateAddress")
    @ResponseBody
    public Map<String, Object> updateAddress(RedirectAttributes redirectAttr,
			    							@RequestParam("userId") String userId,
			    							@RequestParam("addr") String addr,
			    							@RequestParam("lat") float latitude,
			    							@RequestParam("lon") float longitude){
    	
    	log.debug("userId = {}", userId);
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("address", addr);
    	map.put("latitude", latitude);
    	map.put("longitude", longitude);
    	
    	int result = service.updateAddrAndLoc(map);
    	
    	return map;
    }
    
    //?????? ?????? ??????
    @PostMapping("/updateRadius")
    @ResponseBody
    public Map<String, Object> updateRadius(@RequestParam("userId") String userId,
    						  				@RequestParam("radius") int radius) {

    	
    	log.debug("userId = {}", userId);
    	log.debug("radius = {}", String.valueOf(radius));
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("radius", radius);
    	
    	int result = service.updateRadius(map);
    	
    	return map;
    }
    
    //?????? ?????? ??????
    @RequestMapping("/FAQ")
    public String FAQ(@RequestParam String userId,Model model)
    {
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	//2.????????????
    	List<announce> list = service.selectAnnounceList(userId);
    	log.debug("list = {}",list);
    	
    	//3.view?????????
    	model.addAttribute("member",member);
    	model.addAttribute("list",list);
    	return "member/FAQ";
    }
    
    //FAQ?????????
    @RequestMapping("/FAQForm")
  	public ModelAndView FAQForm(ModelAndView mav,
  									@RequestParam("userId") String userId) {
  		
  		Member member = service.selectOneMember(userId);
  		
  		mav.addObject("member",member);
  		mav.setViewName("member/FAQForm");
  		return mav;
  	}
    
    @RequestMapping("/FAQEnroll")
  	public String FAQEnroll(@ModelAttribute("announce") announce announce, 
  								 RedirectAttributes rttr, 
  								 Model model,
  								@RequestParam(value="userId", required=false) String userId)throws Exception
	{
  		log.debug("userId = {}", userId);
  		Member member = service.selectOneMember(userId);
  		int result = service.announceEnroll(announce);
  		
  		rttr.addFlashAttribute("msg",result > 0  ? "FAQ ?????? ??????!" : "FAQ ?????? ??????!");
		rttr.addAttribute("userId", announce.getUserId());
  		
  		return "redirect:/member/FAQ";
  	}
    
    //FAQ ????????????
    @GetMapping("/FAQDetail")
    public String FAQDetail(@RequestParam int bCode,
    							@RequestParam("userId") String userId,
    							Model model) {
    	
    	Member member = service.selectOneMember(userId);
    	log.debug("[{}]??? ???????????? ??????",bCode);
    	announce announce = service.selectOneAnnounce(bCode,userId);
    	model.addAttribute("announce",announce);
    	model.addAttribute("member", member);
    	return "member/FAQDetail";
    }
    
    //?????? ??????
    @RequestMapping("/announce")
    public String announce(@RequestParam String userId,Model model)
    {
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	//2.????????????
    	List<announce> list = service.selectAnnounceList(userId);
    	log.debug("list = {}",list);
    	
    	//3.view?????????
    	model.addAttribute("member",member);
    	model.addAttribute("list",list);
    	return "member/announce";
    }

    //?????? ?????? ??????
    @RequestMapping("/interList")
    public String interList()
    {
    	return "member/interList";
    }
    
    //???????????? ??????
    @RequestMapping("/myComment")
    public  ModelAndView mycomment(ModelAndView mav,
			   					   @RequestParam("userId") String userId)
    {
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	
    	List<Reply> list = service.selectReplyList(userId);
    	log.debug("list = {}",list);
    	
    	mav.addObject("member",member);
    	mav.addObject("list",list);
    	mav.setViewName("member/myComment");
    	return mav;
    }

    //???????????? ?????????
    @RequestMapping("/myPost")
    public ModelAndView mypost(ModelAndView mav,
							   @RequestParam("userId") String userId)
    {
    	log.debug("loginMemberId = {} ", userId);
    	Member member = service.selectOneMember(userId);
    	
    	
    	List<Community> list = service.selectPostList(userId);
    	log.debug("list = {}",list);
    	
    	mav.addObject("member",member);
    	mav.addObject("list",list);
    	mav.setViewName("member/myPost");
    	return mav;
    }
    
    //?????? ????????? ?????? ??????
    @RequestMapping(value = "/keywordNoti",
    				method = RequestMethod.GET)
    public ModelAndView keywordNoti(@RequestParam("userId") String userId,
    								ModelAndView mav){

    	log.debug("userId = {}", userId);
    	Member member = service.selectOneMember(userId);
    	
    	List<Keyword> list = service.selectKeywordList(userId);
    	log.debug("list = {}", list);
    	
    	//?????? ????????? ??? ?????????
    	int totalKeywordContents = service.selectTotalKeywordContent(userId);
    	log.debug("totalKeywordContents ={}", String.valueOf(totalKeywordContents));
    	
    	mav.addObject("member", member);
    	mav.addObject("totalKeywordContents", totalKeywordContents);
    	mav.addObject("list", list);
    	return mav;
    }
    
    //?????? ????????? ??????
    @RequestMapping(value = "/insertKeyword",
    				method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertKeyword(@RequestParam("userId") String userId,
			    						     @RequestParam("keyword") String keyword){
    	
    	Keyword key = new Keyword(0, userId, keyword);
   
    	int keyCode = service.insertKeyword(key);

    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("keyword", keyword);
    	map.put("keyCode", keyCode);
    	
    	return map;
    }
    
    //????????? ??????
    @RequestMapping(value = "/deleteKeyword")
    @ResponseBody
    public Map<String, Object> deleteKeyword(@RequestParam("key") int keyCode){
    	  
    	int result = service.deleteKeyword(keyCode);  		

    	Map<String, Object> map = new HashMap<>();
    	map.put("key", keyCode);
    	
    	return map;
    }
    
    //????????? ????????????
    @GetMapping("/checkKeywordDuplicate")
    @ResponseBody
    public Map<String, Object> checkKeywordDuplicate(@RequestParam("userId") String userId,
    												 @RequestParam("keyword") String keyword){
    	   	
    	Map<String, Object> key = new HashMap<>();
    	key.put("userId", userId);
    	key.put("keyword", keyword);
    	
    	int result = service.selectKeyword(key);
    	//?????????????????? 0????????? ?????? ?????? ????????? ????????? ???
    	boolean isUsable = (result == 0); 
    	
    	Map<String, Object> map = new HashMap<>();
		map.put("isUsable", isUsable);
		map.put("userId", userId);
    	return map;
    }
    
    //?????? ?????? ??????/?????? ??????
    @RequestMapping("/myReviewList")
    public Model myReviewList(@RequestParam("userId") String userId,
    						  Model model){
    	
    	log.debug("userId = {}", userId);
    	Member member = service.selectOneMember(userId);
    	
    	//?????? ??????
    	List<Evaluate> evaList = service.selectAllEva(userId);
    	log.debug("list = {}", evaList);
    	
    	//?????? ??????
    	//1. ?????? ?????? ??? ??????
    	int totalReview = service.selectTotalReview(userId);
    	log.debug("totalReview = {}", totalReview);
    	
    	//2. ?????? ?????? - userId??? ????????? ??? ??????
    	List<Review> reviewList = service.selectAllReview(userId);
    	log.debug("reviewList = {}", reviewList);
    	
    	//?????????/????????? ??????
    	List<Review> seller = new ArrayList<>(); 
    	List<Review> buyer = new ArrayList<>(); 
    	for(Review r : reviewList) {
    		if(r.getDirect().equals("S")) buyer.add(r);
    		else seller.add(r);    			
    	}
    	
    	model.addAttribute("member", member);
    	model.addAttribute("evaList", evaList);
    	model.addAttribute("totalReview", totalReview);
    	model.addAttribute("reviewList", reviewList);
    	model.addAttribute("reviewSeller", seller);
    	model.addAttribute("reviewBuyer", buyer);
    	return model;
    }
    
    //???????????? ?????????
    @GetMapping("/announceDetail")
    public String announceDetail(@RequestParam int bCode,
    							@RequestParam("userId") String userId,
    							Model model) {
    	
    	Member member = service.selectOneMember(userId);
    	log.debug("[{}]??? ???????????? ??????",bCode);
    	announce announce = service.selectOneAnnounce(bCode,userId);
    	model.addAttribute("announce",announce);
    	model.addAttribute("member", member);
    	return "member/announceDetail";
    }
    
  //???????????? ????????? ???
  	@RequestMapping("/announceForm")
  	public ModelAndView announceForm(ModelAndView mav,
  									@RequestParam("userId") String userId) {
  		
  		Member member = service.selectOneMember(userId);
  		
  		mav.addObject("member",member);
  		mav.setViewName("member/announceForm");
  		return mav;
  	}
    
  //???????????? ??????
  	@RequestMapping("/announceEnroll")
  	public String announceEnroll(@ModelAttribute("announce") announce announce, 
  								 RedirectAttributes rttr, 
  								 Model model,
  								@RequestParam(value="userId", required=false) String userId)throws Exception
	{
  		log.debug("userId = {}", userId);
  		Member member = service.selectOneMember(userId);
  		int result = service.announceEnroll(announce);
  		
  		rttr.addFlashAttribute("msg",result > 0  ? "???????????? ?????? ??????!" : "???????????? ?????? ??????!");
		rttr.addAttribute("userId", announce.getUserId());
  		
  		return "redirect:/member/announce";
  	}
  	
  	//???????????? ??????
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
            log.error("???????????? ?????? ??????", e);
            msg = "????????? ??????????????? ????";
        }
        
        map.put("msg", msg);
        
        return map;
    }

    //?????? ????????? (??????)
    @RequestMapping("/showNoti")
    @ResponseBody
    public Map<String, Object> showNoti(@RequestParam("userId") String userId){
    	Map<String, Object> map = new HashMap<>();
    	
    	List<Noti> noti = service.selectAllNoti(userId);
    	log.debug("notiList = {}", noti);
    	map.put("noti", noti);
    	
    	return map;
    }
    
    //?????? ???????????? (???????????????)
    @RequestMapping("/myNotiList")
    public Model myNotiList(@RequestParam("userId") String userId,
			    		 	@RequestParam(defaultValue = "1", 
			    		 				  value="cPage") int cPage,
    						Model model,
    						HttpServletRequest request){

    	//????????? ????????? 
		final int limit = 10; //numPerPage
		int offset = (cPage - 1) * limit;

    	Member member = service.selectOneMember(userId);
    	List<Noti> list = service.selectAllNoti(userId, limit, offset);

    	//?????????????????? ?????????
		int totalContents = service.selectNotiTotalContents(userId);

		//????????? ???
		String url = request.getRequestURI() + "?userId=" + userId + "&";
		String pageBar = Utils.getPageBarHtml(cPage, limit, totalContents, url);

    	model.addAttribute("member", member);
    	model.addAttribute("list", list);
    	model.addAttribute("pageBar", pageBar);
    	model.addAttribute("totalContents", totalContents);

    	return model;
    }
    						
    //?????? ?????? ???????????? ?????????
    @RequestMapping("/updateCheck")
    @ResponseBody
    public String updateCheck(@RequestParam("notiCode") int notiCode){
    	
    	String resultStr = "?????? ??????";
    	try {
    		int result = service.updateNotiCheck(notiCode);
    	} catch (Exception e) {
			resultStr = "?????? ??????";
		}    	
    	return resultStr;
    }
    
    //?????? ????????? ?????????
    @RequestMapping("/blockUser")
    public Model blockUser(@RequestParam("userId") String userId,
    						Model model){
    	
    	Member member = service.selectOneMember(userId);
    	List<Block> list = service.selectAllBlockUser(userId);
    	
    	model.addAttribute("member", member);
    	model.addAttribute("list", list);
    	
    	return model;
    }
    
    //????????????
    @GetMapping("/addBlockUser")
    public String addBlockUser(@RequestParam("userId") String userId,
    						   @RequestParam("blockUserId") String blockUserId){
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("blockUserId", blockUserId);

    	try {
    		int result = service.insertBlockUser(map);    		
    	}catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return "redirect:/member/blockUser?userId=" + userId;
    }
    
    //????????????
    @PostMapping("/deleteBlockUser")
    @ResponseBody
    public String deleteBlockUser(@RequestParam("userId") String userId,
    							  @RequestParam("blockUserId") String blockUserId){
    	
    	Map<String, Object> map = new HashMap<>();
    	map.put("userId", userId);
    	map.put("blockUserId", blockUserId);
    	
    	String msg = "?????? ?????? ????????? ????";
    	try {
    		int result = service.deleteBlockUser(map);    		
    	}catch (Exception e) {
    		e.printStackTrace();
    		msg = "?????? ?????? ??????????????? ???? ";
    	}
    	
    	return msg;
    }
    
    
    
}
