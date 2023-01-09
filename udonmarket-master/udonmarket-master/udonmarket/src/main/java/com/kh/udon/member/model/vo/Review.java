package com.kh.udon.member.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Review implements Serializable {

	private int reviewCode;
	private String sender; //발신
	private String recipient; //수신
	// S : 판매자->구매자  
	// B : 구매자->판매자
	private String direct; 
	private String content;
	
}
