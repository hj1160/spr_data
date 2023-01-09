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
    
    <sec:authentication property="principal.username" var="userId"/>
    
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
								  알림 모아보기
							</div>
						  	<br />			
							<div>
							<table class="table table-hover" id="tbl">
								<tbody>
								<c:if test="${ not empty list}">
									<c:forEach items="${list}" var="noti">
									<c:if test="${noti.notiCheck eq true }">
										<tr style="background-color: rgba(0, 0, 0, .075);">										
									</c:if>
									<c:if test="${noti.notiCheck eq false }">
										<tr>										
									</c:if>
										<c:choose>
											<c:when test="${noti.notiKind eq 'price'}">
													<th>
														<span>[가격변동]</span>
													</th>
													<td>
														<span><a href="${pageContext.request.contextPath }/member/mypage?userId=${noti.sender }">${noti.senderNickName }</a>님이 
														<a href="${pageContext.request.contextPath }/product/productDetailView?pCode=${noti.PCode }"
															onclick='updateCheck(${noti.notiCode})'>'${noti.PTitle}'</a>
														의 가격을 [<fmt:formatNumber value="${ noti.notiContent }" groupingUsed="true"/>]원 으로 수정했어요 💙		
														</span>
													</td>
								
											</c:when>
											<c:when test="${noti.notiKind eq 'reply'}">

													<th>
														<span>[댓글]</span>
													</th>
													<td>
														<span><a href="${pageContext.request.contextPath }/member/mypage?userId=${noti.sender }">${noti.senderNickName }</a>님이 게시글
														<a href="${pageContext.request.contextPath }/community/communityDetailView?userId=${userId}&bCode=${noti.PCode }"
														   onclick='updateCheck(${noti.notiCode})'>'${noti.PTitle}'</a>
														에 댓글을 달았어요 💬												
														</span>
													</td>
												
											</c:when>
											<c:when test="${noti.notiKind eq 'like'}">
												
													<th>
														<span>[좋아요]</span>
													</th>
													<td>
														<span><a href="${pageContext.request.contextPath }/member/mypage?userId=${noti.sender }">${noti.senderNickName }</a>님이 게시글 
														<a href="${pageContext.request.contextPath }/community/communityDetailView?userId=${userId }&bCode=${noti.PCode }"
														   onclick='updateCheck(${noti.notiCode})'>'${noti.PTitle}'</a>
														의 댓글에 공감했어요 🥰														
														</span>
													</td>
													
											</c:when>
											<c:when test="${noti.notiKind eq 'keyword'}">
												
													<th>
														<span>[키워드]</span>
													</th>
													<td>
														<span><a href="${pageContext.request.contextPath }/member/mypage?userId=${noti.sender }">${noti.senderNickName }</a>님이
														<a href="${pageContext.request.contextPath }/product/productDetailView?pCode=${noti.PCode }"
														   onclick='updateCheck(${noti.notiCode})'>'${noti.PTitle}'</a>
														를 등록했어요 🛒														
														</span>
													</td>
													
											</c:when>
											<c:when test="${noti.notiKind eq 'nego'}">
												
													<th>
														<span>[가격제안]</span>
													</th>
													<td>
														<span><a href="${pageContext.request.contextPath }/member/mypage?userId=${noti.sender }">${noti.senderNickName }</a>님이 
														<a href="${pageContext.request.contextPath }/product/productDetailView?pCode=${noti.PCode }"
														   onclick='updateCheck(${noti.notiCode})'>'${noti.PTitle}'</a>
															 의 가격을  [<fmt:formatNumber value="${ noti.notiContent }" groupingUsed="true"/>]원으로 제안했어요
															 [<a href="#" onclick="openChatRoom('${noti.PCode}','${noti.sender}','${noti.notiCode}')">수락하기</a>] 💌
														</span>
													</td>
											</c:when>
										</c:choose>
									</tr>	
									</c:forEach>
								</c:if>
								<c:if test="${ empty list }">
									<tr><td>받은 알림이 없어요</td></tr>
								</c:if>
								</tbody>
							</table>
							</div>
						</div>
						<!-- 페이징처리 -->
						<div class="col-lg-12">
	                        <div class="pageination">
	                            <nav aria-label="Page navigation example">
	                                <ul class="pagination justify-content-center">
	                                    ${pageBar }
	                                </ul>
	                            </nav>
	                        </div>
	                    </div>
						<!-- 페이징처리 -->
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
<script>

function openChatRoom(pCode, userId, notiCode){
	//alert("클릭");
	let $userId = "${userId}";
	let $buyer = userId;
	let $pCode = pCode;

	//이미 열려있는 채팅방이 있다면 이동
	$.ajax({
		url: "${pageContext.request.contextPath}/chat/openChatRoom",
		method: "POST",
		data: {
			userId: $userId,
			seller: $buyer,
			pCode: $pCode
		},
		beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(data){
        	window.open("${pageContext.request.contextPath}" + data, 'chatting', 'width=1000px, height=800px');			

        	updateCheck(notiCode);
        					
		},
		error: function(xhr, status, err){
			console.log("openChatRoom 실패");
		}
	});
}

</script>	
	
	