<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항" name="pageTitle"/>
</jsp:include>

<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/mypage.css">
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
	                    <div class="profile mr-3"><img src="https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80" alt="..." width="130" class="rounded mb-2 img-thumbnail">
	                    	<a href="${pageContext.request.contextPath }/member/mypage" class="btn btn-outline-dark btn-sm btn-block">Mypage</a>
	                    </div>
	                    <div class="media-body mb-5 text-white">
	                        <h4 class="mt-0 mb-0" style="color:white;">Mark Williams</h4>
	                        <p class="small mb-4" style="color:white;"> <i class="fas fa-map-marker-alt mr-2"></i>New York</p>
	                    </div>
	                </div>
	            </div>
	            <div class="bg-light p-4 d-flex justify-content-end text-center">
	                <ul class="list-inline mb-0">
	                    <li class="list-inline-item">            
	                       <h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/salesList">
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
	                    <li class="list-inline-item">
	                    	<h6 class="font-weight-bold mb-0 d-block">	                       	
	                       	<a href="${pageContext.request.contextPath }/member/wishList">
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
									  		color: #575757;">관심 주제 목록</h5> 		
							     <p style="color: #575757;">관심 주제를 추가해보세요</p>
							</div>
							<hr />			
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
	                    <div class="media">
					  <img id="interList"class="mr-3" src="/udon/resources/img/icon/restaurant.png" alt="Generic placeholder image">
					  <div class="media-body">
					    <h5 class="mt-2">동네 맛집</h5>
					  </div>
					  <div>
					  	<button type="button" class="btn btn-info">add</button>
					  </div>
					</div><br />
					<div class="media">
					  <img id="interList"class="mr-3" src="/udon/resources/img/icon/cafe.png" alt="Generic placeholder image">
					  <div class="media-body">
					    <h5 class="mt-2">동네 카페</h5>
					  </div>
					  <div>
					  	<button type="button" class="btn btn-info">add</button>
					  </div>
					</div><br />
					<div class="media">
					  <img id="interList"class="mr-3" src="/udon/resources/img/icon/house.png" alt="Generic placeholder image">
					  <div class="media-body">
					    <h5 class="mt-2">집꾸미기</h5>
					  </div>
					  <div>
					  	<button type="button" class="btn btn-info">add</button>
					  </div>
					</div><br />
					<div class="media">
					  <img id="interList"class="mr-3" src="/udon/resources/img/icon/cat.png" alt="Generic placeholder image">
					  <div class="media-body">
					    <h5 class="mt-2">고양이</h5>
					  </div>
					  <div>
					  	<button type="button" class="btn btn-info">add</button>
					  </div>
					</div><br />
					<div class="media">
					  <img id="interList"class="mr-3" src="/udon/resources/img/icon/dog.png" alt="Generic placeholder image">
					  <div class="media-body">
					    <h5 class="mt-2">강아지</h5>
					  </div>
					  <div>
					  	<button type="button" class="btn btn-info">add</button>
					  </div>
					</div>
					
						  	
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
