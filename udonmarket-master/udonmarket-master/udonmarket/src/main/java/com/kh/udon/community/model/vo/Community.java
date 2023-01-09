package com.kh.udon.community.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;


@Data
public class Community implements Serializable
{
	
	private int bCode;
	private String userId;
	private int categoryCode;
	private String boardTitle;
	private String boardContent;
	private Date regDate;
	private int hashtagCode;
	private int likeThis;
	private int BoardphotoCount;
	private String nickname;
	private String address;
	private String uploadPath;
	private String uuid;
	private String originalFilename;
	private String renamedFilename;
	
	private int replyCount;
	
	
	String photoId;

}
