package com.kh.udon.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;



import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.RestController;

import com.kh.udon.community.model.service.CommunityService;
import com.kh.udon.community.model.vo.Reply;





@RestController

@RequestMapping(value = "/restBoard")

public class RestBoardController {



	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);



	@Inject

	private CommunityService communityService;

	

	@RequestMapping(value = "/ReqlyList", method = RequestMethod.POST)

	public List<Reply> ReplyList(@RequestParam("bCode") int bCode) throws Exception {

		return communityService.ReplyList(bCode);

	}
	
	@RequestMapping(value = "/saveReqly", method = RequestMethod.POST)

	public Map<String, Object> saveReply(@RequestBody Reply reply) throws Exception {

		Map<String, Object> result = new HashMap<>();

		

		try {

			communityService.saveReply(reply);

			result.put("status", "OK");

		} catch (Exception e) {

			e.printStackTrace();

			result.put("status", "False");

		}

		

		return result;

	}

}

