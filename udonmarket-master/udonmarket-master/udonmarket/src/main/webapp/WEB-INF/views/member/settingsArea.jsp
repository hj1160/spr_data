<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>

<!-- kakao map api&library -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a40619c082a3c1c995f8bec611d38389&libraries=services,clusterer,drawing"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이페이지" name="pageTitle"/>
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
.box-radio-input input[type="radio"]{
    display:none;
}

.box-radio-input input[type="radio"] + span{
    display:inline-block;
    background:none;
    border:1px solid #dfdfdf;    
    padding:0px 10px;
    text-align:center;
    height:35px;
    line-height:33px;
    font-weight:500;
    cursor:pointer;
}

.box-radio-input input[type="radio"]:checked + span{
    border:1px solid #23a3a7;
    background:#23a3a7;
    color:#fff;
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
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
						<div>
						<hr />
							<div style="text-align: center; ">
								<h5 style="font-weight: bold;
									  		color: #575757;">내 동네 설정하기</h5> 		
							    <p id="myLocal" style=" color: #575757;"></p>
							</div>
							<hr />							  
							<!-- 동네 설정하기 -->
							<div style="text-align: center;">
							    <!-- 지도 -->								
								<div id="map" style="width:100%; 
													 height:350px;
													 margin:15px 0;">
								</div>								
								<!-- 위치 바꾸기 (현재 위치로) -->
								<sec:authentication property="principal.username" var="loggedInUserId" />
								<input type="hidden" name="userId" value="${loggedInUserId }"/>
								<input type="hidden" name="addr"/>
								<input type="hidden" name="lat"/>
								<input type="hidden" name="lon"/>																
								<input type="button" 
									   id="btn-changeAddr"
									   class="btn btn-outline-primary btn-sm" 
									   value="현재 위치로 동네 설정하기" />																
							</div>
							<hr />
							<!-- 지역범위 설정하기 -->						
							<div style="text-align: center;">
								 <h5 style="font-weight: bold;
									  		color: #575757;">지역 범위 설정하기</h5>
								 <p style="color: #575757;">선택한 범위의 게시글만 볼 수 있어요.</p>
							</div>
							<hr />
							<div style="text-align: center;">							
								<label class="box-radio-input">
									<input type="radio" name="cp_item" value="3" ${radius eq '3' ? 'checked' : '' }>
									<span>우리 동네 </span>
								</label>
								<label class="box-radio-input">
									<input type="radio" name="cp_item" value="5" ${radius eq '5' ? 'checked' : '' }>
									<span>이웃 동네</span>
								</label>
								<label class="box-radio-input">
									<input type="radio" name="cp_item" value="7" ${radius eq '7' ? 'checked' : '' }>
									<span>근처 동네</span>
								</label>
							</div>
						</div>
				        </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

<script>

//지도 관련
$(function(){

	//사용자 설정 값 가져와서 넣기
	local(${radius});
//	console.log(${radius});

	//지역 범위 설정 지도에 보여주기
	$("[name=cp_item]").change(function(){
		var $level = $("[name=cp_item]:checked").val();
//		console.log("$level : " + $level);
		local($level);

		//범위 설정 update 하기
		$.ajax({
			url : "${pageContext.request.contextPath}/member/updateRadius",
			method : "POST",
			data : {
				userId : $("[name=userId]").val(),
				radius : $level
			}, 
			dataType : "json",
			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                   xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
               },
			success : function(data){
				let local = "근처 동네";			
				if(data.radius == 3) local = "우리 동네";
				if(data.radius == 5) local = "이웃 동네";

				alert("지역 범위를 [" + local +  "]로 설정했어요 💗");				
			},
			error : function(xhr, status, err){
				console.log("처리 실패", xhr, status, err);
				alert("지역범위 재설정에 실패했어요 다시 시도해주세요 💦");
			}
		});
		
	});	

	function local(level){
		//지도를 표시할 div 
		var mapContainer = document.getElementById('map');
	 	
		var	mapOption = { 
			    center: new kakao.maps.LatLng(37.4969519, 127.0261588), // 지도의 중심좌표
			    level: level // 지도의 확대 레벨 
			}; 
		
		// 지도 생성
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체 생성
		var geocoder = new kakao.maps.services.Geocoder();
		
		//HTML5의 geolocation으로 사용할 수 있는지 확인
		if (navigator.geolocation) {
		
			// GeoLocation을 이용해서 위도경도 얻어오기
			navigator.geolocation.getCurrentPosition(function(position) {
			    
			    var lat = position.coords.latitude; // 위도
			    var lon = position.coords.longitude; // 경도	

			    //위도 경도로 주소 가져오기
				var address;
			    geocoder.coord2RegionCode(lon, lat, function(result, status){
				    
			    	if (status === kakao.maps.services.Status.OK) {
			        	address = result[0].address_name;
			       	}
			    $("[name=addr]").val(address);
			    $("[name=lat]").val(lat);
			    $("[name=lon]").val(lon);
			       	
				var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				var message = '<div style="padding:5px; font-size: 12px;"> 현재 위치 : '+ address +' </div>'; // 인포윈도우에 표시될 내용입니다

				//현재위치 알려주기
				var myLocal = document.getElementById("myLocal");

				var dong = address.split(" ");
					dong = dong[dong.length-1];
				myLocal.innerHTML = "현재 위치가 <strong>[" + dong +"]</strong> 입니다.";
			    
			    // 마커와 인포윈도우를 표시
			    displayMarker(locPosition, message);		    
			    });		    
			});
		
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용 설정
		
			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
			    message = 'geolocation을 사용할수 없습니다';
			    
			displayMarker(locPosition, message);
		}
		
		//지도에 마커와 인포윈도우를 표시하는 함수
		function displayMarker(locPosition, message) {
			
			//마커 생성
			var marker = new kakao.maps.Marker({  
			    map: map, 
			    position: locPosition
			}); 
			
			var iwContent = message, // 인포윈도우에 표시할 내용
			    iwRemoveable = true;
			
			// 인포윈도우 생성
			var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent,
			    removable : iwRemoveable
			});
		
			// 인포윈도우를 마커위에 표시
			infowindow.open(map, marker);
			
			// 지도 중심좌표를 접속위치로 변경
			map.setCenter(locPosition);      
		}
	}
});	

//위치 변경 버튼 클릭
$(function(){
	$("#btn-changeAddr").click(function(){
		if(!confirm('현재 위치로 동네를 변경하시겠습니까?')) return;

		$.ajax({
			url : "${pageContext.request.contextPath}/member/updateAddress",
			method : "POST",
			data : {
				userId : $("[name=userId]").val(),
				addr : $("[name=addr]").val(),
				lat : $("[name=lat]").val(),
				lon : $("[name=lon]").val()
			},
			dataType : "json",
			beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                   xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
               },
			success : function(data){
				alert("현재 위치로 동네를 재설정했어요 💗");
				$("#addr").html(data.address);									
			},
			error : function(xhr, status, err){
				console.log("처리 실패", xhr, status, err);
				alert("동네 재설정에 실패했어요 다시 시도해주세요 💦");
			}

		});

	});
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	