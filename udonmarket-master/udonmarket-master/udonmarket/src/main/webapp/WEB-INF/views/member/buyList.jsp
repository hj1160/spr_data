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
	                       	<a href="${pageContext.request.contextPath }/member/salesList?userId=${member.userId}">
	                       		<i class="fas fa-receipt fa-2x" ></i> <br /> 판매목록
	                       	</a>
	                       </h6>
	                    </li>
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="#">
	                       		<i class="fas fa-shopping-bag fa-2x" ></i> <br /> 구매목록
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
						<table class="table table-hover">
						  <thead>
						    <tr>
						    	<th colspan="4">
						    	<p class="h6" style="margin-bottom: 0;">구매 내역</p>
						    	</th>
						    </tr>
						  </thead>
						  <tbody>
						  	<c:if test="${not empty list }">
						  		<c:forEach items="${list }" var="buy">
								    <tr>
								      <th scope="row">
							      		<!-- 첫번째 상품 이미지로 가져오기 -->
							      		<c:if test="${buy.uploadPath == null}">
										<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
										</c:if>
										<c:if test="${buy.uploadPath != null}">
			                               <img src="${pageContext.request.contextPath }/resources/upload/${buy.uploadPath}/${buy.uuid}/${buy.originalFilename}" 
			                               		onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${buy.PCode}';"
								      			class="img-fluid" alt="product"
								      			style="max-height: 230px;">
										</c:if>						      	
								       </th>
								      <td colspan="3">
								      	<p style="font-size: 1rem;">${buy.title }</p>
								      	<p style="color: #545454; font-size: 0.9rem;">${buy.sellerAddr }</p>						      	
								      	<p style="font-weight: bold;">
								      		<span class="badge badge-secondary">거래완료</span>
								      		<fmt:formatNumber value="${buy.price }" groupingUsed="true"/>원
								      	</p>
								      	<i class="far fa-heart"></i> ${buy.totalWish}
									      	<i class="far fa-comments"></i> ${buy.totalChat }<br />
								      	<c:if test="${loggedInUserId == member.userId }">
								      	<div style="margin:10px 0px;">
								      	<!-- 작성 후기가 있다면 후기 보기 페이지로 -->
								      	<c:if test="${ buy.reviewCode ne 0}">
									      	<button type="button" class="btn btn-outline-secondary btn-sm"
									      			style="margin: 0px 0.15rem;"
									      			onclick="reviewInfo('${buy.reviewCode}', '${buy.seller }')">작성한 후기 보기</button>
								      	</c:if>
								      	<!-- 작성 후기 없다면 후기 작성 페이지로 이동 -->
								      	<c:if test="${ buy.reviewCode eq 0}">
								      		<button type="button" class="btn btn-outline-secondary btn-sm"
									      			style="margin: 0px 0.15rem;"
									      			onclick="insertReview('${buy.PCode}', '${buy.seller }')">후기 작성하러 가기</button>
								      	</c:if>
								      	</div>
								      	</c:if>
								      </td>
								    </tr>
						  		</c:forEach>
						  	</c:if>
						  	<c:if test="${empty list }">
						  		<tr><td colspan="4">
						  			<p>구매 내역이 없어요</p>
						  			<p>동네 이웃과 따뜻한 거래를 해보세요</p>
						  		</td></tr>
						  	</c:if>
						  </tbody>
						</table>
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	
<!-- ========== 구매자 선택 MODAL START ========== -->
<div class="modal fade" id="selectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><strong>구매자 선택</strong></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	   <div class="row text-center align-items-end">
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white rounded-lg">
				<div class="p-4 text-left" id="body">
					<span><strong><span id="seller"></span>님과 거래가 어떠셨나요?</strong></span><br/>
					<span>선택 항목은 상대방이 알 수 없어요.</span><hr/>
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="widgets_inner pb-0">
								<!-- 온도 -->
								<a href="javascript:score(35.5)" class="genric-btn danger circle mr-2">별로예요</a>
								<a href="javascript:score(37.5)" class="genric-btn warning circle mr-2">좋아요!</a>
								<a href="javascript:score(37.5)" class="genric-btn primary circle mr-2">최고예요!</a><hr/>
								<!-- 평가 -->
								<div class="widgets_inner pb-0" id="eva">
								</div><hr/>
								<textarea class="single-textarea" placeholder="감사인사를 남겨주세요" style="height: 134px;" name="content"></textarea>
							</div>
						</aside>
					</div><hr/><br/>
				</div>
	        </div>
	      </div>
      	</div>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">지금 안할래요</button>
      </div>
    </div>
  </div>
</div>

<form id="reviewFrm" method="post" action="${pageContext.request.contextPath }/product/insertReviewByBuyer">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="sender" value="${loggedInUserId }"/>
	<input type="hidden" name="receiver"/> 
	<input type="hidden" name="pCode"/>
	<input type="hidden" name="score" />
	<input type="hidden" name="content" />
</form>
<!-- ========== 구매자 선택 MODAL END ========== -->

<!-- ========== 남긴 거래후기 MODAL START ========== -->
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><strong>내가 남긴 거래 후기</strong></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	   <div class="row text-center align-items-end">
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white rounded-lg">
				<div class="p-4 text-left" id="body">
					<span><strong><span id="seller2"></span>님에게 따뜻한 후기를 보냈어요.</strong></span><br/>
					<span>남겨주신 거래후기는 상대방의 프로필에 공개됩니다.</span><hr/>
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="widgets_inner pb-0">
								<!-- 평가 -->
								<div class="widgets_inner pb-0" id="eva2"></div>
								<textarea class="single-textarea" placeholder="감사인사를 남겨주세요" style="height: 134px;" 
										  name="content" id="reviewISent" disabled></textarea>
							</div>
						</aside>
					</div><hr/><br/>
				</div>
	        </div>
	      </div>
      	</div>
	  </div>
    </div>
  </div>
</div>
<!-- ========== 남긴 거래후기 MODAL END ========== -->
	
	
	
<script>
$(function(){

	
	
});

function reviewInfo(reviewCode, seller)
{
	$("#seller2").text(seller);

	var str = "";

	$.ajax
	({
		url: "${pageContext.request.contextPath}/product/" + reviewCode,
		method: "GET",
		beforeSend: function(xhr)
		{
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        dataType: "text",
		success: function(content)
		{
			console.log(content);
			$("#reviewISent").html(content);
		},
		error: function(xhr, status, err)
		{
			alert("리뷰 불러오기에 실패했어요 💧");
			console.log(xhr, status, err);
		}
	});
	
	$("#reviewModal").modal('show');
}

function insertReview(pCode, seller)
{
	$("#seller").text(seller);
	$("input[name=pCode]").val(pCode);
	$("input[name=receiver]").val(seller);
	
	$("#selectModal").modal('show');
}

/* score click fn */
function score(score)
{
	$("input[name=score]").val(score);

	var str = "";

	$.ajax
	({
		url: "${pageContext.request.contextPath}/product/evaListforBuyer/" + score,
		method: "GET",
		beforeSend: function(xhr)
		{
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        dataType: "json",
		success: function(list)
		{
			$.each(list,function(i,v)
			{
				str += "<div class='switch-wrap d-flex justify-content-between'>";
				str += "<p>" + v.content + "</p>";
				str += "<div class='primary-checkbox'>";
				str += "<input type='checkbox' name='eva' id='primary-checkbox" + i + "' value='" + v.evaCode + "'>";
				str += "<label for='primary-checkbox" + i + "'></label>";
				str += "</div>";
				str += "</div>";
			});

			var btn = "<button type='button' class='btn btn-primary float-right' onclick='reviewSubmit()'>완료</button>";
			
			$("#body").after(btn);
			$("#eva").html(str);
		},
		error: function(xhr, status, err)
		{
			alert("평가목록 불러오기에 실패했어요 💧");
			console.log(xhr, status, err);
		}
	});
}

/* review submit */
function reviewSubmit()
{
	var $frm = $("#reviewFrm");
	
	$("input[name=eva]:checked").each(function() 
	{
		$frm.append($('<input/>', {type: 'hidden', name: 'evaCode', value: $(this).val()}))
	});

	$("input[name=content]").val($("textarea[name=content]").val());
	$frm.submit();
}

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
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	