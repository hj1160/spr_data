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
public class Evalution implements Serializable {

	private int eva_code;
	private String content;
	private boolean kind;
	private String member; //S:판매자 | B:구매자 | C:공통
	
}
