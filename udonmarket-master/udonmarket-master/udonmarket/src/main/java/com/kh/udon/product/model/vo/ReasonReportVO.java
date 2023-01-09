package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ReasonReportVO implements Serializable
{
    int reasonCode;
    String reasonContent;
    int parentCode;
    int leaf;
}
