<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>

<sec:authentication property="principal.username" var="userId"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="동네생활" name="pageTitle"/>
</jsp:include>

<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/upload.css"> --%>



<style>
.breadcrumb_bg_02
{
	background-image: url(${pageContext.request.contextPath}/resources/img/breadcrumb_02.png);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/upload.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/modal.css">
<!-- filepond -->
<link href="https://unpkg.com/filepond/dist/filepond.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/filepond-plugin-image-preview.css" rel="stylesheet">
<style>
body
{
	background: #fff;
}
</style>


    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
    <section class="breadcrumb breadcrumb_bg_02">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>게시글 작성하기</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->
<section class="login_part padding_top">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_text text-center" style="background-image:none; width:88%; padding: 0;">
                        <div class="login_part_text_iner">
							<!-- filepond에서 사용히는 file -->
					        <input type="file"/>
					        <p style="color: red;">* 1개의 이미지만 업로드 가능해요  *</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_form" style="padding: 70px 0;">
                        <div class="login_part_form_iner">
	                        <form id="writeForm" name="writeForm" method="post">
		                        <!-- 첨부파일 갯수는 최대 1개 -->
								<input type="hidden" name="uploadFile" />
								<!-- <input type="hidden" name="uploadFile" />
								<input type="hidden" name="uploadFile" />
								<input type="hidden" name="uploadFile" /> -->
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        	<div class="col-md-12 form-group p_star" style="margin-top: 10%;">
                                    <input type="hidden" id="userId" name="userId" value="${ userId }" required
											class="single-input-primary" readonly required style="background-color: #f6f6f6; width: 50%">
                                </div>
                                <div class="col-md-12 form-group p_star">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                	<!-- <a href="#" class="genric-btn default-border" style="width: 100%;">카테고리 선택 &nbsp;&nbsp;&nbsp;&nbsp; ></a> -->
                                	
										<select id="categoryCode" name="categoryCode">
										    <option value="">카테고리 선택</option>
										    <option value="17">동네생활이야기</option>
										    <option value="18">우리동네질문</option>
										    <option value="19">분실/실종센터</option>
										    <option value="20">동네사건사고</option>
										</select>
                                </div>
                                <div class="col-md-12 form-group p_star">
                                    <input type="text" id="boardTitle"name="boardTitle" placeholder="글 제목" onfocus="this.placeholder = ''" onblur="this.placeholder = '글 제목'" required class="single-input-primary">
                                </div>
                               
                                
                                <div class="col-md-12 form-group p_star">
									<textarea class="single-textarea" id="boardContent"name="boardContent" placeholder="내용" onfocus="this.placeholder = ''" onblur="this.placeholder = '내용'" style="height: 240px;" required></textarea>
                                </div>
                                <div class="col-md-12 form-group p_star">
                                    	<select id="hashtagCode" name="hashtagCode">
										    <option value="100">태그 선택</option>
										    <option value="1">#강아지</option>
										    <option value="2">#고양이</option>
										    <option value="3">#건강</option>
										    <option value="4">#동네맛집</option>
										    <option value="5">#동네카페</option>
										    <option value="6">#살림/청소/정리</option>
										    <option value="7">#식물</option>
										    <option value="8">#임신/출산/육아</option>
										    <option value="9">#집꾸미기</option>
										    
										</select>
                                </div>
                                <div class="col-md-12 form-group p_star">
	                               <!-- <input type="submit" value="게시글 등록" class="btn_1" /> -->
	                                <a onClick='fn_addtoBoard()' class="btn_3" style="text-align: center; cursor:pointer;">게시글 등록</a>
	                                    
                           		 </div>
                           		 </form>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
    </section>


<!-- ================ filepond ================  -->
<script src="https://unpkg.com/filepond-plugin-file-metadata/dist/filepond-plugin-file-metadata.js"></script>
<script src="https://unpkg.com/filepond-plugin-image-crop/dist/filepond-plugin-image-crop.js"></script>

<script src="${pageContext.request.contextPath }/resources/js/filepond-plugin-image-preview.js"></script>
<script src="https://unpkg.com/filepond/dist/filepond.js"></script>
    
<script>
const f = document.querySelector('input[type="file"]');
const pond = FilePond.create
			(f, { 
					maxFiles: 1,
                   	allowMultiple: true,
                   	acceptedFileTypes: ['image/*'],
                   	server: { 
	                   			url: "<c:url value='/community' />",
                   	        	process: {url: "/boardSaveFile.do?${_csrf.parameterName}=${_csrf.token}" },
                   	        	revert: function (fileId, load, error) { fn_revertFile(fileId); load(); }
							}
                    }
			);


//업로드가 모두 처리된 후 호출되는 callback
//서버로 부터 받은 파일 키를 배열에 저장하고 필요할 때 사용한다.
var uploadedfiles = [];
pond.on('processfile', function (e, f) 
{
    console.log(f.serverId);
    uploadedfiles.push(f.serverId);
});


var x = new XMLHttpRequest();
var handleStateChange = function () 
{
	/*
		    0: request not initialized
		    1: server connection established
		    2: request received
		    3: processing request
		    4: request finished and response is ready
    */
    
	if(x.readyState == 4 && x.status == 200) //정상처리
	{ 
	    console.log(x.responseText);
	} 
	else 
	{
	    console.log(x.readyState);
	}
};

/* 파일 업로드 취소 */
function fn_revertFile(fileId) 
{
	let p = uploadedfiles.indexOf(fileId);
	uploadedfiles.splice(p,1);

	// 고전적인 AJAX
	if (window.XMLHttpRequest) 
	{
	    x = new XMLHttpRequest();
		x.open("POST", "<c:url value='/community/boardDeleteFile.do?${_csrf.parameterName}=${_csrf.token}'/>", true); // async 
		x.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		x.onreadystatechange = handleStateChange;
		x.send("fileId=" + fileId); //POST방식일때 send()를 사용하여 querystring형태로 전달한다.
   		//str = x.responseText;	//sync일때는 여기서 결과를 받을 수 있다.
		//x=null;
	}
}

/* 파일 업로드 */
function fn_addtoBoard() 
{
	uploadedfiles.forEach
	(
		function(id, index) 
		{
			document.writeForm.uploadFile.value = id;
			console.log(document.writeForm.uploadFile.value);
		}
	);

	document.writeForm.action = "<c:url value='/community/communityForm'/>";
	document.writeForm.submit();

}

//function fn_addtoBoard(){
//    
//    var form = document.getElementById("writeForm");
//    
//    form.action = "<c:url value='/community/communityForm'/>";
//    form.submit();
//    
//}
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	