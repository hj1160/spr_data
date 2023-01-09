<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	
<%-- 	한글 인코딩 처리 --%>
<fmt:requestEncoding value="utf-8"/>	
	
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="쿠폰관리" name="pageTitle"/>
	</jsp:include>



<style>
a {
	text-decoration: none;
	color: black;
}
</style>

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
	<section class="breadcrumb breadcrumb_bg">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>관리자용 페이지</h2>
							<!-- <h3>서울 강남구 논현동</h3> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	
		<!--================ 사이드바 =================-->	
    <section class="cat_product_area section_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="left_sidebar_area">
                        <aside class="left_widgets p_filter_widgets">
                            <div class="l_w_title">
                                <h3>관리자 메뉴</h3>
                            </div>
                            <div class="widgets_inner">
                                <ul class="list">
                                    <li><a href="${pageContext.request.contextPath }/admin/memberList">회원 조회 / 등록 / 삭제</a></li>
                                    <li><a href="${pageContext.request.contextPath }/admin/declareMemberList">신고 관리(사용자)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/declareBoardList">신고 관리(동네생활)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/declareProductList">신고 관리(중고거래)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/declareReplyList">신고 관리(댓글)</a></li>
									<li><a href="${pageContext.request.contextPath }/admin/CouponList">쿠폰 관리</a></li>
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
	                                    <p><span>${totalContents }</span> 개의 쿠폰</p>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    <div class="row align-items-center latest_product_inner">
                    	<form:form id="adminCouponFrm" action="adminCouponEnroll" method="POST">
                            		<table id="tbl-coupon" class="table table-bordered">
										<tr>
											<th>쿠폰코드</th>
											<th>쿠폰보유자</th>
											<th>쿠폰명</th>
											<th>유효기간</th>
											<th>사용여부</th>
										</tr>
										<c:forEach items="${ list }" var="coupon">
											<tr>
												<td>${ coupon.couponCode }</td>
												<td>${ coupon.userId }</td>
												<td>${ coupon.couponName }</td>
												<td><fmt:formatDate value="${ coupon.expireDate }" type="both"/></td>
												<td>${ coupon.usageStatus }</td>
											</tr>
										</c:forEach>
										<tr>
											<td>
												<input type="text" class="input-field1" name="couponCode" id="couponCode" placeholder="쿠폰코드" />
											</td>
											<td style="padding-top:0.5em;">
								                <select name="userId" id="userId" multiple >
								                	<c:forEach items="${rank }" var="r" begin="1" end="3" step="1">
								                    <option value="${r.seller }">${r.seller }</option>
													</c:forEach>
								                </select>							
											</td>
											<td>
												<input type="text" class="input-field1" name="couponName" id="couponName" placeholder="쿠폰이름" />
											</td>
											<td>
												<input type="date" class="input-field1" name="expireDate" id="expireDate" placeholder="닉네임" />
											</td>
											<td>
												<input type="text" class="input-field1" name="usageStatus" id="usageStatus" placeholder="사용 상태" />
											</td>
											<td>
												<input type="submit" value="쿠폰등록" />
											</td>
										</tr>
									</table>
							</form:form>
                            </div>
                        </div>
                       	<!-- 페이징처리 -->
						<div class="col-lg-12">
	                        <div class="pageination">
	                            <nav aria-label="Page navigation example">
	                                <ul class="pagination justify-content-center">
	                                    ${pageBar }
	                                </ul>
	                            </nav>
	                        </div>
	                    </div>
						<!-- 페이징처리 --> 
					</div>
                </div>
	</section>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>