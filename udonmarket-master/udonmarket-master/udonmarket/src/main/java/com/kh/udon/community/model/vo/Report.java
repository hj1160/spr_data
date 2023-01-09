package com.kh.udon.community.model.vo;

import java.io.Serializable;
import java.util.List;

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
public class Report extends ReasonReport implements Serializable{

	private int reportCode;
	private int reasonCode;
	private String reportId;
	private String shooterId;
	private int bCode;
	private int replyCode;
	private int pCode;
	private boolean checked;
		
}
