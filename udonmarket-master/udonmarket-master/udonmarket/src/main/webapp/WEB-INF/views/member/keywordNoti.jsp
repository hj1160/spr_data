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
							<div style="text-align: center; ">
								<h5 style="font-weight: bold;
									  		color: #575757;">키워드 알림 설정</h5> 		
							    <p id="myLocal" style=" color: #575757;"></p>
							</div>
							<hr />							  
							<div>
								 <h5 style="font-weight: bold;
									  		color: #575757;">키워드 알림</h5>
								 <p style="color: #575757;">키워드를 등록해두면, 해당 키워드와 관련된 판매글이 올라올때 푸시 알림을 받을 수 있어요.</p>
								 <a href="#" style="color: #007bff;">혹시 키워드 알림이 오지 않나요?</a>
							</div>
							<br />
							<form:form class="insertKeyword">
								<div class="input-group mb-3">
								  <input type="text"
								  		 name="keyword"
								  		 class="form-control" 
								  		 placeholder="키워드를 입력해주세요(2글자 이상)" 
								  		 aria-label="Recipient's username" 
								  		 aria-describedby="basic-addon2">
								  <!-- value = 로그인 중인 유저 아이디 -->
								  <input type="hidden" name="userId" value="${member.userId}" />
								  <div class="input-group-append">
							      <input type="button" 
							      		 id="btn-insert"
							    	     class="btn btn-outline-secondary" 
							    	     value="등록" />
								  </div>
								</div>
								<span class="guide error">이미 추가된 키워드예요 🤔 </span>
							</form:form>
							<br />
							<p>등록된 키워드  <mark style="color: red; background: white;">${totalKeywordContents}</mark>/ 10</p>
							<input type="hidden" id="totalKeywordContents" value="${totalKeywordContents}" />
							<div>
								<c:if test="${ not empty list }">
									<c:forEach items="${ list }" var="key">
										<div id="keywordList" style="display: inline-block;">
											<span id="keyCode${key.keyCode}" class="btn btn-outline-primary btn-sm">${key.keyContent}
											<button type="button" 
													onclick="deleteKey('${ key.keyCode }', '${key.keyContent}')"
													style="background: none; border: none;">x</button>
											</span>
										</div>							
									</c:forEach>
								</c:if>
								<c:if test="${ empty list }"></c:if>
							</div>
						</div>													
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
<script>
$(function(){
	$(".guide.error").hide();
	$("#idValid").val(0);
	$("#btn-insert").attr('disabled', true);
	
	//키워드 10개 이상 추가 막기
	if( $("#totalKeywordContents").val() >= 10 ){
		$("[name=keyword]").attr("readonly", true);
		$("[name=keyword]").attr("placeholder", '키워드는 최대 10개까지 설정할 수 있어요');
	}

	//키워드 중복 검사
	$("[name=keyword]").keyup(function(){

	 	if($(this).val().length < 2){
	 		$(".guide.error").hide();
			$("#btn-insert").attr('disabled', true);
			return;
		} 
		
		$.ajax({
			url : "${pageContext.request.contextPath}/member/checkKeywordDuplicate",
			data : {
				userId : $("[name=userId]").val(),
				keyword : $("[name=keyword]").val()
			},
			dataType : "json",
			success : function(data){
				//console.log(data);

				if(data.isUsable == true){
					$(".guide.error").hide();
					$("#btn-insert").attr('disabled', false);
				}
				else{
					$(".guide.error").show();
					$("#btn-insert").attr('disabled', true);
				}

			},
			error : function(xhr, status, err){
				 console.log("처리 실패", xhr, status, err);				
			}

		});
		
	});
	
});

function deleteKey(keyCode, keyword){
	
	if(!confirm('[' + keyword + '] 을/를 정말 삭제할까요?')) return;

	$.ajax({
		url : "${pageContext.request.contextPath}/member/deleteKeyword",
		method : "POST",
		data : {
			key : keyCode
		},
		dataType : "json",
		beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(data){
				alert("키워드 [" + keyword + "] 을/를 삭제했어요 💗");

				//요소 삭제
				let $key = "#keyCode" + data.key;
				$($key).remove();

				//총 키워드 개수 처리
				$("#totalKeywordContents").html(${totalKeywordContents} - 1);
		},
		error : function(xhr, status, err){
			 console.log("처리 실패", xhr, status, err);
			 alert("키워드 삭제에 실패했어요 다시 시도해주세요 💦");
		}

	});
	
}

$("#btn-insert").click(function(){

	var $userId = $("[name=userId]");
	var $keyword = $("[name=keyword]");

	$.ajax({
		url : "${pageContext.request.contextPath}/member/insertKeyword",
		method : "POST",
		data : {
			userId : $userId.val(),
			keyword : $keyword.val()
		},
		dataType : "json",
		beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(data){
				alert("키워드를 추가했어요 💗");

				//ajax 새로고침으로 변경
				location.href = "${pageContext.request.contextPath}/member/keywordNoti?userId=" + $userId.val();
				
		},
		error : function(xhr, status, err){
			 console.log("처리 실패", xhr, status, err);
			 alert("키워드 추가에 실패했어요 다시 시도해주세요 💦");
		}

	});
	
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
