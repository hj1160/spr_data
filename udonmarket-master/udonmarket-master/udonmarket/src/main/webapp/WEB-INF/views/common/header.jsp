<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>${ param.pageTitle }</title>
    <link rel="icon" href="${pageContext.request.contextPath }/resources/img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/lightslider.min.css">
    <!-- nice select CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/nice-select.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/all.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/themify-icons.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/magnific-popup.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/slick.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/price_rangs.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
	<!-- jquery -->
	<script src="http://code.jquery.com/jquery-latest.min.js" ></script>
	<!-- notification css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/notification.css">
    <script src="${pageContext.request.contextPath }/resources/js/notification.js"></script>
	<!-- sockJS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
	<!-- filepond -->
	<link href="https://unpkg.com/filepond/dist/filepond.css" rel="stylesheet">
<script>
<%-- RedirectAttribute??? ????????? msg??? ?????? ?????? ?????? ??? ?????? --%>
<c:if test="${ not empty msg }">
 	alert('${ msg }');
</c:if>
</script>
</head>

<body>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="userId"/>
</sec:authorize>
    <!--::header part start::-->
    <header class="main_menu home_menu">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <a class="navbar-brand" href="${pageContext.request.contextPath }" style="width: 20%;"> 
                        	<img src="${pageContext.request.contextPath }/resources/img/udon (1).png" alt="logo" style="width: 30%; margin-top: 8%;"> 
                       	</a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="menu_icon"><i class="fas fa-bars"></i></span>
                        </button>

                        <div class="collapse navbar-collapse main-menu-item" id="navbarSupportedContent">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath }">HOME</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath }/product/productListView?userId=${userId}&currentPage=1">????????????</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="${pageContext.request.contextPath }/community/communityListView?userId=${userId}&currentPage=1" id="navbarDropdown_1"
                                        role="button" aria-haspopup="true" aria-expanded="false">????????????
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdown_1">
                                        <a class="dropdown-item" href="/udon/community/communityListView?userId=${userId}&categoryCode=17&currentPage=1">?????????????????????</a>
                                        <a class="dropdown-item" href="/udon/community/communityListView?userId=${userId}&categoryCode=18&currentPage=1">??????????????????</a>
										<a class="dropdown-item" href="/udon/community/communityListView?userId=${userId}&categoryCode=19&currentPage=1">??????/????????????</a>
										<a class="dropdown-item" href="/udon/community/communityListView?userId=${userId}&categoryCode=20&currentPage=1">??????????????????</a>
                                    </div>
                                </li>
								<!--??????????????? -->
								<sec:authorize access="hasRole('ADMIN')">
                               	<li class="nav-item">
                               		<a class="nav-link" href="${pageContext.request.contextPath }/admin/memberList">????????????</a>
                               	</li>
                               	</sec:authorize>
                            </ul>
                        </div>
                        <div class="hearer_icon d-flex">
                            <a id="search_1" href="javascript:void(0)"><i class="ti-search"></i></a>
                           	<!-- notiList -->
                            <a href="#" id="bell" onclick="showNoti();"><i class="ti-bell"></i></a>
                           	<!-- notiList -->
                           	
                           	<!-- chatList ???????????? ??????-->
                           	<sec:authorize access="isAuthenticated()">
                            <a href="#" 
                               onclick="window.open('${pageContext.request.contextPath }/chat/chatListView?userId=${userId}', 'chatting', 'width=1000px, height=800px')">
                            	<i class="ti-comments-smiley"></i>
                            </a>
                            </sec:authorize>
                           	<!-- chatList -->
                            
                            <sec:authorize access="isAnonymous()">
	                        	<a href="${pageContext.request.contextPath }/member/loginForm"><i class="ti-power-off"></i></a>
	                        </sec:authorize>
	                        
	                        <sec:authorize access="isAuthenticated()">
                            <a href="${pageContext.request.contextPath }/member/mypage?userId=${userId}"><i class="ti-user"></i></a>
                       
                            <form:form method="POST" action="${pageContext.request.contextPath }/member/logout">
<!--                             	<button type="submit" style="background: none; border: none; margin-left: 1.8em; padding: 0px;"><i class="ti-power-off"></i></button> -->
                            	<button type="submit" style="background: none; border: none; margin-left: 1.8em; padding: 0px;"><i class="fas fa-sign-in-alt"></i></button>
                            </form:form> 
	                        </sec:authorize>
							
                        </div>
                        
                        <!-- ?????? --> 
                        <sec:authorize access="isAnonymous()">
                        <div class="notifications" id="box">
					        <h2> ???? ????????? ?????????</h2>
					        <div class="notifications-item">
					            <div class="text">
					                <h4><a href="${pageContext.request.contextPath }/member/loginForm">?????????</a>??? ???????????? ???? </h4>
					            </div>
					        </div>
					    </div>
                        </sec:authorize>
                        
                        <sec:authorize access="isAuthenticated()">
                        <div class="notifications" id="box">
					        <h2> ???? ????????? ????????? - <span id="totalNoti"></span></h2>
					        <div id="noti_" style="display: block;">
					        
					        </div>
					    </div>
                        </sec:authorize>
                        <!-- ?????? --> 

                    </nav>
                </div>
            </div>
        </div>
        <div class="search_input" id="search_input_box">
            <div class="container ">
<%--                  <form class="d-flex justify-content-between search-inner"> --%>
					<div class = "d-flex justify-content-between search-inner">
                   <input type="text" class="form-control" id="search_input" placeholder="Search Here" onkeyup="javascript:if (event.keyCode == 13) search(this.value);">
<!--                     <button type="submit" class="btn"></button> -->
                    <span class="ti-close" id="close_search" title="Close Search"></span>
<%--                   </form> --%>
					</div>
            </div>
        </div>
        
        <div id="socketAlert" class="alert alert-primary" role="alert" style="display: none"></div>
        
    </header>

<script>
//?????? ????????? ?????????
function showNoti(){
	var $userId = "${userId}";

 	$.ajax({
		url : "${pageContext.request.contextPath}/member/showNoti",
		method : "POST",
		dataType : "json",
		data : {
				userId : $userId,
		},
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        }, 
		success : function(data){	
			let noti = data.noti;

			if(noti != ""){
				let add = "";
				let notiCount = 0;
				
				//console.log(noti.length);
				for(let i = 0; i<noti.length; i++){
					//?????? ?????? ?????????
					if(noti[i].notiCheck == 0){
						notiCount ++;
						let kind = "";
						switch (noti[i].notiKind){
							case "reply": kind = "??????"; break;
							case "price": kind = "?????? ??????"; break;
							case "keyword": kind = "?????????"; break;
							case "like": kind = "?????????"; break;
							case "nego": kind = "?????? ??????"; break;
					    }

						if(noti[i].notiKind == "reply" || noti[i].notiKind == "like"){

							add += "<div class='notifications-item'>" + 
							   "<div class='text'>" + 
							   		"<h4>[" + kind +"] " + 
							   			"<a href='${pageContext.request.contextPath }/community/communityDetailView?userId=" + $userId + "&bCode= " + noti[i].pcode + "' " + 
							   				"onclick='updateCheck(" + noti[i].notiCode +")'>" +
							   			 	noti[i].ptitle + "</a>" +
							   		"</h4>" + 
							   "</div>" + 
							   "</div>";
							   
						}else if(noti[i].notiKind == "price" || noti[i].notiKind == "nego" || noti[i].notiKind == "keyword"){

							add += "<div class='notifications-item'>" + 
								   "<div class='text'>" + 
								   		"<h4>[" + kind +"] " + 
								   			"<a href='${pageContext.request.contextPath }/product/productDetailView?pCode= " + noti[i].pcode + "' " + 
								   				"onclick='updateCheck(" + noti[i].notiCode +")'>" +
								   			 	noti[i].ptitle + "</a>" +
								   		"</h4>" + 
								   "</div>" + 
								   "</div>";
							}
						
					}
				}
					$("#noti_").html(add);
					$("#totalNoti").text(notiCount);

			}else{
				
				$("#noti_").html("<div class='text'><h4>????????? ????????? ?????????</div>");
				$("#totalNoti").text(0);
			}
			
		},
		error : function(xhr, status, err){
			console.log("?????? ??????", xhr, status, err);
			alert("?????? ??????????????? ??????????????? ?????? ?????????????????? ????");
		}
	}); 
}

//????????????
function updateCheck(notiCode){

	$.ajax({
		url : "${pageContext.request.contextPath}/member/updateCheck",
		method : "POST",
		data : {
				notiCode : notiCode,
		},
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(data){
			console.log("?????? ??????!");
		},
		error : function(xhr, status, err){
			console.log("?????? ??????", xhr, status, err);
			alert("??????????????? ?????? ?????????????????? ????");
		}
		
	});
	
}

function search(keyword) 
{
	location.href 
		= "${pageContext.request.contextPath}/product/search?keyword=" + keyword + "&category=0&userId=${userId}&currentPage=1";
}
</script>
