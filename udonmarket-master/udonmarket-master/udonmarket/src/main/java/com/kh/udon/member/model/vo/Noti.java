package com.kh.udon.member.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Noti implements Serializable{

	private int notiCode;
	private String notiKind;
	/**
	 * reply : 댓글
	 * price : 가격 변동
	 * keyword : 키워드 
	 * chat : 채팅
	 * nego : 가격 제안
	 * like : 게시판 좋아요
	 */
	private String sender;
	private String receiver;
	private int pCode;
	private String pTitle;
	private String notiContent;
	private boolean notiCheck;
	
	private String senderNickName;
	
}
