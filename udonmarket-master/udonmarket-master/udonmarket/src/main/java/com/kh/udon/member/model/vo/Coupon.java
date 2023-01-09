package com.kh.udon.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Coupon implements Serializable{
	
	private int couponCode;
	private String userId;
	private String couponName;
	private Date expireDate;
	private boolean usageStatus;
	
}
