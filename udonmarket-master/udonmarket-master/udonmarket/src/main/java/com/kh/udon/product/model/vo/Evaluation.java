package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class Evaluation implements Serializable
{
    int evaCode;
    String content;
    int kind;
    String member;
}
