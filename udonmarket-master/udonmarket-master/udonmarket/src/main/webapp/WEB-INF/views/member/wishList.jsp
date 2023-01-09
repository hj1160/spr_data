<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>

<!-- spinner 위해서 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="pageTitle"/>
</jsp:include>

<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">
<style>
a{text-decoration: none; color: black;}
html { font-size: 16px; }
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
	                        <p class="small mb-4" style="color:white;"> <i class="fas fa-map-marker-alt mr-2"></i>${member.address}</p>
	                    </div>
	                </div>
	            </div>
	            <div class="bg-light p-4 d-flex justify-content-end text-center">
	                <ul class="list-inline mb-0">
	                    <li class="list-inline-item">            
	                       <h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/salesList?userId=${member.userId}">
	                       		<i class="fas fa-receipt fa-2x" ></i> <br /> 판매내역
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/buyList?userId=${member.userId}">
	                       		<i class="fas fa-shopping-bag fa-2x" ></i> <br /> 구매내역
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="#">
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
						<table class="table table-hover">
						  <thead>
						    <tr>
						    	<th colspan="4">
						    	<p class="h6" style="margin-bottom: 0;">관심 목록 </p>
						    	</th>
						    </tr>
						  </thead>
						  <tbody>
						  
						  <c:if test="${not empty list }">
							  <c:forEach items="${list }" var="wish">
							    <tr>
							      <th scope="row">
						      		<!-- 첫번째 상품 이미지로 가져오기 -->
						      		<c:if test="${wish.uploadPath == null}">
									<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
									</c:if>
									<c:if test="${wish.uploadPath != null}">
		                               <img src="${pageContext.request.contextPath }/resources/upload/${wish.uploadPath}/${wish.uuid}/${wish.originalFilename}" 
		                               		onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${wish.PCode}';"
							      			class="img-fluid" alt="product"
							      			style="max-height: 230px;">
									</c:if>	
							       </th>
							      <td colspan="3">
							      	<p style="font-size: 1rem;">${wish.title}</p>
							      	<p style="color: #545454; font-size: 0.9rem;">${wish.sellerAddr}</p>
							      	<p style="font-weight: bold;"><fmt:formatNumber value="${wish.price }" groupingUsed="true"/>원</p>
							      	<br />
							      	<input id="toggle-heart${wish.wishCode}" name="toggle-heart" type="checkbox"/>
									<label id="toggle-heart${wish.wishCode}-label" for="toggle-heart">❤</label> 
							      	${wish.totalWish}
							      	<input type="hidden" name="wishCode" value="${wish.wishCode}" />
							      	<input type="hidden" name="pCode" value="${wish.PCode}" />
							      	<input type="hidden" name="userId" value="${member.userId}" />
							      </td>
							    </tr>
							  </c:forEach>
						  </c:if>
						  <c:if test="${empty list }">
						  	<tr><td colspan="4">아직 관심을 누른 중고거래가 없어요.</td></tr>
						  </c:if>
						  </tbody>
						</table>
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	    
		<!-- loading Modal -->
		<!-- <div class="modal" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  		<div class="modal-dialog modal-sm">
	    		<div class="modal-content">
	    			<div class="text-center">
					  <div class="spinner-border text-primary" role="status"></div>
					</div>
		    	</div>
		  	</div>
		</div> -->
	</div>
	

<script>

$(function(){	

	<!-- loading Modal -->
	/* $(document).ajaxStart(function(){
					$("#exampleModal").modal("show");
			 }).ajaxStop(function(){
				 	$("#exampleModal").modal('hide');
	});  */
	
	$("[for=toggle-heart]").click(function(){
		
		let $heartId = $(this).prev().attr('id');
		let $heartLabel = $heartId + "-label";
		let $wishCode = $(this).next().val();
		console.log($wishCode);
		
		//insertWish
		if($(this).prev().is(":checked")){

 			$.ajax({
				url : "${pageContext.request.contextPath}/member/insertWish",
				method : "POST",
				data : {
						userId : $("[name=userId]").val(),
						wishCode : $wishCode,
						pCode : $("[name=pCode]").val()
				},
				beforeSend : function(xhr){
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success : function(data){
					$("#" + $heartLabel).css("color", "#e2264d");
					$("#" + $heartId).attr("checked", false);
					alert("관심목록에 추가했어요 💗");
					
				},
				error : function(xhr, status, err){
					console.log("처리 실패", xhr, status, err);
					alert("관심목록 추가에 실패했어요 😥");
				}
			}); 
			
		}
		//deleteWish
		else {
			$.ajax({
				url : "${pageContext.request.contextPath}/member/deleteWish",
				method : "POST",
				data : {
						wishCode : $wishCode
				},
				beforeSend : function(xhr){
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
				success : function(data){
					$("#" + $heartLabel).css("color", "#aab8c2");
					$("#" + $heartId).prop("checked", true);
					alert("관심목록에서 제거했어요 💗");
				},
				error : function(xhr, status, err){
					console.log("처리 실패", xhr, status, err);
					alert("관심목록 제거에 실패했어요 😥");
				}
			}); 
			
		}

	});	

/* 	//tr 클릭 했을 때 상세보기로 넘어가기
	$("tr[data-pcode]").click(function(){
		var code = $(this).attr("data-pcode");
		location.href = "${pageContext.request.contextPath}/product/productDetailView?pCode=" + code;
	}); */
	
});
</script>
<style>
[name=toggle-heart] {
  position: absolute;
  left: -100vw;
}
[for='toggle-heart'] {
  color: #e2264d;
}
[name=toggle-heart]:checked + label {
  color: #e2264d;
} 
[for='toggle-heart'] {
  font-size: 1.5em;
  cursor: pointer;
}
[for='toggle-heart'] { 
  align-self: center; 
}
</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	