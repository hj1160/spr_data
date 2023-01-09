package com.kh.udon.community.model.vo;



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
public class Search {
	
	private int bCode;
	
	private String searchType;

	private String keyword;	
	
	private String categoryCode;
	
	private String hashtagCode;
	
	private String userId;

}
