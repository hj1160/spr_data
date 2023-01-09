package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ProductPhotoVO implements Serializable
{
    private int photoCode;
    private String originalFilename;
    private String uuid;
    private String uploadPath;
    
    private int pCode;
}