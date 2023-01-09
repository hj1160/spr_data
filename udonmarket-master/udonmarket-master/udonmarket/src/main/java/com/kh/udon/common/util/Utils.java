package com.kh.udon.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Utils {

	public static String getPageBarHtml(int cPage, int numPerPage, int totalContents, String url) {
		String pageBar = "";
		int pageBarSize = 5; //페이지바에 표시될 페이지번호 수
		//(공식2)
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage); 
		//(공식3) pageStart 시작페이지번호 구하기
		//1 2 3 4 5 => pageStart = 1
		//6 7 8 9 10 => pageStart = 6
		//11 12 13 14 15 => pageStart = 11
		// ...
		int pageStart = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
		
		//증감변수
		int pageNo = pageStart;
		
		//[이전] 영역
		if(pageNo == 1) {	
		}
		else {
			pageBar += 
			"<li class='page-item'> " +
					"<a class='page-link' href='" + url + "cPage=" + (pageNo-1) +"' aria-label='Previous'>" +
						"<i class='ti-angle-double-left'></i> " +
					"</a>" +
	        "</li>";
        
		}
		//페이지번호 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			//현재페이지인 경우
			if(pageNo == cPage) {
				pageBar += "<li class='page-item'><a class='page-link' href='javascript:void(0);'>" + pageNo +"</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='" + url + "cPage=" + pageNo + "'>" + pageNo +"</a></li>";
				
			}
			pageNo ++;
		}
		//[다음] 영역
		if(pageNo > totalPage) {
			//while문 빠져나오면서 totalPage보다 +1 된 상태일거니까... 비우기
		}
		else {
			pageBar += 
					"<li class='page-item'> " +
							"<a class='page-link' href='" + url + "cPage=" + pageNo +"' aria-label='Next'>" +
								"<i class='ti-angle-double-right'></i> " +
							"</a>" +
			        "</li>";
			
		}
		
		return pageBar;
	}
	
	public static String getRenamedFileName(String oname) {
		
		//확장자  따로 빼기
		int beginIndex = oname.lastIndexOf("."); //확장자앞에서 잘라내기 위해서 . 찾아냄
		String ext = oname.substring(beginIndex); // 확장자 .txt 
		
		//년원일_시분초밀리초_ 포맷팅설정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		//랜덤값구하기
		int rndNum = (int) (Math.random() * 1000) ; //0 ~ 9999
		
		//합치기 
		String rname = sdf.format(new Date()) + rndNum + ext;
		
		log.debug("rname = {}", rname);
		
		return rname;
	}
	
}
