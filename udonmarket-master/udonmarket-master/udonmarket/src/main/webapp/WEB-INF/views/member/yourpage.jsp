<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<fmt:requestEncoding value="utf-8"/>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>
<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">

<style>
a{text-decoration: none; color: black;}
</style>

<script>

$(function(){
	$("#passwordAuthModal").modal()
					.on("hide.bs.modal", function(){
						location.href = "${ header.referer }";
					});
});
</script>

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
    
    <!-- 로그인 한 사용자 아이디 -->
 	<sec:authentication property="principal.username" var="loggedInUserId" />
    
    <div class="row py-5 px-4">
	    <div class="col-md-5 mx-auto">
	        <!-- Profile widget -->
	        <div class="bg-white shadow rounded overflow-hidden">
	            <div class="px-4 pt-0 pb-4 cover">
	                <div class="media align-items-end profile-head">
	                    <div class="profile mr-3">
	                    	<img src="${pageContext.request.contextPath }/resources/img/member/${member.renamedFileName == null 
	                    															 ? member.originalFileName:member.renamedFileName}" 
	                    		 alt="..." 
	                    		 width="130" 
	                    		 class="rounded mb-2 img-thumbnail">
	                    	<c:if test="${loggedInUserId == member.userId }">
		                    	<a href="${pageContext.request.contextPath}/member/editprofile?userId=${member.userId}" class="btn btn-outline-dark btn-sm btn-block">Edit profile</a>
	                    	</c:if>
	                    	<c:if test="${loggedInUserId ne member.userId }">
	                    		<a href="${pageContext.request.contextPath}/member/addBlockUser?userId=${loggedInUserId }&blockUserId=${member.userId}" class="btn btn-outline-dark btn-sm btn-block">차단하기</a>
	                    	</c:if>                	
		                   </div>
	                    <div class="media-body mb-5 text-white">
	                        <h4 class="mt-0 mb-0" style="color:white;">${member.nickName}</h4>
	                        <p class="small mb-4" style="color:white;"> <i class="fas fa-map-marker-alt mr-2"></i>${member.address}</p>
	                    </div>
	                </div>
	            </div>
	           <div class="bg-light p-4">
	           <!-- <span class="d-flex justify-content-center"><h2>36.5ºc</h2></span> -->
	           <div class="d-flex justify-content-around text-center">
	           <!-- 여백맞추기용 -->
	           <p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p>
	           <!-- <h2 class="tempe">36.5ºc</h2> -->
	           <!-- 여백맞추기용 -->
	           <p></p><p></p><p></p><p></p>
	                <ul class="list-inline mb-0">
	                    <li class="list-inline-item">            
	                       <h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/salesList?userId=${member.userId}">
	                       		<i class="fas fa-receipt fa-2x" ></i> <br /> 판매내역
	                       	</a>
	                       </h6>
	                    </li>
	                    <c:if test="${loggedInUserId == member.userId }">
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/wishList?userId=${member.userId}">
	                       		<i class="fas fa-heart fa-2x" ></i> <br /> 관심목록
	                       	</a>
	                       </h6>
	                    </li>
	                    </c:if>
	                </ul>
	            </div>				        
	                </div>
	                 <!-- 매너온도 게이지 -->
	              <div class="progress" style="height: 20px;">
					  <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="36.5" aria-valuemin="0" aria-valuemax="100">36.5ºc</div>
					</div>
	            </div>
	            <div class="bg-white">
		        <c:if test="${loggedInUserId == member.userId }">
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">			          
				          <a href="${pageContext.request.contextPath }/member/myNotiList?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-bell"></i>&nbsp; 알림 모아보기
	                      </a>
	                      <a href="${pageContext.request.contextPath}/member/interList" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-star"></i>&nbsp; 관심 주제 목록
	                      </a>
	  				      <a href="${pageContext.request.contextPath }/member/settingsArea?userId=${member.userId}" class="nav-link px-4 rounded-pill">
	                           <i class="fas fa-map-marker-alt"></i>&nbsp; 내 동네 설정
	                      </a>
	                      <a href="">${loginMember.userId}</a>
				          <a href="${pageContext.request.contextPath }/member/keywordNoti?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="fas fa-tag"></i>&nbsp; 키워드 알림 설정
	                      </a>				        
	                      <a href="${pageContext.request.contextPath }/member/blockUser?userId=${member.userId}" class="nav-link px-4 rounded-pill">
	                           <i class="fas fa-user-lock"></i>&nbsp; 차단 사용자 관리
	                      </a>
				        </nav>
	                </div>
	            </div>
		        </c:if>
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
				          <a href="${pageContext.request.contextPath }/member/myReviewList?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-smile"></i>&nbsp; 받은 거래 후기
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/myPost?userId=${member.userId}" class="nav-link px-4 rounded-pill">
	                           <i class="far fa-edit"></i>&nbsp; 동네생활 글
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/myComment?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-comment-dots"></i>&nbsp; 동네생활 댓글
	                      </a>
				        </nav>
	                </div>
	            </div>
		        <c:if test="${loggedInUserId == member.userId }">
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
				          <a href="${pageContext.request.contextPath}/member/announce?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-flag"></i>&nbsp; 공지사항
	                      </a>
				          <a href="${pageContext.request.contextPath}/member/FAQ?userId=${member.userId}" class="nav-link px-4 rounded-pill">
		                      <i class="far fa-question-circle"></i>&nbsp; 자주 묻는 질문
	                      </a>
				        </nav>
	                </div>
	            </div>
                </c:if>
	        </div>
	    </div>
	</div>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	