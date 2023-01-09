<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="pageTitle"/>
</jsp:include>

<sec:authentication property="principal.username" var="userId"/>

<style>
.breadcrumb_bg_01
{
	background-image: url(${pageContext.request.contextPath}/resources/img/breadcrumb_01.png);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}
</style>

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
    <section class="breadcrumb breadcrumb_bg_01">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>우리 동네</h2>
                            <h3>중고 거래</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->

	<!--================ 본문 =================-->	
    <!--================Category Product Area =================-->
    <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
	                            <div class="single_product_menu d-flex">
	                            	<a href="${pageContext.request.contextPath }/product/register?userId=${userId}" class="genric-btn primary radius"
	                            	   style="width:100%">상품 등록</a>
	                            </div>
                                <h3>카테고리</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                	<c:forEach items="${category }" var="c" varStatus="status">
                                    <li>
                                    	<c:if test="${selectedCategory == c.categoryCode}">
                                        <a href="${pageContext.request.contextPath }/product/categoryList?category=${c.categoryCode }&userId=${userId}&currentPage=1"
                                           style="color: red;">
                                        			${c.categoryName }</a>
                                    	</c:if>
                                    	<c:if test="${selectedCategory != c.categoryCode}">
                                        <a href="${pageContext.request.contextPath }/product/categoryList?category=${c.categoryCode }&userId=${userId}&currentPage=1">
                                        			${c.categoryName }</a>
                                    	</c:if>
                                        <span>(${categoryCount[status.index] })</span>
                                    </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </aside>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="product_top_bar d-flex justify-content-between align-items-center">
                                <div class="single_product_menu">
                                    <p><span>${totalCount }</span> 개의 상품</p>
                                </div>
                                <div class="single_product_menu d-flex">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="검색"
                                               onkeyup="javascript:if (event.keyCode == 13) search(this.value);" 
                                               aria-describedby="inputGroupPrepend">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" id="inputGroupPrepend"><i
                                                    class="ti-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center latest_product_inner">
						<c:forEach items="${products}" var="p">
                        <div class="col-lg-4 col-sm-6" style="cursor: pointer;">
                            <div class="single_product_item">
								<c:if test="${p.uploadPath == null}">
								<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
								</c:if>
								<c:if test="${p.uploadPath != null}">
                                <img src="${pageContext.request.contextPath }/resources/upload/${p.uploadPath}/${p.uuid}/${p.originalFilename}" alt="">
								</c:if>
                                <div class="single_product_text">
                                    <h4 onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${p.PCode}&userId=${userId }';">${p.title}</h4>
                                    <span style="color: gray;">${p.address} · <c:if test="${p.pull }">끌올 &nbsp;</c:if>
                                    										   <c:if test="${p.regDate != 0}">${p.regDate} days ago</c:if>
                                    										   <c:if test="${p.regDate == 0}">today</c:if></span>
                                    <h3><fmt:formatNumber type="number" maxFractionDigits="3" value="${p.price}" />원</h3>
                                    <span class="float-right" style="color: gray;">
                                    	<c:if test="${p.wish != 0 }"><i class="far fa-heart"></i> ${p.wish}  </c:if>
                                    	<c:if test="${p.chat != 0 }"><i class="far fa-heart"></i> ${p.wish}  </c:if>
                                    	<br />
                                    </span>
        	                            <a href="javascript:addToWish('${userId}', '${p.PCode}')" class="add_cart">
                                    	+ add to favorite<i class="ti-heart"></i>
                                   	</a>
                                </div>
                            </div>
                        </div>
                    	</c:forEach>
					</div>
                    <div class="col-lg-12">
                        <div class="pageination">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                
								<c:choose>
		                		<c:when test="${ pi.currentPage eq 1 }">
									<li class="page-item disabled">
                                        <a class="page-link" href="#" aria-label="Previous">
                                            <i class="ti-angle-double-left"></i>
                                        </a>
                                    </li>     
			                    </c:when>
			                    <c:otherwise>
									<li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath }/product/productListView?currentPage=${pi.currentPage-1}&userId=${userId}" aria-label="Previous">
                                            <i class="ti-angle-double-left"></i>
                                        </a>
                                    </li>     
		                    	</c:otherwise>
		                    	</c:choose>
		                    	
			                    <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
		                    	<c:choose>
	                    		<c:when test="${ p eq pi.currentPage }">
		                    		<li class="page-item disabled"><a class="page-link" href="#">${ p }</a></li>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath }/product/productListView?currentPage=${ p }&userId=${userId}">${ p }</a></li>
	                    		</c:otherwise>
		                    	</c:choose>
			                    </c:forEach>
		                    	
			                    <c:choose>
		                    	<c:when test="${ pi.currentPage eq pi.maxPage }">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" aria-label="Next">
                                            <i class="ti-angle-double-right"></i>
                                        </a>
                                    </li>
			                    </c:when>
			                    <c:otherwise>
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath }/product/productListView?currentPage=${pi.currentPage + 1}&userId=${userId}" aria-label="Next">
                                            <i class="ti-angle-double-right"></i>
                                        </a>
                                    </li>
		                    	</c:otherwise>
			                    </c:choose>
			                    
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</section>
    <!--================End Category Product Area =================-->

    <!-- product_list part start-->
    <section class="product_list best_seller">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>우리동네 베스트</h2>
                    </div>
                </div>
            </div>
            <div class="row align-items-center justify-content-between">
                <div class="col-lg-12">
                    <div class="best_product_slider owl-carousel">
                    	<c:forEach items="${popular }" var="p">
                        <div class="single_product_item">
							<c:if test="${p.uploadPath == null}">
							<img src="${pageContext.request.contextPath }/resources/img/noimage.png" alt="">
							</c:if>
							<c:if test="${p.uploadPath != null}">
							<img src="${pageContext.request.contextPath }/resources/upload/${p.uploadPath}/${p.uuid}/${p.originalFilename}" alt="">
							</c:if>
							<div class="single_product_text">
								<h4 onclick="location.href='${pageContext.request.contextPath}/product/productDetailView?pCode=${p.PCode}&userId=${userId }';">${p.title}</h4>
								<span style="color: gray;">${p.address} · <c:if test="${p.pull }">끌올 &nbsp;</c:if>
																		   <c:if test="${p.regDate != 0}">${p.regDate} days ago</c:if>
																		   <c:if test="${p.regDate == 0}">today</c:if></span>
								<h3><fmt:formatNumber type="number" maxFractionDigits="3" value="${p.price}" />원</h3>
								<span class="float-right" style="color: gray;">
									<c:if test="${p.wish != 0 }"><i class="far fa-heart"></i> ${p.wish}  </c:if>
									<c:if test="${p.chat != 0 }"><i class="far fa-heart"></i> ${p.wish}  </c:if>
									<br />
								</span>
							</div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- product_list part end-->	

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
<script>
// 검색결과 없을 시 이전페이지로 이동
/* $(function()
{
	if(${products == null || products.size() == 0})
		history.back();
}); */
// 관심 목록 추가
function addToWish(userId, pCode)
{
	$.ajax
	({
		url: "${pageContext.request.contextPath}/product/addToWish",
		method: "POST",
		data: 
		{
			userId: userId,
			pCode: pCode
		}, 
		dataType: "text",
		beforeSend: function(xhr)
		{
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
			success: function(result)
		{
			alert(result);										
		},
		error: function(xhr, status, err)
		{
			alert("이미 관심목록에 추가되있어요 💘");
		}
	});
}

// 검색
function search(keyword) 
{
	location.href 
		= "${pageContext.request.contextPath}/product/search?keyword=" + keyword + "&category=${selectedCategory}&userId=${userId}&currentPage=1";
}


</script>
	
	
	