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
	                       	<a href="#">
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
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
						
							<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
							  <li class="nav-item">
							    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">거래중</a>
							  </li>
							  <li class="nav-item">
							    <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">거래완료</a>
							  </li>
							  <c:if test="${loggedInUserId == member.userId }">
							  <li class="nav-item">
							    <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">숨김</a>
							  </li>
							  </c:if>
							</ul>
							<div class="tab-content" id="pills-tabContent">
							  <!-- 판매중 -->
							  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
							  	<table class="table table-hover">
								  <tbody>
								  <c:if test="${not empty sale }">
								  	<c:forEach items="${sale }" var="sale">
									    <tr>
									      <th scope="row">
								      		<!-- 첫번째 상품 이미지로 가져오기 -->
								      		<c:if test="${sale.uploadPath == null}">
											<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
											</c:if>
											<c:if test="${sale.uploadPath != null}">
				                               <img src="${pageContext.request.contextPath }/resources/upload/${sale.uploadPath}/${sale.uuid}/${sale.originalFilename}" 
				                               		onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${sale.PCode}';"
									      			class="img-fluid" alt="product"
									      			style="max-height: 230px;">
											</c:if>
									       </th>
									      <td colspan="3">
									      	<p style="font-size: 1rem;">${sale.title }</p>
									      	<p style="color: #545454; font-size: 0.9rem;">${sale.sellerAddr }</p>
									      	<p style="font-weight: bold;">
									      		<span class="badge badge-primary" id="s_${sale.PCode }" 
									      			  ${ sale.tradeStatus eq "S" ? '' : 'style="display:none;"'}>판매중</span>
									      		<span class="badge badge-info" id="r_${sale.PCode }"
									      			  ${ sale.tradeStatus eq "R" ? '' : 'style="display:none;"'}>예약중</span>
									      		<fmt:formatNumber value="${sale.price }" groupingUsed="true"/>원
									      	</p>
									      	<i class="far fa-heart"></i> ${sale.totalWish}
									      	<i class="far fa-comments"></i> ${sale.totalChat }<br />
									      	<c:if test="${loggedInUserId == member.userId }">
									      	<div style="margin:10px 0px;">
										      	<c:if test="${sale.tradeStatus eq 'S' }">
										      	<button type="button" class="btn btn-outline-secondary btn-sm"
										      			style="margin: 0px 0.15rem;" value="R"
										      			onclick="changeStatus('${sale.PCode} ','${sale.tradeStatus}', this)">예약중으로 변경</button>
										      	</c:if>
										      	<c:if test="${sale.tradeStatus eq 'R' }">
										      	<button type="button" class="btn btn-outline-secondary btn-sm"
										      			style="margin: 0px 0.15rem;" value ="S"
										      			onclick="changeStatus('${sale.PCode} ','${sale.tradeStatus}', this)">판매중으로 변경</button>
										      	</c:if>
										      	<%-- <button type="button" class="btn btn-outline-secondary btn-sm"
										      			style="margin: 0px 0.15rem;" value="C"
										      			onclick="changeStatus('${sale.PCode} ','${sale.tradeStatus}', this)">거래완료로 변경</button> --%>
									      	</div>
									      	</c:if>
									      </td>
									      <td>
		                                    <c:if test="${loggedInUserId == member.userId }">
											<ul>
												<li class="nav-item dropdown">
				                                    <a class="nav-link dropdown-toggle" id="navbarDropdown_1"
				                                       aria-haspopup="true" aria-expanded="false">
				                                    </a>
				                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown_1">
				                                    	<button class="dropdown-item" type="button" onclick="updateProduct('${sale.PCode}', '${sale.categoryName }');">수정</button>
													    <button class="dropdown-item" type="button" onclick="hideProduct('${sale.PCode }');">숨기기</button>
													    <button class="dropdown-item" type="button" onclick="deleteProduct('${sale.PCode }');">게시물 삭제</button>
				                                    </div>
				                                </li>
			                                </ul>
		                                    </c:if>
									      </td>
									    </tr>  
								  	</c:forEach>
								  </c:if>
								  <c:if test="${empty sale }">
								  	<tr><td>판매중인 게시글이 없어요</td></tr>
								  </c:if>
								  </tbody>
								</table>							  
							  </div>
							  <!-- 거래 완료 -->
							  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
							  	<table class="table table-hover">
								  <tbody>
								  <c:if test="${not empty complete }">
								  	<c:forEach items="${complete }" var="c">
									    <tr>
									      <th scope="row">
								      		<!-- 첫번째 상품 이미지로 가져오기 -->
								      		<c:if test="${c.uploadPath == null}">
											<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
											</c:if>
											<c:if test="${c.uploadPath != null}">
				                               <img src="${pageContext.request.contextPath }/resources/upload/${c.uploadPath}/${c.uuid}/${c.originalFilename}" 
				                               		onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${c.PCode}';"
									      			class="img-fluid" alt="product"
									      			style="max-height: 230px;">
											</c:if>
									       </th>
									      <td colspan="3">
									      	<p style="font-size: 1rem;">${c.title }</p>
									      	<p style="color: #545454; font-size: 0.9rem;">${c.sellerAddr }</p>
									      	<p style="font-weight: bold;">
									      		<span class="badge badge-secondary">거래완료</span>
									      		<fmt:formatNumber value="${c.price }" groupingUsed="true"/>원
									      	</p>
									      	<i class="far fa-heart"></i> ${c.totalWish}
									      	<i class="far fa-comments"></i> ${c.totalChat }<br />
									      	<c:if test="${loggedInUserId == member.userId }">
									      	<div style="margin:10px 0px;">
										      	<button type="button" class="btn btn-outline-secondary btn-sm"
										      			style="margin: 0px 0.15rem;" value ="S"
										      			onclick="changeStatus('${c.PCode} ','${c.tradeStatus}', this)">판매중으로 변경</button>
									      	</div>
									      	</c:if>
									      </td>
									      <td>
									      	<c:if test="${loggedInUserId == member.userId }">
									      	<ul>
												<li class="nav-item dropdown">
				                                    <a class="nav-link dropdown-toggle" id="navbarDropdown_1"
				                                       aria-haspopup="true" aria-expanded="false">
				                                    </a>
				                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown_1">
				                                    	<button class="dropdown-item" type="button" onclick="updateProduct('${c.PCode}', '${c.categoryName }');">수정</button>
				                                    	 <button class="dropdown-item" type="button" onclick="hideProduct('${c.PCode }');">숨기기</button>
														<button class="dropdown-item" type="button" onclick="deleteProduct('${c.PCode }');">게시물 삭제</button>
				                                    </div>
				                                </li>
			                                </ul>
			                                </c:if>
									      </td>
									    </tr>  
								  	</c:forEach>
								  </c:if>
								  <c:if test="${empty complete }">
								  	<tr><td>거래 완료 게시글이 없어요</td></tr>
								  </c:if>
								  </tbody>
								</table>
							  </div>
							  <!-- 숨김 -->
							  <c:if test="${loggedInUserId == member.userId }">
							  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
							  	<table class="table table-hover">
								  <tbody>
								  <c:if test="${not empty hidden }">
								  	<c:forEach items="${hidden }" var="h">
									    <tr>
									      <th scope="row">
									      	<!-- 상품 상세 페이지로 이동하게 설정할 것  p_code -->
									      	<c:if test="${h.uploadPath == null}">
											<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
											</c:if>
											<c:if test="${h.uploadPath != null}">
				                               <img src="${pageContext.request.contextPath }/resources/upload/${h.uploadPath}/${h.uuid}/${h.originalFilename}" 
				                               		onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${h.PCode}';"
									      			class="img-fluid" alt="product"
									      			style="max-height: 230px;">
											</c:if>
									       </th>
									      <td colspan="3">
									      	<p style="font-size: 1rem;">${h.title }</p>
									      	<p style="color: #545454; font-size: 0.9rem;">${h.sellerAddr }</p>
									      	<p style="font-weight: bold;">
									      		<fmt:formatNumber value="${h.price }" groupingUsed="true"/>원
									      	</p>
									      	<i class="far fa-heart"></i> ${h.totalWish}
									      	<i class="far fa-comments"></i> ${h.totalChat }<br />
									      	<div style="margin:10px 0px;">
									      	<button type="button" class="btn btn-outline-secondary btn-sm"
									      			style="margin: 0px 0.15rem;"
									      			onclick="openProduct('${h.PCode }');">숨기기 해제</button>
									      	</div>
									      </td>
									      <td>
									      	<ul>
												<li class="nav-item dropdown">
				                                    <a class="nav-link dropdown-toggle" id="navbarDropdown_1"
				                                       aria-haspopup="true" aria-expanded="false">
				                                    </a>
				                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown_1">
				                                    	<button class="dropdown-item" type="button" onclick="updateProduct('${h.PCode}', '${h.categoryName }');">수정</button>
														<button class="dropdown-item" type="button" onclick="deleteProduct('${h.PCode }');">게시물 삭제</button>
				                                    </div>
				                                </li>
			                                </ul>
									      </td>
									    </tr>  
								  	</c:forEach>
								  </c:if>
								  <c:if test="${empty hidden }">
								  	<tr><td>숨기기한 게시글이 없어요</td></tr>
								  </c:if>
								  </tbody>
								</table>
							  </div>
							  </c:if>
							  <input type="hidden" Id="userId_" value="${member.userId }" />
							</div>
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
<script>
/* 숨기기 */
function hideProduct(pCode)
{
	if(confirm("숨기기 기능을 사용하면 상품이 이웃들에게 노출되지 않습니다."))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/product/hide/" + pCode,
			method: "POST",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        dataType: "json",
			success: function(map)
			{
				alert(map.msg);
				location.href = "${pageContext.request.contextPath}/member/salesList?userId=${loggedInUserId}";									
			},
			error: function(xhr, status, err)
			{
				alert("상품 숨기기에 실패했어요 💧");
				console.log(xhr, status, err);
			}
		});

	}
	else
		return false;
}
//숨기기해제
function openProduct(pCode)
{
	if(confirm("이웃들에게 다시 상품을 보여줄까요?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/product/show/" + pCode,
			method: "POST",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        dataType: "json",
			success: function(map)
			{
				alert(map.msg);
				location.href = "${pageContext.request.contextPath}/member/salesList?userId=${loggedInUserId}";									
			},
			error: function(xhr, status, err)
			{
				alert("상품 숨기기에 실패했어요 💧");
				console.log(xhr, status, err);
			}
		});

	}
	else
		return false;
}

function updateProduct(pCode, category){
	location.href = "${ pageContext.request.contextPath }/product/updateProduct?pCode=" + pCode + "&categoryName=" + category;
}

function deleteProduct(pCode)
{
	if(confirm("삭제할까요?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/product/" + pCode,
			method: "PUT",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        dataType: "json",
			success: function(map)
			{
				alert(map.msg);
				location.href = "${pageContext.request.contextPath}/member/salesList?userId=" + $("#userId_").val();								
			},
			error: function(xhr, status, err)
			{
				alert("상품 삭제에 실패했어요 💧");
				console.log(xhr, status, err);
			}
		});
	}
	else
		return false;
}

function changeStatus(pCode, currentStatus, elem){

	//바꿀 거래 상태
	let status = $(elem).val();
	
	//거래 완료로 변경 일경우 채팅 사용자 고르고 후기 작성하는 페이지로 이동
	if(status == "C"){

	}
	else{
		
		$.ajax({
			url: "${pageContext.request.contextPath}/product/changeStatus",
			method: "POST",
			data: 
			{
				status: status,
				pCode: pCode
			}, 
			dataType: "text",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
				success: function(result)
			{

				if(currentStatus=="C"){		
					location.href = "${pageContext.request.contextPath}/member/salesList?userId=" + $("#userId_").val();						
				}else if(currentStatus!="C" && status=="R"){
			 		$("#r_"+ pCode).show();
			 		$("#s_" + pCode).hide();

 			 		$(elem).val("S");
			 		$(elem).text("판매중으로 변경");			 		
				 		
				}else if(currentStatus!="C" && status=="S"){
			 		$("#r_"+ pCode).hide();
			 		$("#s_" + pCode).show();

			 		$(elem).val("R");
			 		$(elem).text("예약중으로 변경");
				}
				
				alert(result);
				
			},
			error: function(xhr, status, err)
			{ 
				alert("상태 변경에 실패했어요 💧");
			}
		});
	}	
};


</script>
<style>
[name=toggle-heart] {
  position: absolute;
  left: -100vw;
}
[for='toggle-heart'] {
  color: #aab8c2;
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