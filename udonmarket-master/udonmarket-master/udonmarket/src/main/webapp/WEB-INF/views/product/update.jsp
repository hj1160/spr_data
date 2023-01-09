<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/upload.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/modal.css">
<!-- filepond -->
<link href="https://unpkg.com/filepond/dist/filepond.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/filepond-plugin-image-preview.css" rel="stylesheet">

<style>
body
{
	background: #fff;
}
.breadcrumb_bg_01
{
	background-image: url(${pageContext.request.contextPath}/resources/img/breadcrumb_01.png);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>

<!-- 알림 관련 스크립트 -->
<script>

$(function(){

	//수신자가 여러명일 수 있음
	var userIdList = "${userId}";
	var userIdArr = userIdList != null ? userIdList.split(" ") : null;
	
 	$("#uploadBtn").click(function(){
		let $pCode = $("[name=pCode]").val();
		let $title = $("[name=title]").val();
		let $price = $("[name=price]").val();
		let $seller = $("[name=seller]").val();

		//가격이 변동 되었을 때만
		if("${product.price }" != $price){

			//소켓이 연결 되었을 때만 (있을 때만)
			if(sock) {
				console.log("price :: socket >> ", sock);
				if(userIdArr != null){
					//webSocket에 보내기
					//cmd/발신인/수신인/상품코드/상품제목/가격
					for(let i=0; i<userIdArr.length-1; i++)
					sock.send("price," + $seller + "," + userIdArr[i] + "," + $pCode + "," + $title + "," + $price);
				}
								
			}else{
				console.log("Error on Price ", sock);
			}
		}

	}); 
});

</script>


    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
    <section class="breadcrumb breadcrumb_bg_01">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>상품 수정</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb end-->
    
    <!--================ Register Area =================-->
    <section class="login_part">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 col-md-6">
                    <div class="login_part_text text-center" style="background-image:none; width:88%; padding: 0;">
                        <div class="login_part_text_iner">
                        	<!-- filepond에서 사용히는 file -->
							<input type="file" class="my-pond" />
							<p style="color: red;">* 사진은 4개까지 업로드할 수 있어요  *</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
		           	<form method="post" name="frm">
	                    <div class="login_part_form" style="padding: 70px 0;">
	                        <div class="login_part_form_iner">
                        	    <!-- 첨부파일의 갯수는 최대 4개로 하고 각 파일ID를 저장하기 위해 만든다. -->
						        <input type="hidden" name="uploadFile"/>
						        <input type="hidden" name="uploadFile"/>
						        <input type="hidden" name="uploadFile"/>
						        <input type="hidden" name="uploadFile"/>
	                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        	<input type="hidden" name="pCode" value="${product.PCode }" />
	                        	<input type="hidden" name="seller" id="seller" value="${product.seller }"/>
	                               <div class="col-md-12 form-group p_star" style="margin-top: 10%;">
	                                   <input type="text" name="title" placeholder="글 제목" value="${product.title }"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '글 제목'" required
											class="single-input-primary"
											style="background: #f9f9ff;">
	                               </div>
	                               <div class="col-md-12 form-group p_star">
	                               	<button data-toggle="modal" data-target="#categoryModal" class="btn btn-primary genric-btn default-border" 
	                               			id="category" data-code="" type="button" style="width: 100%; color: #007bff;">카테고리 선택 &nbsp;&nbsp;&nbsp;&nbsp; ></button>
	                             		<input type="hidden" name="category" value=""/>
	                               </div>
	                               <div class="col-md-12 form-group">
	                                   <div class="creat_account d-flex align-items-center">
										<input type="number" name="price" placeholder="가격 입력" value="${product.price }"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '가격 입력'" required
											class="single-input-primary" style="width:68%;">
										<div class="primary-switch">
											<input type="checkbox" id="primary-switch" checked>
											<label for="primary-switch"></label>
										</div>
										<input type="hidden" name="offer" value="1"/>
										<p style="margin-left: 6%; width: 30%; color: darkgray; font-size:14px;">가격제안 받기</p>
	                                   </div>
	                               </div>
	                               <div class="col-md-12 form-group p_star">
									<textarea class="single-textarea" placeholder="부개1동에 올릴 게시글 내용을 작성해주세요.(가품 및 판매금지품목은 게시가 제한될 수 있어요.)" 
											  onfocus="this.placeholder = ''" style="height: 240px;" name="content"
											  onblur="this.placeholder = '부개1동에 올릴 게시글 내용을 작성해주세요.(가품 및 판매금지품목은 게시가 제한될 수 있어요.)'" 
											  required>${product.content }</textarea>
	                               </div>
	                               <div class="col-md-12 form-group">
	                                   <div class="creat_account d-flex align-items-center">
	                                	<button type="button" class="genric-btn default-border btn btn-primary" data-toggle="modal" data-target="#couponModal" 
	                                			style="width: 68%; color: #007bff;" id="selectCoupon">쿠폰 조회</button>
	                   					<div class="confirm-switch">
											<input type="checkbox" id="confirm-switch" disabled>
											<label for="confirm-switch"></label>
										</div>
										<p style="margin-left: 6%; width: 27%; color: darkgray; font-size:14px;">쿠폰 적용</p>
	                                   </div>
	                               </div>
	                               <div class="col-md-12 form-group p_star">
	                                <button type="button" value="submit" class="btn_3" id="uploadBtn" onclick="javascript:fn_save(); return false;">
	                                    	수정
	                                </button>
								   </div>
	                        </div>
	                    </div>
		            </form>
                </div>
            </div>
        </div>
   </section>
    
<!-- ====== Category Modal ======  -->
<div id="categoryModal" class="modal fixed-left fade" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-dialog-aside" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Category</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<div class="button-group-area mt-40">
			<c:forEach items="${category }" var="c" varStatus="status">
			<c:if test="${status.count % 2 == 0}">
			<a href="javascript:void(0);" class="genric-btn primary radius category" style="width: 100%;" 
			   data-code="${c.categoryCode }" data-name="${c.categoryName }">${c.categoryName }</a>
			</c:if>
			<c:if test="${status.count % 2 == 1}">
			<a href="javascript:void(0);" class="genric-btn success radius category" style="width: 100%;" 
			   data-code="${c.categoryCode }" data-name="${c.categoryName }">${c.categoryName }</a>
			</c:if>
			</c:forEach>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- ====== Coupon Modal ======  -->
<div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Coupon</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	   <div class="row text-center align-items-end">
	      <!-- Coupon Table START -->
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white p-5 rounded-lg shadow">
	          <h1 class="h6 text-uppercase font-weight-bold mb-4">${coupon.couponName }</h1>
	          <h2 class="h1 font-weight-bold">${coupon.amount }<span class="text-small font-weight-normal ml-2">개</span></h2>
	
	          <div class="custom-separator my-4 mx-auto bg-primary"></div>
	
	          <ul class="list-unstyled my-5 text-small text-left">
	            <li class="mb-3">
	              <i class="fa fa-check mr-2 text-primary"></i> 쿠폰 적용된 상품은 전국에 노출됩니다.</li>
	            <li class="mb-3">
	              <i class="fa fa-check mr-2 text-primary"></i> 유효기간은 <span class="text-small font-weight-normal ml-2">
	              		<fmt:formatDate value="${coupon.expireDate }" pattern="yyyy년 MM월 dd일"/></span>까지 입니다.</li>
	            <li class="mb-3 text-muted">
	              <i class="fa fa-times mr-2"></i>해당 쿠폰은 타인 양도 불가합니다.
	            </li>
	            <li class="mb-3 text-muted">
	              <i class="fa fa-times mr-2"></i>거짓물품 배송시 사이트 이용에 제한이 생깁니다.
	            </li>
	            <li class="mb-3 text-muted">
	              <i class="fa fa-times mr-2"></i>쿠폰 적용 후 취소는 불가합니다.
	            </li>
	          </ul>
	          <a href="javascript:void(0);" class="btn btn-primary btn-block p-2 shadow rounded-pill coupon">적용</a>
	          <input type="hidden" name="coupon" value="0"/>
	        </div>
	      </div>
	      <!-- Coupon Table END -->
      	</div>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

 
<script>
/* ================ submit form ================*/
$(function()
{
	/*
			초기값
			1. 카테고리
			2. 쿠폰
			3. 가격제안
	*/
	$("#category").html('${categoryName}');
	$("[name=category]").val('${product.category}');

	$("[name=coupon]").val(0);
	if(${product.coupon })
	{
		$('#selectCoupon').attr('disabled', true);
		
		$("#confirm-switch").removeAttr("disabled");
		$("#confirm-switch").prop("checked", true);
		$("[name=coupon]").val(1);
		$("#confirm-switch").on("click", function()
		{
			alert("적용한 쿠폰은 변경할 수 없어요 💧");
			$("#confirm-switch").prop("checked", true);
			$("[name=coupon]").val(1);
		});
	}

	if(${product.offer })
	{
		$("#primary-switch").prop("checked", true);
		$("[name=offer]").val(1);
	}
	else
	{
		$("#primary-switch").prop("checked", false);
		$("[name=offer]").val(0);
	}
	
	
	// 카테고리
	function selectCategory(code, name)
	{
		$("#category").html(name);
		$("[name=category]").val(code);
	}

	$(".category").on("click", function()
	{
		var code = $(this).data('code');
		var name = $(this).data('name');
		
		selectCategory(code, name);
		$("#categoryModal").hide();
		$(".modal-backdrop").hide();
	});

	// 쿠폰
	$(".coupon").on("click", function()
	{
		$("#couponModal").hide();
		$(".modal-backdrop").hide();

		$("#confirm-switch").removeAttr("disabled");
		$("#confirm-switch").prop("checked", true);
		$("[name=coupon]").val(1);
	});

	$("#confirm-switch").on("change", function()
	{
		if($(this).is(":checked"))
			$("[name=coupon]").val(1);
		else
			$("[name=coupon]").val(0);
	});
	
	// 가격제안
	$("#primary-switch").on("change", function()
	{
		if($(this).is(":checked"))
			$("[name=offer]").val(1);
		else
			$("[name=offer]").val(0);
	});
});
</script>



<!-- ================ filepond ================  -->
<script src="https://unpkg.com/filepond-plugin-file-metadata/dist/filepond-plugin-file-metadata.js"></script>
<script src="https://unpkg.com/filepond/dist/filepond.js"></script>
<script src="https://unpkg.com/jquery-filepond/filepond.jquery.js"></script>

<script>



const f = document.querySelector('input[type="file"]');
const pond = FilePond.create
			(f, { 
					maxFiles: 4,
                   	allowMultiple: true,
                   	acceptedFileTypes: ['image/*'],
                   	server: { 
                       			url: "${pageContext.request.contextPath}/product",
                   	        	process: {url: "/boardSaveFile.do?${_csrf.parameterName}=${_csrf.token}" },
                   	        	revert: function (fileId, load, error) { fn_revertFile(fileId); load(); },
							}
                    }
			);


/* 업로드된 파일 filepond에 보여주기 */
var ufiles = [];

<c:forEach var="photo" items="${photos}">
	$('.my-pond').filepond('addFile', '${pageContext.request.contextPath}/resources/upload/${photo.uploadPath}/${photo.uuid}/${photo.originalFilename}').then(function(file)
	{
		// 원래 파일은 지우기
		$.ajax
		({
			url: "${pageContext.request.contextPath}/product/boardDeleteFile.do?fileId=${photo.uuid}",
			method: "POST",
			beforeSend: function(xhr)
			{
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function(result){},
			error: function(xhr, status, err){}
		});
	 });
</c:forEach>

var uploadedfiles = [];
//업로드가 모두 처리된 후 호출되는 callback
//filepond에 파일이 표시 되면 이 함수가 호출된다. 결과적으로 신규등록과 같은 상태가 된다.
pond.on('processfile', function (e, f) 
{
    console.log(f.serverId);
    uploadedfiles.push(f.serverId);
});


var x = new XMLHttpRequest();
var handleStateChange = function () 
{
	/*
		    0: request not initialized
		    1: server connection established
		    2: request received
		    3: processing request
		    4: request finished and response is ready
    */
    
	if(x.readyState == 4 && x.status == 200) //정상처리
	{ 
	    console.log(x.responseText);
	} 
	else 
	{
	    console.log(x.readyState);
	}
};

/* 파일 업로드 취소 */
function fn_revertFile(fileId) 
{
	let p = uploadedfiles.indexOf(fileId);
	uploadedfiles.splice(p,1);

	// 고전적인 AJAX
	if (window.XMLHttpRequest) 
	{
	    x = new XMLHttpRequest();
		x.open("POST", "<c:url value='/product/boardDeleteFile.do?${_csrf.parameterName}=${_csrf.token}'/>", true); // async 
		x.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		x.onreadystatechange = handleStateChange;
		x.send("fileId=" + fileId); //POST방식일때 send()를 사용하여 querystring형태로 전달한다.
   		//str = x.responseText;	//sync일때는 여기서 결과를 받을 수 있다.
		//x=null;
	}
}

/* 파일 업로드 */
function fn_save() 
{
	uploadedfiles.forEach
	(
		function(id, index) 
		{
			document.frm.uploadFile[index].value = id;
			console.log(document.frm.uploadFile[index].value);
		}
	);

	document.frm.action = "<c:url value='/product/update'/>";
	document.frm.submit();

}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
		