package com.kh.udon.member.model.vo;

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
public class announce implements Serializable{
	
	/*
	 * create table board
	(
	    b_code number,
	    user_id varchar2(50) not null,
	    category_code number not null,
	    board_title varchar2(100) not null,
	    board_content varchar2(500) not null,
	    reg_date date default sysdate,
	    hashtag_code number,
	    like_this number default 0 not null,
	    constraint pk_board primary key(b_code),
	    constraint fk_board_user_id foreign key(user_id) references member(user_id),
	    constraint fk_board_category_code foreign key(category_code) references category(category_code),
	    constraint fk_board_hashtag_code foreign key(hashtag_code) references hashtag(hashtag_code)
	);
	*/

	
	private int bCode;
	private String userId;
	private int categoryCode;
	private String boardTitle;
	private String boardContent;
	private Date regDate;
	private int hashtagCode;
	private int likeThis;
	
}
