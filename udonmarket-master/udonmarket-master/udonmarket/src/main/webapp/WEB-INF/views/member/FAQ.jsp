<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="FAQ" name="pageTitle"/>
</jsp:include>

<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">
<link href="//cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.4.0/css/bootstrap4-toggle.min.css" rel="stylesheet">  
<script src="//cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.4.0/js/bootstrap4-toggle.min.js"></script>
<style>
a{text-decoration: none; color: black;}
html { font-size: 16px; }
.slidecontainer {width: 100%;}

.slider {
  -webkit-appearance: none;
  width: 100%;
  height: 15px;
  border-radius: 5px;
  background: #d3d3d3;
  outline: none;
  opacity: 0.7;
  -webkit-transition: .2s;
  transition: opacity .2s;
}

.slider:hover {
  opacity: 1;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #4CAF50;
  cursor: pointer;
}

.slider::-moz-range-thumb {
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #4CAF50;
  cursor: pointer;
}

tr[data-board-no] {
	cursor: pointer;
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
                            <h2 style="display: inline-block;">FAQ</h2>
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
    
    
    
    
    <div class="row py-5 px-4">
	    <div class="col-md-5 mx-auto">
	        <!-- Profile widget -->
	        <div class="bg-white shadow rounded overflow-hidden">
	            <div class="px-4 pt-0 pb-4 cover">
	                <div class="media align-items-end profile-head">
	                    <div class="profile mr-3">
	                    	<!-- LoggdeInUser 정보 가져오기  -->
	                        <sec:authentication property="principal" var="loggedInUser" />
	                    	<img src="${pageContext.request.contextPath }/resources/img/member/${member.renamedFileName == null 
	                    															 ? member.originalFileName:member.renamedFileName}" 
	                    		 alt="..." 
	                    		 width="130" 
	                    		 class="rounded mb-2 img-thumbnail">
	                    	<a href="${pageContext.request.contextPath }/member/mypage?userId=${member.userId}" class="btn btn-outline-dark btn-sm btn-block">Mypage</a>
	                    </div>
	                    <div class="media-body mb-5 text-white">
	                        <h4 class="mt-0 mb-0" style="color:white;">${member.nickName}</h4>
	                        <p class="small mb-4" id="addr" style="color:white;"> <i class="fas fa-map-marker-alt mr-2"></i>${member.address}</p>
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
	            <hr />
				<div style="text-align: center; ">
					<h5 style="font-weight: bold;
						  		color: #575757;">자주 묻는 질문</h5> 		
				    
				</div>
				<hr />			
	              <!-- 탭 리스트 -->
	              <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
				  <li class="nav-item">
				    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">사기,허위 대처</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">거래 매너</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">기타</a>
				  </li>
				</ul>
				<!-- 탭 내용 -->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
										<div class="tab-content" id="pills-tabContent">
						  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
						  <table id="tbl-board" class="table table-hover">
						  <thead class="thead-dark">
							    <tr>
							      <th scope="col">번호</th>
							      <th scope="col">제목</th>
							      <th scope="col">작성자</th>
							      <th scope="col">작성일</th>
							    </tr>
							  </thead>
									<c:forEach items="${list}" var="announce">
								<c:if test="${announce.categoryCode eq '61' }">
									<tr data-board-no="${ announce.BCode }"
									onclick="location.href='${ pageContext.request.contextPath }/member/FAQDetail?bCode=${announce.BCode}&userId=${member.userId}';">
										<td>${ announce.BCode }</td>
										<td>${ announce.boardTitle }</td>
										<td>${ announce.userId }</td>
										<td><fmt:formatDate value="${ announce.regDate }" type="both"/></td>
									</tr>
									</c:if>
									</c:forEach>
							</table>
							<sec:authorize access="hasRole('ADMIN')">
							<c:if test="${member.userId == 'admin' }">
							<ul class="nav justify-content-end">
                               	<a class="btn btn-primary" href="${pageContext.request.contextPath }/member/FAQForm?userId=${member.userId}"
                               	 role="button">글쓰기</a>
                            </ul>
                            </c:if>
                            </sec:authorize>
							</div>
						  
						  <!-- 거래 매너 -->		
						  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
						  <table id="tbl-board" class="table table-striped table-hover">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
									<c:forEach items="${list}" var="announce">
								<c:if test="${announce.categoryCode eq '62' }">
									<tr data-board-no="${ announce.BCode }"
									onclick="location.href='${ pageContext.request.contextPath }/member/FAQDetail?bCode=${announce.BCode}&userId=${member.userId}';">
										<td>${ announce.BCode }</td>
										<td>${ announce.boardTitle }</td>
										<td>${ announce.userId }</td>
										<td><fmt:formatDate value="${ announce.regDate }" type="both"/></td>
									</tr>
									</c:if>
									</c:forEach>
							</table>
							<sec:authorize access="hasRole('ADMIN')">
							<c:if test="${member.userId == 'admin' }">
							<ul class="nav justify-content-end">
                               	<a class="btn btn-primary" href="${pageContext.request.contextPath }/member/FAQForm?userId=${member.userId}"
                               	 role="button">글쓰기</a>
                            </ul>
                            </c:if>
                            </sec:authorize>
							</div>
					      <!-- 기타 -->
						  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
						  <table id="tbl-board" class="table table-striped table-hover">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
									<c:forEach items="${list}" var="announce">
								<c:if test="${announce.categoryCode eq '63' }">
									<tr data-board-no="${ announce.BCode }"
									onclick="location.href='${ pageContext.request.contextPath }/member/FAQDetail?bCode=${announce.BCode}&userId=${member.userId}';">
										<td>${ announce.BCode }</td>
										<td>${ announce.boardTitle }</td>
										<td>${ announce.userId }</td>
										<td><fmt:formatDate value="${ announce.regDate }" type="both"/></td>
									</tr>
									</c:if>
									</c:forEach>
							</table>
							<sec:authorize access="hasRole('ADMIN')">
							<c:if test="${member.userId == 'admin' }">
							<ul class="nav justify-content-end">
                               	<a class="btn btn-primary" href="${pageContext.request.contextPath }/member/FAQForm?userId=${member.userId}"
                               	 role="button">글쓰기</a>
                            </ul>
                            </c:if>
                            </sec:authorize>
							</div>
						</div>		
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	