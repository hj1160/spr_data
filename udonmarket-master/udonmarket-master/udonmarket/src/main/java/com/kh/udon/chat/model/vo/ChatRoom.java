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
public class ChatRoom implements Serializable{

		private int roomCode;
		private int pCode;
		private String title;
		private Date regDate;
		private String sender;
		private String senderNickName;
		private boolean senderEnabled;
		private String originalFilename;
		private String renamedFilename;
		
}
