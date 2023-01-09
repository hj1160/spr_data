<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="우리 동네 우동마켓" name="pageTitle"/>
</jsp:include>





    <!-- banner part start-->
    <section class="banner_part">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <div class="banner_slider owl-carousel">
                        <div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>우리 동네 직거래 
                                                <br />우동 마켓</h1>
                                            <p>중고 거래부터 동네 이야기 까지, 이웃과 함께 해요.
                                               <br /> 가깝고 따뜻한 우리의 동네를 만들어요.</p>
                                            <a href="#" class="btn_2">구경하기</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="${pageContext.request.contextPath }/resources/img/banner/noodle.png" 
                                    	 alt="" 
                                    	 style="max-width: 400px; position: relative; right: 155px;" >
                                </div>
                            </div>
                        </div><div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>우리 동네
                                                <br />지역 기반 마켓</h1>
                                            <p>동네 주민들과 가깝고 따뜻한 거래를 <br />지금 경험해 보세요.</p>
                                            <a href="#" class="btn_2">인기 매물 보기</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="${pageContext.request.contextPath }/resources/img/banner/web.png" 
                                    	 alt="" 
                                    	 style="max-width: 600px; position: relative; right: 135px;" >
                                </div>
                            </div>
                        </div><div class="single_banner_slider">
                            <div class="row">
                                <div class="col-lg-5 col-md-8">
                                    <div class="banner_text">
                                        <div class="banner_text_iner">
                                            <h1>이웃과 함께 하는
                                                <br />동네 생활</h1>
                                            <p>우리 동네의 다양한 이야기를 이웃과 함께 나누어요.</p>
                                            <a href="#" class="btn_2">우리 동네 질문</a>
                                          </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_img d-none d-lg-block">
                                    <img src="${pageContext.request.contextPath }/resources/img/banner/house.png" 
                                    	 alt="" 
                                    	 style="max-width: 550px; position: relative; right: 135px;" >
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
            </div>
        </div>
    </section>
    <!-- banner part start-->


    <!-- product_list start-->
    <section class="product_list section_padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="section_tittle text-center">
                        <h2>중고거래 인기매물<span><!-- shop --></span></h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="product_list_slider owl-carousel">
                        <div class="single_product_list_slider">
                            <div class="row align-items-center justify-content-between">
								<c:forEach items="${products1}" var="p">
								<div class="col-lg-3 col-sm-6">
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
								</div>
								</c:forEach>
                            </div>
                        </div>
                        <div class="single_product_list_slider">
                            <div class="row align-items-center justify-content-between">
								<c:forEach items="${products2}" var="p">
								<div class="col-lg-3 col-sm-6">
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
								</div>
								</c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	