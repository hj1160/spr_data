package com.kh.udon.community.model.vo;

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
public class ReasonReport implements Serializable {

	private int reasonCode;
	private String reasonContent;
	private int parentCode;
}
