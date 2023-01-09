package com.kh.udon.community.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class Boardphoto implements Serializable {

	private int photoCode;
    private String originalFilename;
    private String uuid;
    private String uploadPath;
    
    private int bCode;
	
}
