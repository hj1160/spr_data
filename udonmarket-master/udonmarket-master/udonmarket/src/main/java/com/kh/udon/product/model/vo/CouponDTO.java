package com.kh.udon.product.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class CouponDTO implements Serializable
{
    String couponName;
    Date expireDate;
    int amount;
}
