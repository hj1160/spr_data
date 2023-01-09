package com.kh.udon.community.model.vo;

import java.io.Serializable;
import java.util.Date;

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
public class Reply implements Serializable {

	private int replyCode;
	private int replyLevel;
	private String userId;
	private String content;
	private int bCode;
	private int reply_ref;
	private Date regDate;
	private String nickname;
	private int replyCount;
	private String originalFilename;
	private String renamedFilename;
	
}
