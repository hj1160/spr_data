<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>

<div class="modal fade" id="pullModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle"><strong>끌어올리기</strong></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
	   <div class="row text-center align-items-end">
	      <!-- 끌올 가능 START -->
	      <c:if test="${product.timeMillis gt 259200000 }">
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white rounded-lg">
	        	<div class="media" style="background-color: #F9F9FF;">
	              <div class="d-flex ml-4 my-2" style="width: 17%;">
	                <img class="rounded-circle" 
	                	 src="${pageContext.request.contextPath }/resources/img/member/${seller.originalFilename }"  
	                	 alt="" />
	              </div>
	              <div class="my-4 ml-4 text-left" style="width: 37%;">
	                <h4>${product.title }</h4>
	                <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}" />원</span>
	              </div>
				</div>
				<div class="p-4 text-left">
					<h3><strong>${seller.nickname }님, 끌어올리기 전에</strong></h3>
					<h3><strong>가격을 낮춰보세요.</strong></h3>
					<h4>판매 확률이 올라간답니다.</h4>
					<br/>
					<input type="number" name="price" placeholder="가격 입력"
											onfocus="this.placeholder = ''" onblur="this.placeholder = '가격 입력'" required
											class="single-input-primary" style="width:68%;">
					<br/><hr/>
					<h3><strong>가격을 변경하지 않고</strong></h3>
					<h3><strong>지금 끌어올리시겠어요?</strong></h3>
					<h4>다음 끌어올리기는 <span style="color: red;">3일</span> 뒤에 할 수 있어요.</h4>
				</div>
				<div class="my-5">
					<button class="genric-btn primary w-75" onclick="pull();">끌어올리기</button>
				</div>
	        </div>
	      </div>
	      </c:if>
	      <!-- 끌올 가능 END -->
	      <!-- 끌올 불가능 START -->
	      <c:if test="${product.timeMillis lt 259200000 }">
	      <div class="mb-5 mb-lg-0" style="float:none; margin:0 auto;">
	        <div class="bg-white rounded-lg">
	        	<div class="media" style="background-color: #F9F9FF;">
	              <div class="d-flex ml-4 my-2" style="width: 17%;">
	                <img class="rounded-circle" 
	                	 src="${pageContext.request.contextPath }/resources/img/member/${seller.originalFilename }"  
	                	 alt="" />
	              </div>
	              <div class="my-4 ml-4 text-left" style="width: 37%;">
	                <h4>${product.title }</h4>
	                <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price}" />원</span>
	              </div>
				</div>
				<div class="p-4 text-left">
					<h3 style="color: red;">
					<strong>
						<fmt:parseNumber value="${(259200000 - product.timeMillis) / 1000 / 60 / 60 / 24 }" integerOnly="true" />일 
						<fmt:parseNumber value="${(259200000 - product.timeMillis) / 1000 / 60 / 60 % 24 }" integerOnly="true" />시간 
						<fmt:parseNumber value="${(259200000 - product.timeMillis) / 1000 / 60 % 60 }" integerOnly="true" />분 뒤에 
					</strong>
					</h3>
					<h3><strong>끌어올릴 수 있어요.</strong></h3>
					<br/>
					<h4>${seller.nickname }님, 혹시 판매가 잘 안되시나요?</h4>
					<h4>판매 꿀팁을 확인하고 판매 확률을 높여보세요.</h4>
					<br/>
					<a href="#">판매 확률 높이는 꿀팁보기</a>
				</div>
				<div class="my-5">
					<button class="genric-btn disable w-75" disabled>끌어올리기</button>
				</div>
	        </div>
	      </div>
	      </c:if>
	      <!-- 끌올 불가능 END -->
      	</div>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
function pull()
{
	var price = $("input[name=price]").val() == "" ? "x" : $("input[name=price]").val();
	var pCode = "${product.PCode}";

	$.ajax
	({
		url: "${pageContext.request.contextPath}/product/pull/"+price+"/"+pCode,
		method: "PUT",
		beforeSend: function(xhr)
		{
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        dataType: "json",
		success: function(map)
		{
			alert(map.msg);
			$("#pullModal").modal('hide');
		},
		error: function(xhr, status, err)
		{
			alert("끌어올리기에 실패했어요 💧");
			console.log(xhr, status, err);
		}
	});
}
</script>
	
	
	