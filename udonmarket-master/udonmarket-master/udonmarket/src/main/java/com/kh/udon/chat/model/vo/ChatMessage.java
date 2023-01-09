package com.kh.udon.chat.model.vo;

import java.io.Serializable;
import java.util.Date;

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
public class ChatMessage implements Serializable {

	private int msgCode;
	private int roomCode;
	private String userId;
	private String chatContent;
	private Date chatDate;
	private String originalFileName;
	private String renamedFileName;
	private String nickName;	
}
