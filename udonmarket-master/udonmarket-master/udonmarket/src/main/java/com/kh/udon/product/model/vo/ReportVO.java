package com.kh.udon.product.model.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class ReportVO implements Serializable
{
    int reportCode;
    int reasonCode;
    String reportId;
    String shooterId;
    int bCode;
    int pCode;
    int replyCode;
    int checked;
}
