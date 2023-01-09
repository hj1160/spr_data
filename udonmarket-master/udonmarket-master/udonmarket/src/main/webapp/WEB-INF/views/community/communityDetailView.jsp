<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시글 상세보기" name="pageTitle"/>
</jsp:include>

<sec:authentication property="principal.username" var="userId"/>


<style>
.breadcrumb_bg_02
{
	background-image: url(${pageContext.request.contextPath}/resources/img/breadcrumb_02.png);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>

<script>




$(function(){

	$("a[data-board-no]").click(function(){
		var bCode = $(this).attr("data-board-no");
		location.href = "${ pageContext.request.contextPath }/community/communityDetailView?userId=${userId}&bCode=" + bCode;
	});
	
});

// 사이드바 검색
$(document).on('click', '#btnSearch', function(e){

		e.preventDefault();

		var url = "${pageContext.request.contextPath}/community/communityListView?userId=${userId}&currentPage=1";

		url = url + "&searchType=" + $('#searchType').val();

		url = url + "&keyword=" + $('#keyword').val();

		location.href = url;

		console.log(url);

	});	


// $(".replyWriteBtn").on("click", function(){
//  var formObj = $("form[name='replyForm']");
//  formObj.attr("action", "/saveReply");
//  formObj.submit();
// });

// 댓글 등록
function fn_addtoBoard(){
    
    var form = document.getElementById("replyForm");
    
    form.action = "<c:url value='/community/saveReply'/>";
    form.submit();

    //댓글 등록 알림 관련
    let $bCode = $("#bCode").val();
    //alert($bCode);
    let $title = "${ community.boardTitle }";
    let $sender = $("#userId").val();
    let $bWriter = "${ community.userId }";
    
  	//소켓이 연결 되었을 때만 
	if(sock) {
		console.log("reply :: socket >> ", sock);
		//cmd/발신인/수신인/게시글번호/게시글제목/공란
		sock.send("reply," + $sender + "," + $bWriter + "," + $bCode + "," + $title + ", ");
	}else{
		console.log("Error on Reply ", sock);
	}
    //댓글 등록 알림 관련
    
}

// 게시글 삭제
function deleteBoard(bCode)
{
	if(confirm("삭제할까요?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/community/" + bCode,
			method: "PUT",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        dataType: "json",
	        async: false,
			success: function(map)
			{
				alert(map.msg);
				location.href = "${pageContext.request.contextPath}/community/communityListView?userId=${userId}&currentPage=1";									
			},
			error: function(xhr, status, err)
			{
				alert("게시글 삭제에 실패했어요 💧");
				console.log(xhr, status, err);
			}
		});
	}
	else
		return false;
}

// 좋아요
function likeThis(bCode)
{
	let $bCode = $("#bCode").val();
    let $title = "${ community.boardTitle }";
    let $sender = $("#userId").val();
    let $bWriter = "${ community.userId }";
    let $countLike = "${ community.likeThis }";
    
    
	if(confirm("이 게시글을 좋아하시겠습니까?"))
	{
		$.ajax
		({
			url: "${ pageContext.request.contextPath }/community/likeThis?bCode="+bCode+"&userId=${userId}",
			method: "PUT",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        dataType: "json",
			success: function()
			{
				//알림보내기
				if(sock) {
					console.log("like :: socket >> ", sock);
						//webSocket에 보내기
						//cmd/발신인/수신인/게시글코드/게시글제목/하트 갯수
					sock.send("like," + $sender + "," + $bWriter + "," + $bCode + "," + $title + "," + $countLike);
				}else{
					console.log("Error on Like ", sock);
				}
				
				location.href = "${ pageContext.request.contextPath }/community/communityDetailView?userId=${userId}&bCode=" + bCode;									
			},
			error: function(xhr, status, err)
			{
			//알림보내기
				if(sock) {
					console.log("like :: socket >> ", sock);
						//webSocket에 보내기
						//cmd/발신인/수신인/게시글코드/게시글제목/하트 갯수
					sock.send("like," + $sender + "," + $bWriter + "," + $bCode + "," + $title + "," + $countLike);
				}else{
					console.log("Error on Like ", sock);
				}
				location.href = "${ pageContext.request.contextPath }/community/communityDetailView?userId=${userId}&bCode=" + bCode;	
			}
		});
	}
	else
		return false;
}


// 게시글 신고하기
function reportList(reasonCode)
{
	var $board = $("#boardReport");
	
	$.ajax
	({
		url: "${pageContext.request.contextPath}/community/report/" + reasonCode,
        dataType: "json",
		success: function(list)
		{
			// 게시글 신고
			if(reasonCode != 2)
			{
			 	$("#boardReport").html("");
				var str = "";
		
				str += "<ul class='list'>";
		
				for(var i in list)
				{
					if(list[i].parentCode == reasonCode)
					{
						str += "<li>";
						
						if(list[i].leaf == 0)
						{
							str += "<a href='javascript:reportList(" + list[i].reasonCode + ")'>" + list[i].reasonContent + "</a>";
							str += "<span>></span>";
						}
						else
						{
							str += "<a href='javascript:reportBoard(" + list[i].reasonCode + ", ${community.BCode}, \"${userId}\")'>";
							str += list[i].reasonContent + "</a>";
						}
							
						str += "</li>";
					} 
				}
				
				str += "</ul>";
				$("#boardReport").html(str); 
			}
			// 사용자 신고
			else
			{
		 		$("#userReport").html("");
				var str = "";
		
				str += "<ul class='list'>";
		
				for(var i in list)
				{
					if(list[i].parentCode == reasonCode)
					{
						str += "<li>";
						
						if(list[i].leaf == 0)
						{
							str += "<a href='javascript:reportList(" + list[i].reasonCode + ")'>" + list[i].reasonContent + "</a>";
							str += "<span>></span>";
						}
						else
						{
							str += "<a href='javascript:reportUser(" + list[i].reasonCode + ", \"${community.userId}\", \"${userId}\")'>";
							str += list[i].reasonContent + "</a>";
						}
							
						str += "</li>";
					}
				}
				
				str += "</ul>";
				$("#userReport").html(str); 
		
			}
		},
		error: function(xhr, status, err)
		{
			console.log("목록 불러오기 실패");
		}
	});
}
// 게시글 신고
function reportBoard(reasonCode, bCode, userId)
{
	if(confirm("신고하시겠습니까?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/community/reportBoard",
			method: "POST",
			data:
			{
				reasonCode: reasonCode,
				bCode: bCode,
				reportId: userId
			},
	        dataType: "text",
	        beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function(result)
			{
				alert(result);
				$("#reportModal").modal('hide');
			},
			error: function(xhr, status, err)
			{
				alert("신고에 실패했습니다.");
				console.log(xhr, status, err);
				$("#reportModal").modal('hide');
			}
		});
	}
}
// 사용자 신고
function reportUser(reasonCode, suspectId, userId)
{
	if(confirm("신고하시겠습니까?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/community/reportUser",
			method: "POST",
			data:
			{
				reasonCode: reasonCode,
				shooterId: suspectId,
				reportId: userId
			},
	        dataType: "text",
	        beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function(result)
			{
				alert(result);
				$("#reportModal").modal('hide');
			},
			error: function(xhr, status, err)
			{
				alert("신고에 실패했습니다.");
				console.log(xhr, status, err);
				$("#reportModal").modal('hide');
			}
		});
	}
}


// 댓글 신고하기
function reportList2(reasonCode)
{
	var $reply = $("#replyReport");
	
	let $replyCode = $("#replyCodeH").val();
//	let $replyCode2 = $("#replyCodeHH").val();
	
	//alert($replyCode);
//	alert($replyCode2);
	
	$.ajax
	({
		url: "${pageContext.request.contextPath}/community/report2/" + reasonCode,
        dataType: "json",
		success: function(list)
		{
			// 댓글 신고
			if(reasonCode != 2)
			{
			 	$("#replyReport").html("");
				var str = "";
		
				str += "<ul class='list'>";
		
				for(var i in list)
				{
					if(list[i].parentCode == reasonCode)
					{
						str += "<li>";
						
						if(list[i].leaf == 0)
						{
							str += "<a href='javascript:reportList2(" + list[i].reasonCode + ")'>" + list[i].reasonContent + "</a>";
							str += "<span>></span>";
						}
						else
						{
							str += "<a href='javascript:reportReply(" + list[i].reasonCode + ", " +$replyCode +", \"${userId}\")'>";
							str += list[i].reasonContent + "</a>";
						}
							
						str += "</li>";
					} 
				}
				
				str += "</ul>";
				$("#replyReport").html(str); 
			}
			// 사용자 신고
			else
			{
		 		$("#userReport2").html("");
				var str = "";
		
				str += "<ul class='list'>";
		
				for(var i in list)
				{
					if(list[i].parentCode == reasonCode)
					{
						str += "<li>";
						
						if(list[i].leaf == 0)
						{
							str += "<a href='javascript:reportList2(" + list[i].reasonCode + ")'>" + list[i].reasonContent + "</a>";
							str += "<span>></span>";
						}
						else
						{
							str += "<a href='javascript:reportUser(" + list[i].reasonCode + ", \"${community.userId}\", \"${userId}\")'>";
							str += list[i].reasonContent + "</a>";
						}
							
						str += "</li>";
					}
				}
				
				str += "</ul>";
				$("#userReport2").html(str); 
		
			}
		},
		error: function(xhr, status, err)
		{
			console.log("목록 불러오기 실패");
		}
	});
}



// 댓글 신고
function reportReply(reasonCode, replyCode, userId)
{

	

	if(confirm("신고하시겠습니까?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/community/reportReply",
			method: "POST",
			data:
			{
				reasonCode: reasonCode,
				replyCode: replyCode,
				reportId: userId
			},
	        dataType: "text",
	        beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function(result)
			{
				alert(result);
				$("#reportModal2").modal('hide');
			},
			error: function(xhr, status, err)
			{
				alert("신고에 실패했습니다.");
				console.log(xhr, status, err);
				$("#reportModal2").modal('hide');
			}
		});
	}
}
// 사용자 신고
function reportUser(reasonCode, suspectId, userId)
{
	if(confirm("신고하시겠습니까?"))
	{
		$.ajax
		({
			url: "${pageContext.request.contextPath}/community/reportUser",
			method: "POST",
			data:
			{
				reasonCode: reasonCode,
				shooterId: suspectId,
				reportId: userId
			},
	        dataType: "text",
	        beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function(result)
			{
				alert(result);
				$("#reportModal2").modal('hide');
			},
			error: function(xhr, status, err)
			{
				alert("신고에 실패했습니다.");
				console.log(xhr, status, err);
				$("#reportModal2").modal('hide');
			}
		});
	}
}



</script>


    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
    <section class="breadcrumb breadcrumb_bg_02">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                        	<c:if test="${ community.boardTitle.length() < 15 }">
                            <h2 style="font-weight: bold;">${ community.boardTitle }</h2>
                        	</c:if>
                        	<c:if test="${ community.boardTitle.length() >= 15 && community.boardTitle.length() < 25 }">
                            <h3 style="font-weight: bold;">${ community.boardTitle }</h3>
                        	</c:if>
                        	<c:if test="${ community.boardTitle.length() >= 25 }">
                            <h4 style="font-weight: bold;">${ community.boardTitle }</h4>
                        	</c:if>
                            <c:if test="${ community.categoryCode == 17 }">
								<h3>동네생활이야기</h3>
							</c:if>
							<c:if test="${ community.categoryCode == 18 }">
								<h3>우리동네질문</h3>
							</c:if>
							<c:if test="${ community.categoryCode == 19 }">
								<h3>분실/실종센터</h3>
							</c:if>
							<c:if test="${ community.categoryCode == 20 }">
								<h3>동네사건사고</h3>
							</c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->
    
    
    
    
   <!--================Blog Area =================-->
   <section class="blog_area single-post-area padding_top">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 posts-list">
               <div class="single-post">
                  <div class="feature-img" style="background-color: #e6d2d1; width: 750px; height: 450px;">
                  <div id="vertical" style="text-align: center;">
                     <c:forEach items="${photos }" var="photo">
                     <%-- <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/blog/no_img.png" alt=""> --%>
<%-- 				<div class="img-fluid" style=" margin: 0 auto; text-align:center;" data-thumb="${pageContext.request.contextPath }/resources/upload/${photo.uploadPath}/${photo.uuid}_${photo.originalFilename}"> --%>
				<div data-thumb="${pageContext.request.contextPath }/resources/upload/${photo.uploadPath}/${photo.uuid}/${photo.originalFilename}">
				  <img style="width: 500px; height: 450px;" src="${pageContext.request.contextPath }/resources/upload/${photo.uploadPath}/${photo.uuid}/${photo.originalFilename}" />
				</div>
				</c:forEach>
				</div>
                  </div>
                  <div class="blog_details">
                  
                  
                  			<%-- <c:if test="${ community.categoryCode == 22 }">
								<a class="genric-btn success-border medium" style="border-color: red; font-weight: bold;">공지사항</a>
							</c:if> --%>
							<c:if test="${ community.categoryCode == 17 }">
								<a class="genric-btn success-border medium">동네생활이야기</a>
							</c:if>
							<c:if test="${ community.categoryCode == 18 }">
								<a class="genric-btn success-border medium">우리동네질문</a>
							</c:if>
							<c:if test="${ community.categoryCode == 19 }">
								<a class="genric-btn success-border medium">분실/실종센터</a>
							</c:if>
							<c:if test="${ community.categoryCode == 20 }">
								<a class="genric-btn success-border medium">동네사건사고</a>
							</c:if>
                   	 <br/><br/>
                     <h2>
                     	${ community.boardTitle }
                     </h2>
                     <h6><fmt:formatDate value="${ community.regDate }" pattern="yyyy.MM.dd"/>&nbsp;&nbsp;<fmt:formatDate value="${ community.regDate }" pattern="HH:mm"/></h6>
                     <br />
                     <p class="excert">
                        ${ community.boardContent }
                     </p>
                     <ul class="blog-info-link mt-3 mb-4">
                       			<c:if test="${ community.hashtagCode == 1 }">
                                    <li><i class="fa fa-hashtag"></i> 강아지 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 2 }">
                                    <li><i class="fa fa-hashtag"></i> 고양이 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 3 }">
                                    <li><i class="fa fa-hashtag"></i> 건강 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 4 }">
                                    <li><i class="fa fa-hashtag"></i> 동네맛집 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 5 }">
                                    <li><i class="fa fa-hashtag"></i> 동네카페 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 6 }">
                                    <li><i class="fa fa-hashtag"></i> 살림/청소/정리 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 7 }">
                                    <li><i class="fa fa-hashtag"></i> 식물 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 8 }">
                                    <li><i class="fa fa-hashtag"></i> 임신/출산/육아 </li>
                                </c:if>
                                <c:if test="${ community.hashtagCode == 9 }">
                                    <li><i class="fa fa-hashtag"></i> 집꾸미기 </li>
                                </c:if>
                     </ul>
                     
                     <c:if test="${ community.userId eq userId }">
                     <div style="float: right;">
	                     <a href="${pageContext.request.contextPath }/community/updateBoard?userId=${userId}&bCode=${community.BCode}<%-- &categoryCode=${community.categoryCode }&hashtagCode=${community.hashtagCode} --%>">수정</a>
	                     &nbsp;
	                     <a href="javascript:deleteBoard('${community.BCode }');">삭제</a>
	                     
                     </div>
                     </c:if>
                     <br /><br />
                     <a href="${pageContext.request.contextPath}/member/mypage?userId=${community.userId}">
                     <div class="blog-author" style="width: 100%; margin-top: 5px;">
                  		<div class="media align-items-center" >
	                     <img src="${pageContext.request.contextPath }/resources/img/member/${community.renamedFilename == null ? community.originalFilename:community.renamedFilename}">
	                     <div class="media-body">
	                        
	                           <h4>${ community.nickname }</h4>
	                        
	                        <p>${ community.address }</p>
	                     </div>
	                  </div>
               		</div>
               </a>
                  
                  </div>
               </div>
               <div class="navigation-top">
                  <div class="d-sm-flex justify-content-between text-center">
                     <%-- <p class="like-info"><span class="align-middle"><a href="${pageContext.request.contextPath }/community/likeThis?bCode=${community.BCode}&userId=${userId}" id="like_update"><i class="far fa-heart"></i></a></span> ${ community.likeThis }명의 이웃이 이 게시글을 좋아합니다. </p> --%>
                     <%-- <p class="like-info"><span class="align-middle"><a data-like="${ community.BCode }"><i class="far fa-heart"></i></a></span> ${ community.likeThis }명의 이웃이 이 게시글을 좋아합니다. </p> --%>
                      <p class="like-info"><span class="align-middle"><a href="javascript:likeThis('${community.BCode }');"><i class="far fa-heart"></i></a></span> ${ community.likeThis }명의 이웃이 이 게시글을 좋아합니다. </p>
                     <div class="col-sm-4 text-center my-2 my-sm-0">
                        <!-- <p class="comment-count"><span class="align-middle"><i class="far fa-comment"></i></span> 06 Comments</p> -->
                     </div>
                     <c:if test="${ community.userId ne userId }">
                     <a class="genric-btn primary-border small" href="javascript:void(0);" data-toggle="modal" data-target="#reportModal">신고하기</a>
                     </c:if>
                  </div>
                  
                  <!-- 이전 다음 게시글 -->
                 <%--  <div class="navigation-area">
                     <div class="row">
                        <div
                           class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
                           <div class="thumb">
                              <a href="#">
                                 <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/post/preview.png" alt="">
                              </a>
                           </div>
                           <div class="arrow">
                              <a href="#">
                                 <span class="lnr text-white ti-arrow-left"></span>
                              </a>
                           </div>
                           
                           <div class="detials">
                              <p>이전 게시글</p>
                              <a href="#">
                                 <h4>ㅎㅎ</h4>
                              </a>
                           </div>
                        </div>
                        <div
                           class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
                           <div class="detials">
                              <p>다음 게시글</p>
                              <a href="#">
                                 <h4>ㅋㅋ</h4>
                              </a>
                           </div>
                           <div class="arrow">
                              <a href="#">
                                 <span class="lnr text-white ti-arrow-right"></span>
                              </a>
                           </div>
                           <div class="thumb">
                              <a href="#">
                                 <img class="img-fluid" src="${pageContext.request.contextPath}/resources/img/post/next.png" alt="">
                              </a>
                           </div>
                        </div>
                     </div>
                  </div> --%>
                  
                  
               </div>
               
               <!-- 댓글 -->
               <%-- <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">

				<form:form name="form" id="form" role="form" modelAttribute="reply" method="post">

				<form:hidden path="bCode" id="bCode"/>

				<div class="row">

					<div class="col-sm-10">

						<form:textarea path="content" id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></form:textarea>

					</div>

					<div class="col-sm-2">

						<form:input path="userId" class="form-control" id="userId" value="test"></form:input>

						<button type="button" class="btn btn-sm btn-primary" id="btnReplySave" style="width: 100%; margin-top: 10px"> 저 장 </button>

					</div>

				</div>

				</form:form>

			</div>

			

			

			

			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">

				<h6 class="border-bottom pb-2 mb-0">댓글</h6>

				<div id="replyList"></div>

			</div>  --%>

	<div class="comments-area">
	
				<c:if test="${ community.replyCount != 0}">
                  <h4>댓글 <span style="color: red">${ community.replyCount }</span></h4>
                  </c:if>
                  
                  <c:if test="${ community.replyCount == 0}">
                  <h4 style="color: gray; text-align: center;">아직 등록된 댓글이 없습니다</h4>
                  <!-- <h5>이웃에게 관심을 표현해주세요</h5> -->
                  </c:if>
                  
				<c:forEach items="${replyList}" var="r">
                  <div class="comment-list">
                     <div class="single-comment justify-content-between d-flex">
                        <div class="user justify-content-between d-flex">
                           <div class="thumb"> 
                              <a href="${pageContext.request.contextPath }/member/mypage?userId=${r.userId}"><img style="width: 60px; height: 60px;" src="${pageContext.request.contextPath }/resources/img/member/${r.renamedFilename == null ? r.originalFilename:r.renamedFilename}" alt=""></a>
                           </div>
                           <div class="desc">
                              <p class="comment">
                                	${r.content}
                              </p>
                              <div class="d-flex justify-content-between">
                                 <div class="d-flex align-items-center">
                                    <h5>
                                       <a href="#">${r.nickname}</a>
                                    </h5>
                                    <p class="date"> <fmt:formatDate value="${r.regDate}" pattern="yyyy-MM-dd" />&nbsp;&nbsp; <fmt:formatDate value="${r.regDate}" pattern="HH:mm" /> </p>
                                      &nbsp;&nbsp; &nbsp;&nbsp;
                                      
                                      <c:if test="${ r.userId eq userId }">
	                                      <!-- <a href="#">수정</a>&nbsp; -->
	                                      <!-- <p>·</p>&nbsp; -->
	                                      <a href="${pageContext.request.contextPath }/community/deleteReply?replyCode=${r.replyCode}&bCode=${community.BCode}&userId=${userId}">삭제</a>&nbsp;

                                      
                                      </c:if>
                                      <c:if test="${ r.userId ne userId }">
                                    	<a href="javascript:void(0);" data-toggle="modal" data-target="#reportModal2">신고하기 <input type="hidden" id="replyCodeH" name="replyCodeH" value="${r.replyCode}" /></a>
                                      </c:if>
                                      
                                 </div>
                                 
                              </div>
                           </div>
                        </div>
                        </div>
                     </div>
					</c:forEach>   
                  </div>
                  <div class="comment-form">
                  <form class="form-contact comment_form" id="replyForm" name="replyForm" method="post">
                     <div class="row">
                        <div class="col-12">
                           <div class="form-group">
                           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                           <input type="hidden" id="bCode" name="bCode" value="${community.BCode}" />
                           <input type="hidden" id="userId" name="userId" value="${userId}" />
                              <textarea class="form-control w-100" name="content" id="content" cols="30" rows="5"
                                 placeholder="댓글 작성 시 타인에 대한 배려와 책임을 담아주세요."></textarea>
                           </div>
                        </div>
                     </div>
                     <div class="form-group mt-3">
                        <button onClick='fn_addtoBoard()' class="genric-btn primary radius" style="text-align: center; font-weight: bold;">등록</button>
                     </div>
                  </form>
               </div>

               
               
            </div>
            <div class="col-lg-4">
                    <div class="blog_right_sidebar">
                    		<a href="${ pageContext.request.contextPath }/community/communityForm">
                    		<form>
                                <button 
                                	class="genric-btn primary radius" style="width:100%"
                                    type="button">게시글 작성하기</button>
                            </form>
                            </a>
                            <br /> 	
                        <aside class="single_sidebar_widget search_widget">
                        	
                        
                            <div class="form-group">
                                    <div class="input-group mb-3">
                                    <select class="form-control form-control-sm" name="searchType" id="searchType">

										<option value="board_title">제목</option>
					
										<option value="board_content">본문</option>
										
									</select>
                                        <input type="text" class="form-control" placeholder='키워드 검색'
                                            id="keyword"
                                            name="keyword">
                                        <div class="input-group-append">
                                            <button class="btn" type="button" name="btnSearch" id="btnSearch"><i class="ti-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                                
                        </aside>

                        <aside class="single_sidebar_widget post_category_widget">
                            <h4 class="widget_title">카테고리</h4>
                            <ul class="list cat-list">
                                
                                <!-- <li>
                                    <a href="communityListView?categoryCode=22" class="d-flex">
                                        <p>공지사항</p>
                                    </a>
                                </li> -->
                                <li>
                                    <a href="communityListView?userId=${userId }&categoryCode=17&currentPage=1" class="d-flex">
                                        <p>동네생활이야기</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&categoryCode=18&currentPage=1" class="d-flex">
                                        <p>우리동네질문</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&categoryCode=19&currentPage=1" class="d-flex">
                                        <p>분실/실종센터</p>
                                    </a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&categoryCode=20&currentPage=1" class="d-flex">
                                        <p>동네사건사고</p>
                                    </a>
                                </li>
                            </ul>
                        </aside>

                        <aside class="single_sidebar_widget popular_post_widget">
                            <h3 class="widget_title">최근 게시글</h3>
                           
                           	<c:forEach var="c" items="${ list }"  begin="0" end="3" step="1">
                           		<c:if test="${ c.categoryCode == 17 || c.categoryCode == 18 || c.categoryCode == 19 || c.categoryCode == 20}">
								<div class="media post_item">
									<a data-board-no="${ c.BCode }">
									<%-- <img src="${pageContext.request.contextPath}/resources/img/blog/no_img.png" alt="post" style="width: 42px; height: 42px"> --%>
									<c:if test="${ c.uuid == null }">
                        		 <img class="card-img rounded-0" style="height: 42px; width: 42px;" src="${pageContext.request.contextPath}/resources/img/blog/no_img.png" alt="">
								</c:if>
								<c:if test="${ c.uuid != null }">
                                <img style="height: 42px; width: 42px;" class="card-img rounded-0" src="${pageContext.request.contextPath }/resources/upload/${c.uploadPath}/${c.uuid}/${c.originalFilename}" alt="">
								</c:if>
									<div class="media-body">
										<h3 style="font-weight: bold;">${c.boardTitle}</h3>
									<p><fmt:formatDate value="${ c.regDate }" type="both"/></p>
									</a>
									</div>
								</div>
								</c:if>
							</c:forEach>
                           	
                           
                        </aside>
                        <aside class="single_sidebar_widget tag_cloud_widget">
                            <h4 class="widget_title">태그</h4>
                            <ul class="list">
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=1&currentPage=1">강아지</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=2&currentPage=1">고양이</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=3&currentPage=1">건강</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=4&currentPage=1">동네맛집</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=5&currentPage=1">동네카페</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=6&currentPage=1">살림/청소/정리</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=7&currentPage=1">식물</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=8&currentPage=1">임신/출산/육아</a>
                                </li>
                                <li>
                                    <a href="communityListView?userId=${userId }&hashtagCode=9&currentPage=1">집꾸미기</a>
                                </li>
                            </ul>
                        </aside>

                    </div>
                </div>
         </div>
      </div>
   </section>
   <!--================Blog Area end =================-->
   
   <!-- ========== REPORT MODAL START ========== -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><strong>게시글 신고</strong></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	   <div class="row text-center align-items-end">
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white rounded-lg">
				<div class="p-4 text-left">
					<span><strong>'${community.boardTitle }'</strong></span><br/>
					<span><strong>게시글을 신고하는 이유를 선택해주세요.</strong></span>
					<hr/>
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="widgets_inner pb-0" id="boardReport">
                                <ul class="list">
                   					<c:forEach items="${reasonReport }" var="r">
                                    <li>
                                        <a href="javascript:reportList(${r.reasonCode })">${r.reasonContent }</a>
                                        <span>></span>
                                    </li>
                                    </c:forEach>
                                </ul>
							</div>
						</aside>
					</div>
					<hr/><br/>
					<span><strong>혹시 '${community.nickname }'님을 신고하고 싶으신가요?</strong></span>
					<hr/>
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="widgets_inner pb-0" id="userReport">
                                <ul class="list">
                                    <li>
                                        <a href="javascript:reportList(2)">사용자 신고하러 가기</a>
                                        <span>></span>
                                    </li>
                                </ul>
							</div>
						</aside>
					</div>
					<hr/>
				</div>
	        </div>
	      </div>
      	</div>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- ========== REPORT MODAL END ========== -->

  <!-- ========== REPORT MODAL START ========== -->
<div class="modal fade" id="reportModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><strong>댓글 신고</strong></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	   <div class="row text-center align-items-end">
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white rounded-lg">
				<div class="p-4 text-left">
					<span><strong></strong></span><br/>
					<span><strong>해당 댓글을 신고하는 이유를 선택해주세요.</strong></span>
					<hr/>
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="widgets_inner pb-0" id="replyReport">
                                <ul class="list">
                   					<c:forEach items="${reasonReport2 }" var="r">
                                    <li>
                                        <a href="javascript:reportList2(${r.reasonCode })">${r.reasonContent }</a>
                                        <span>></span>
                                    </li>
                                    </c:forEach>
                                </ul>
							</div>
						</aside>
					</div>
					<hr/><br/>
					<span><strong>혹시 '${community.nickname }'님을 신고하고 싶으신가요?</strong></span>
					<hr/>
					<div class="left_sidebar_area">
						<aside class="left_widgets p_filter_widgets">
							<div class="widgets_inner pb-0" id="userReport2">
                                <ul class="list">
                                    <li>
                                        <a href="javascript:reportList2(2)">사용자 신고하러 가기</a>
                                        <span>></span>
                                    </li>
                                </ul>
							</div>
						</aside>
					</div>
					<hr/>
				</div>
	        </div>
	      </div>
      	</div>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- ========== REPORT MODAL END ========== -->





<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	
