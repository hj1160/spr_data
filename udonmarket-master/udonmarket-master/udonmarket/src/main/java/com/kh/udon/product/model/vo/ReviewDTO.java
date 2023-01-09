package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ReviewDTO implements Serializable
{
    String sender;
    String receiver;
    int pCode;
    float score;
    String content;
    int[] evaCode;
}
