<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	
<%-- 	한글 인코딩 처리 --%>
<fmt:requestEncoding value="utf-8"/>	
	
	<jsp:include page="/WEB-INF/views/common/header.jsp">
		<jsp:param value="비밀번호찾기" name="pageTitle"/>
	</jsp:include>
	
<script>

$(function(){
	$("#passwordFindModal").modal()
					.on("hide.bs.modal", function(){
						location.href = "${ header.referer }";
					});
});
</script>
	
	<!-- Modal -->
<div class="modal fade" id="passwordFindModal" tabindex="-1" role="dialog" aria-labelledby="passwordFindModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
  
      <div class="modal-header">
        <h5 class="modal-title" id="passwordFindModalLabel">비밀번호 찾기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  	
  	  <!-- _csrf인증 토큰 발행  -->
  	  <form:form 
   	  		action="${ pageContext.request.contextPath }/member/passwordFind"
  	  		method="POST">
	      <div class="modal-body">
	      	<input type="text" class="form-control" 
	      		   name="userId" id="userId" 
	      		   placeholder="아이디" required/>
	      	<br />
	      	<input type="email" class="form-control" 
	      		   name="email" id="email" 
	      		   placeholder="이메일" required/>
	      </div>
	    
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-outline-success">비밀번호 찾기</button>
	        <button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
	      </div>
  	  </form:form>
    </div>
  </div>
</div>

		
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>