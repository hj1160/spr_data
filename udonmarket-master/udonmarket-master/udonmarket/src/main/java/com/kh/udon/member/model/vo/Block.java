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
@ToString
public class Block implements Serializable {

	private String userId;
	private String blockUserId;
	private String blockUserNickName;
	private String blockUserAddr;
	private String originalFilename;
	private String renamedFilename;
	
}
