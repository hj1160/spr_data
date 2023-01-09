package com.kh.udon.product.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO implements Serializable
{
    int pCode;
    String seller;
    String buyer;
    String title;
    int category;
    String content;
    int price;
    Date regDate;
    boolean openStatus;
    String tradeStatus;
    boolean coupon;
    boolean offer;
    String uploadPath;
    String originalFilename;
    String uuid;
//    Photo.upload_path,
//    photo.original_filename,
//    photo.uuid
 
    String photoId;
}
