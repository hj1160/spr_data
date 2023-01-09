package com.kh.udon.product.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductDTO implements Serializable
{
    // list
    private int pCode;
    private String seller;
    private String title;
    private String content;
    private int price;
    private int regDate; // 2 days ago
    private String address;
    private boolean pull;
    
    private int wish;
    private int chat;
    
    // photo
    private String uploadPath;
    private String uuid;
    private String originalFilename;
    
    
    // detail
    private String buyer;
    private int categoryCode;
    private String category;
    private String tradeStatus;
    private int offer;
    private Date originalRegDate;
    private long timeMillis;
    private boolean coupon;
}
