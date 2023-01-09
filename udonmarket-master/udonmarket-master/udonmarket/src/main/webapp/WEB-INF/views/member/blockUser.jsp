<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>

<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">
<style>
a{text-decoration: none; color: black;}
html { font-size: 16px; }
#tbl th {min-width: 100px; vertical-align: middle;}

}
</style>

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
	<section class="breadcrumb" style="background-color : #ecfdff;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2 style="display: inline-block;">MYPAGE</h2>
					       <img src="${pageContext.request.contextPath }/resources/img/banner/mypage3.png" 
			                                    	 alt="" 
			                                    	 style="max-width: 590px;position: relative; left: 115px;">  	 
                        </div>
                    </div>
                </div>
            </div>
         </div>
    </section>
    <!-- breadcrumb start-->
    
    <!-- LoggdeInUser 정보 가져오기  -->
    <sec:authentication property="principal.username" var="loggedInUser" />	
    
    <div class="row py-5 px-4">
	    <div class="col-md-5 mx-auto">
	        <!-- Profile widget -->
	        <div class="bg-white shadow rounded overflow-hidden">
	            <div class="px-4 pt-0 pb-4 cover">
	                <div class="media align-items-end profile-head">
	                    <div class="profile mr-3">
	                    	 <img src="${pageContext.request.contextPath }/resources/img/member/${member.renamedFileName == null ? member.originalFileName:member.renamedFileName}"
	                    	  alt="..." 
	                    		 width="130" 
	                    		 class="rounded mb-2 img-thumbnail">
	                    	<a href="${pageContext.request.contextPath }/member/mypage?userId=${member.userId}" class="btn btn-outline-dark btn-sm btn-block">Mypage</a>
	                    </div>
	                    <div class="media-body mb-5 text-white">
	                        <h4 class="mt-0 mb-0" style="color:white;">${member.nickName}</h4>
	                        <p class="small mb-4" style="color:white;"> <i class="fas fa-map-marker-alt mr-2"></i>${member.address}</p>
	                    </div>
	                </div>
	            </div>
	            <div class="bg-light p-4 d-flex justify-content-end text-center">
	                <ul class="list-inline mb-0">
	                    <li class="list-inline-item">            
	                       <h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/salesList?userId=${member.userId}">
	                       		<i class="fas fa-receipt fa-2x" ></i> <br /> 판매목록
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/buyList?userId=${member.userId}">
	                       		<i class="fas fa-shopping-bag fa-2x" ></i> <br /> 구매목록
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/wishList?userId=${member.userId}">
	                       		<i class="fas fa-heart fa-2x" ></i> <br /> 관심목록
	                       	</a>
	                       </h6>
	                    </li>
	                </ul>
	            </div>
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
						<div>
							<hr />
							<div style="text-align: center;">
								  차단 사용자
							</div>
						  	<br />			
							<div>
							<table class="table table-hover" id="tbl">
								<tbody>
								<c:if test="${ not empty list}">
									<c:forEach items="${list}" var="b">
										<tr>
											<th><img class="rounded-circle" src="${pageContext.request.contextPath }/resources/img/member/${b.renamedFilename == null ? b.originalFilename:b.renamedFilename}" 
												     alt=""
												     style="max-width: 80px;"></th>
											<td><a href="${pageContext.request.contextPath }/member/mypage?userId=${member.userId}">
											<h5>${b.blockUserNickName }</h5></a>
											${b.blockUserAddr}</td>
											<td style="vertical-align: middle;">
												<button name="btn" class="btn btn-outline-secondary" value="${b.blockUserId }">차단 해제</button>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${ empty list }">
									<tr><td>차단 사용자가 없어요</td></tr>
								</c:if>
								</tbody>
							</table>
							</div>
						</div>
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
<script>
$("[name=btn]").click(function(){
	let $myId = "${loggedInUser}";
	let $blockUserId = $(this).val();

	$.ajax({
		url : "${pageContext.request.contextPath}/member/deleteBlockUser",
		method : "POST",
		data : {
				userId : $myId,
				blockUserId : $blockUserId
		},
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(data){
			alert("차단 해제 했어요 💗");
			location.href = "${pageContext.request.contextPath}/member/blockUser?userId=" + $myId;
		},
		error : function(xhr, status, err){
			console.log("처리 실패", xhr, status, err);
			alert("차단 해제 실패했어요 😥");
		}
	}); 
	
});
</script>
	
	