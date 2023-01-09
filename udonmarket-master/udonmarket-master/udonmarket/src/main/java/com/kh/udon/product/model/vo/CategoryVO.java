package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class CategoryVO implements Serializable
{
    private int categoryCode;
    private int categoryParent;
    private String categoryName;
}
