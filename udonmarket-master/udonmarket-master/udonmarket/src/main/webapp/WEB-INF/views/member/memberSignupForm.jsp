<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<fmt:requestEncoding value="utf-8"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="pageTitle"/>
</jsp:include>
<script>



</script>

<!-- mypage css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/signupform.css">

    <!--================Home Banner Area =================-->
    <!-- breadcrumb start-->
    <section class="breadcrumb breadcrumb_bg">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>회원가입</h2>
							<!-- <h3>서울 강남구 논현동</h3> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- breadcrumb start-->
    
   <div id="memberSignup-container" class="row py-5 px-4">
	    <div class="col-md-5 mx-auto">
	     <form:form id="memberSignupFrm" action="signupForm" method="post">
	        <!-- Profile widget -->
	        <div class="bg-white shadow rounded overflow-hidden">
	            <div class="px-4 pt-0 pb-4 cover">
	                <div class="media align-items-end profile-head" style="text-align: center">
	                    <div class="media-body mb-5 text-white">
	                        <h4 class="mt-0 mb-0" style="color:white;">회원가입</h4>
	                    </div>
	                </div>
	            </div>
	            <div class="px-4 py-3">
	                <div class="p-4 rounded shadow-sm bg-light">
				        <!-- Vertical Menu-->
				        <nav class="nav flex-column bg-white shadow-sm rounded p-3">
				        	<table class="mx-auto">
				        	<tr>
				        		<td>
					        		<div id="form-group">
					        			<label for="userId">아이디</label>
				        				<input type="text" name="userId" id="userId" class="form-control" placeholder="아이디 입력" required  />
										<input type="hidden" id="idValid" value="0" />
										<div class="check_font" id="id_check"></div>
<!-- 				        				<span class="guideok">이 아이디는 중복된 아이디가 아닙니다.<br>(영어 소문자 또는 숫자로 시작하는 4~12자리인지 확인해주세요.)</span>		    -->
<!-- 										<span class="guideerror">이 아이디는 중복된 아이디입니다.</span>		    -->
<!-- 										<label for="userId">아이디</label> -->
<!-- 										<input type="text" class="form-control" id="userId" name="userId" placeholder="ID" required> -->
<!-- 										<div class="check_font" id="id_check"></div> -->
				        			</div>
				        		</td>
				        	</tr>
				        	<tr>
				        		<td>
				        			<div class="form-group">
<!-- 				        				<label for="password">비밀번호</label> -->
<!-- 				        				<input type="password" name="password" id="password_" class="nav-link px-4 rounded-pill" placeholder="비밀번호 입력" required style="width: 22rem;"/> -->
											<label for="password">비밀번호</label>
											<input type="password" class="form-control" id="password_" name="password" placeholder="PASSWORD" required>
											<div class="check_font" id="pw_check"></div>
				        			</div>
				        		</td>
				        	</tr>
				        	<tr>
				        		<td>
				        			<div class="form-group">
<!-- 				        				<label for="password2">비밀번호 재확인</label> -->
<!-- 				        				<input type="password" name="password2" id="password2" class="nav-link px-4 rounded-pill" placeholder="비밀번호 확인" required style="width: 22rem;"/> -->
											<label for="password2">비밀번호 확인</label>
											<input type="password" class="form-control" id="passsword2" name="password2" placeholder="Confirm Password" required>
											<div class="check_font" id="pw2_check"></div>
				        			</div>
				        		</td>
				        	</tr>
				        	<tr>
				        		<td>
				        			<div class="form-group">
<!-- 				        				<label for="email">이메일</label> -->
<!-- 				        				<input type="email" name="email" id="email" class="nav-link px-4 rounded-pill" placeholder="이메일 입력(abc@xyz.com)" required style="width: 22rem;"/> -->
											<label for="email">이메일</label>
											<input type="text" class="form-control" name="email" id="email" placeholder="E-mail" required>
											<div class="check_font" id="email_check"></div>
				        			</div>
				        		</td>
				        	</tr>
				        	<tr>
				        		<td>
				        			<div class="form-group">
<!-- 				        				<label for="nickName">닉네임</label> -->
<!-- 				        				<input type="text" name="nickName" id="nickName" class="nav-link px-4 rounded-pill" placeholder="별명 입력" required style="width: 22rem;"/> -->
											<label for="nickName">닉네임</label>
											<input type="text" class="form-control" id="nickName" name="nickName" placeholder="NickName" required>
											<div class="check_font" id="nickName_check"></div>
				        			</div>
				        		</td>
				        	</tr>
				        	</table>
				        </nav>
				        <div class="reg_button" style="text-align: center;">
<!-- 				        	<input type="submit" value="회원가입" class="nav-link-submit-reset px-4 rounded-pill"> -->
<!-- 								<input type="reset" value="취소" class="nav-link-submit-reset px-4 rounded-pill"> -->
								<button class="btn btn-primary px-3" id="reg_submit">
									<i class="fa fa-heart pr-2" aria-hidden="true"></i>가입하기
								</button>
								<input type="reset" value="취소" class="btn btn-danger px-3">
						</div>
	                </div>
	            </div>
	        </div>
	    </form:form>
	    </div>
	</div>
<script>
//모든 공백 체크 정규식
var empJ = /\s/g;
//아이디 정규식
var idJ = /^[a-z0-9]{4,12}$/; //a~z, 0~9로 시작하는 4~12자리 아이디를 만들 수 있음. 
// 비밀번호 정규식
var pwJ = /^[A-Za-z0-9]{4,12}$/;  //A-Z, a-z, 0~9로 시작하는 4~12자리 비밀번호를 설정할 수 잇음.
// 닉네임 정규식
var nameJ = /^[A-Za-z0-9]{4,10}$/; //A-Z a-z, 0~9로 이뤄진 문자만 4~10자리 이름 적어야 함.
// 이메일 검사 정규식
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // -,_ 특수문자가 가능하며, 중앙에 @필수 그리고, 뒤에 2~3글자가 필요함.


  $("#userId").keyup(function(){

	//중복 검사후 아이디 재작성하는 경우
	if(/^\w{1,}$/.test($(this).val()) == false){
		$("#id_check").hide();
		$("#idValid").val(0);
		return;
	}

	$.ajax({
		url : "${ pageContext.request.contextPath }/member/checkIdDuplicate",
		data : {
			userId : $(this).val()
		},
		dataType : "json",
		success : function(data){
			console.log(data);

			if(data.isUsable == true){
// 				$(".guide.error").hide();
// 				$(".guide.ok").show();
				$("#id_check").text("이 아이디는 중복된 아이디가 아닙니다.(영어 소문자 또는 숫자로 시작하는 4~12자리인지 확인해주세요.)");
				$("#id_check").css('color', 'green');
				$("#idValid").val(1);
			}
			else{
				$("#id_check").text("이 아이디는 중복된 아이디입니다.");
				$("#id_check").css('color', 'red');
// 				$(".guide.error").show();
// 				$(".guide.ok").hide();
				$("#idValid").val(0);
			}
		},
		error : function(xhr, status, err){
			console.log("처리실패", xhr, status, err);
		}
	});
});  


//아이디 유효성 검사(1 = 중복 / 0 != 중복)
/* $("#userId").keyup(function() {
	// id = "id_reg" / name = "userId"
	var userId = $('#userId').val();
	
	$.ajax({
		url : '${pageContext.request.contextPath}/member/checkIdDuplicate?userId='+ userId,
		type : 'get',
		success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : " + data);							
			
			if (data == 1) {
					// 1 : 아이디가 중복되는 문구
					$("#id_check").text("사용중인 아이디입니다.");
					$("#id_check").css("color", "red");
					$("#reg_submit").attr("disabled", true);
				} 
			else {
					
					if(idJ.test(userId)){
						// 0 : 아이디 길이 / 문자열 검사
						$("#id_check").text("");
						$("#reg_submit").attr("disabled", false);
			
					} else if(userId == ""){
						
						$('#id_check').text('아이디를 입력해주세요.');
						$('#id_check').css('color', 'red');
						$("#reg_submit").attr("disabled", true);				
						
					} else {
						
						$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다");
						$('#id_check').css('color', 'red');
						$("#reg_submit").attr("disabled", true);
					}
					
				}
			}, error : function() {
					console.log("실패");
			}
		});
	}); */

// 
 $("#memberSignupFrm").submit(function(){

		//html5 추가된 속성 pattern을 활용해 정규식 검사도 가능하지만,
		//구체적인 피드백제공하지는 못한다.
		var $userId = $("#userId");
		if(/^[a-z0-9]{4,12}$/.test($userId.val()) == false){
			alert("영어 소문자 또는 숫자로 시작하는 4~12자리를 입력해주세요. ");
			$userId.focus();
			return false;
		}

		//중복검사여부
		var $idValid = $("#idValid");
		if($idValid.val() == 0){
			alert("아이디 중복검사 해주세요.");
			return false;
		} 
		return true;
});

 // 패스워드 유효성 검사
$('#password_').blur(function(){
		if(pwJ.test($('#password_').val())){
			console.log('true');
			$('#pw_check').text('');
		} else {
			console.log('false');
			$('#pw_check').text('숫자 or 문자로만 4~12자리 입력해주세요.');
			$('#pw_check').css('color', 'red');
		}
});	

// 패스워드 중복 검사
$("#password2").blur(function() {
	var $p1 = $("#password_"), $p2 = $("#password2");
	if($p1.val() != $p2.val()){
		$('#pw2_check').text('비밀번호가 일치하지 않습니다.');
		$('#pw2_check').css('color', 'red');
		$p1.focus();
	} else{
		$('#pw2_check').text('');
	}
});

//이름에 특수문자 들어가지 않도록 설정
$("#nickName").blur(function() {
	if (nameJ.test($(this).val())) {
			console.log(nameJ.test($(this).val()));
			$("#nickName_check").text('');
	} else {
		$('#nickName_check').text('영어 또는 숫자로 이뤄진 4~10자리 이름을 적어주세요. ');
		$('#nickName_check').css('color', 'red');
	}
});

//이메일 정규식
$("#email").blur(function() {
	if (mailJ.test($(this).val())) {
			console.log(mailJ.test($(this).val()));
			$("#email_check").text('');
	} else {
		$('#email_check').text('이메일을 다시 확인해주세요.');
		$('#email_check').css('color', 'red');
	}
});




</script>
   








<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
	
	
	