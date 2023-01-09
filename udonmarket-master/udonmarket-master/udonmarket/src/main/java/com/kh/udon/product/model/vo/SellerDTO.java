package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class SellerDTO implements Serializable
{
    String nickname;
    String originalFilename;
    String renamedFilename;
    float score;
}
