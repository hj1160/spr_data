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
<meta charset="UTF-8">
<title>채팅</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- chat css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/chat.css">

</head>
<body>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="userId"/>
</sec:authorize>

<!-- Modal -->
<div class="">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
  
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">채팅</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.close()">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  
  
		<div class="container py-2 px-4">
		
		  <div class="row rounded-lg overflow-hidden shadow">
		    <!-- Users box-->
		    <div class="col-5 px-0">
		      <div class="bg-white">
		
		        <div class="bg-gray px-4 py-2 bg-light">
		          <p class="h5 mb-0 py-1">채팅</p>
		        </div>
		
		        <div class="messages-box">
		          <div class="list-group rounded-0">
		          	<c:if test="${not empty list }">
			          	<c:forEach items="${list }" var="r">
						    <a href="javascript:void(0);" class="list-group-item list-group-item-action list-group-item-light rounded-0" name="chatRoom" >
						      <input type="hidden" name="roomCode" value=${r.roomCode } />
						      <input type="hidden" name="receiver" value=${r.sender } />
						      <input type="hidden" name="enabled" value=${r.senderEnabled } />
				              <div class="media"><img src="${pageContext.request.contextPath }/resources/img/member/${r.renamedFilename == null ? r.originalFilename:r.renamedFilename}" alt="user" width="50" class="rounded-circle">
				                <div class="media-body ml-4">
				                  <div class="d-flex align-items-center justify-content-between mb-1">
				                    <h6 class="mb-0">${r.senderNickName}</h6><small class="small font-weight-bold"><fmt:formatDate value="${r.regDate }" pattern="yy/MM/dd"/></small>
				                  </div>
				                  <p class="font-italic text-muted mb-0 text-small">${r.title }</p>
				                </div>
				              </div>
				            </a>
				            <button type="button" class="btn btn-outline-secondary" name="leaveChatRoom"
				            		value="${r.roomCode }"
				            		style="z-index: 1;">나가기</button>
			          	</c:forEach>
		          	</c:if>
		          </div>
		        </div>
		      </div>
		    </div>
		    <!-- Chat Box-->
		    <div class="col-7 px-0">
		      <!-- Typing area -->
		      <div class="bg-light">
	          <%-- <form action="" class="bg-light"> --%>
		        <div class="input-group">
		        
		          <!-- 사진보내기 START -->
		          <form action="" method="post" id="fileForm" enctype="multipart/form-data">
			          <input type="file" name="file" id="file" 
			          		 accept="image/jpeg, image/png" style="display:none"/>
		              <button id="fileBtn" 
		              	      type="button" 
		              	      class="btn btn-link" 
		              	      disabled="disabled"
		              	      onclick="onclick=document.all.file.click()">➕</button>
		          </form>
			       <!-- 사진보내기 END -->
		          
		          <input type="text" 
		          	     id="message" 
		          	     placeholder="Type a message" 
		          	     aria-describedby="button-addon2" 
		          	     class="form-control rounded-0 border-0 py-4 bg-light"
		          	     disabled="disabled">
		          <div class="input-group-append" >
		          	<input type="hidden" id="receiver" />
		            <button id="sendBtn" type="button" class="btn btn-link" disabled="disabled">전송</button>
		          </div>
		        </div>
		        <!-- Typing area -->
		      </div>
		       <%-- </form> --%>

		      <div class="px-4 py-5 chat-box bg-white" id="chatBox">
		      	<input type="hidden" id="roomCode_" />
		        <span>채팅방을 선택해주세요.</span>
		      </div>		
		
		    </div>
		  </div>
		</div>
    </div>
  </div>
</div>
<script>
//사진 업로드
$("#file").bind('change', function(){

	let receiver = $("#receiver").val();
	let myId = "${userId}";
	let roomCode = $("#sendBtn").val();
	
	var form = $("#fileForm")[0];
	var formData = new FormData(form);

	$.ajax({
		 url: "${pageContext.request.contextPath}/chat/sendPhoto",
         processData: false,
         //false : form-data 를 String으로 변환하지 않음
         contentType: false,
         //false : multipart/form-data
         data: formData,
         type: 'POST',
         beforeSend : function(xhr){
             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success: function(result){

        	 var name = result.split("/");
        	 var fileName = name[0];
        	 var renamedFileName = name[1];

   			console.log("chat :: socket >> ", sock);
   			sock.send("file," + myId + "," + receiver + "," + roomCode + "," + result); 

   			let myMsg = "<div class='media w-50 ml-auto mb-3'>" +
   					        "<div class='media-body'>" +
   					          "<div class='bg-primary rounded py-2 px-3 mb-2'>" +
   					          "<img src='${pageContext.request.contextPath }/resources/upload/chat/" + renamedFileName +"' width='150'>" +
   					          "</div>" +
   					          "<p class='small text-muted'>" + formatDate(new Date()) + "</p>" +
   					        "</div>" +
   					      "</div>";

   			$("#chatBox").prepend(myMsg);
   			$("#message").val("");
        	 
         },
         error : function(xhr, status, err){
 			console.log("처리 실패", xhr, status, err);
 			alert("실패");
 		}
	});
	
	
	//$("#chatBox").prepend(senderMsg);	
	
	
});

//채팅방 나가기
$("[name=leaveChatRoom]").click(function(){

	if(!confirm("정말 나갈까요?")) return;
	
	var $roomCode = $(this).val();
	var $myId = "${userId}";

	$.ajax({
		url : "${pageContext.request.contextPath}/chat/leaveChatRoom",
		method : "POST",
		data : {
				roomCode : $roomCode,
				userId : $myId
		},
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(url){
			//alert("성공" + url);
			location.href = "${pageContext.request.contextPath}" + url;
		},
		error : function(xhr, status, err){
			console.log("처리 실패", xhr, status, err);
			alert("채팅방 나가기에 실패했어요 다시 시도해주세요 💦");
		}
	});
	
});

//날짜포맷
function formatDate(day){

	let date = new Date(day);
	
    let yyyy = date.getFullYear();
    let mm = get2digit(date.getMonth()+1);
    let dd = get2digit(date.getDate());

    let hh = get2digit(date.getHours());
    let mi = get2digit(date.getMinutes());

    let fmt = yyyy + "/" + mm + "/" + dd + " " + hh + ":" + mi;

    return fmt;
}

//시간포맷
function get2digit(num){
    if(num<10)
        return "0"+num;
    else
        return num;
}

//채팅방 누르면 채팅 내용 가져오기
$("[name=chatRoom]").click(function(){
	var $roomCode = $(this).find("[name=roomCode]").val();
	var $receiver = $(this).find("[name=receiver]").val();
	var $enabled = $(this).find("[name=enabled]").val();
	var $myId = "${userId}";

	$("#chatBox").empty();
	
	//선택된 채팅방 색깔 바꾸기
	$("[name=chatRoom]").attr('class', "list-group-item list-group-item-action list-group-item-light rounded-0");
	$(this).attr('class', "list-group-item list-group-item-action list-group-item-light rounded-0");

	//버튼 활성화
	$("#sendBtn").attr("disabled", false);
	$("#fileBtn").attr("disabled", false);
	//input:text 활성화
	$("#message").attr("disabled", false);
	
	//대화 내용 가져오기
	$.ajax({
		url : "${pageContext.request.contextPath}/chat/selectChatMsg",
		method : "POST",
		dataType : "json",
		data : {
				roomCode : $roomCode,
		},
		beforeSend : function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(data){
			let msg = data.list;

			for(let i = 0; i<msg.length; i++){

				if(msg[i].renamedFileName == null){

					//내가 보낸 메세지
					if(msg[i].userId != $myId){
	
						let senderMsg = "<div class='media w-50 mb-3'>" +
								          "<div class='media-body ml-3'>" +
								            "<div class='bg-light rounded py-2 px-3 mb-2'>" +
								              "<p class='text-small mb-0 text-muted'>" + msg[i].chatContent + "</p>" +
								            "</div>" +
								            "<p class='small text-muted'>" + formatDate(msg[i].chatDate) + "</p>" +
								          "</div>" +
								        "</div>";
	
						$("#chatBox").append(senderMsg);							
					}
					//상대방이 보낸 메세지
					else if (msg[i].userId == $myId){
	
						let recieverMsg = "<div class='media w-50 ml-auto mb-3'>" +
									          "<div class='media-body'>" +
									            "<div class='bg-primary rounded py-2 px-3 mb-2'>" +
									              "<p class='text-small mb-0 text-white'>" + msg[i].chatContent + "</p>" +
									            "</div>" +
									            "<p class='small text-muted'>" + formatDate(msg[i].chatDate) +"</p>" +
									          "</div>" +
									        "</div>";
	
						
						$("#chatBox").append(recieverMsg);		
					}
				}
				else {

					//내가 보낸 메세지
					if(msg[i].userId != $myId){
	
						let senderMsg = "<div class='media w-50 mb-3'><img src='https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg' alt='user' width='50' class='rounded-circle'>" +
								          "<div class='media-body ml-3'>" +
								            "<div class='bg-light rounded py-2 px-3 mb-2'>" +
								              "<img src='${pageContext.request.contextPath }/resources/upload/chat/" + msg[i].renamedFileName +"' width='150'>" +
								            "</div>" +
								            "<p class='small text-muted'>" + formatDate(msg[i].chatDate) + "</p>" +
								          "</div>" +
								        "</div>";
	
						$("#chatBox").append(senderMsg);							
					}
					//상대방이 보낸 메세지
					else if (msg[i].userId == $myId){
	
						let recieverMsg = "<div class='media w-50 ml-auto mb-3'>" +
									          "<div class='media-body'>" +
									            "<div class='bg-primary rounded py-2 px-3 mb-2'>" +
									            "<img src='${pageContext.request.contextPath }/resources/upload/chat/" + msg[i].renamedFileName +"' width='150'>" +
									            "</div>" +
									            "<p class='small text-muted'>" + formatDate(msg[i].chatDate) +"</p>" +
									          "</div>" +
									        "</div>";
	
						
						$("#chatBox").append(recieverMsg);		
					}
				}			
			} 

			if($enabled == 'false'){
				$("#chatBox").prepend("<p>상대방이 채팅방을 나갔습니다. 대화가 종료됩니다.</p>");
				$("#sendBtn").attr("disabled", "disabled");
				console.log("sdfgf");
			}

			$("#sendBtn").val($roomCode);
			$("#receiver").val($receiver);

			
			//console.log("sendBtn : " + $("#sendBtn").val());
		},
		error : function(xhr, status, err){
			console.log("처리 실패", xhr, status, err);
			alert("대화 불러오기에 실패했어요 다시 시도해주세요 💦");
		}
		
	});
	
});

//메세지 보내기
$("#sendBtn").click(function() {
	let $msg = $("#message").val();
	let roomCode = $(this).val();
	let receiver = $("#receiver").val();
	let myId = "${userId}";
	console.log("myId = " + myId);
	console.log("receiver = " + receiver);

	if(sock){
		console.log("chat :: socket >> ", sock);
		sock.send("chat," + myId + "," + receiver + "," + roomCode + "," + $msg); 

		let myMsg = "<div class='media w-50 ml-auto mb-3'>" +
				        "<div class='media-body'>" +
				          "<div class='bg-primary rounded py-2 px-3 mb-2'>" +
				            "<p class='text-small mb-0 text-white'>" + $msg + "</p>" +
				          "</div>" +
				          "<p class='small text-muted'>" + formatDate(new Date()) + "</p>" +
				        "</div>" +
				      "</div>";

		//$("#chatBox").append(myMsg);
		$("#chatBox").prepend(myMsg);
		$("#message").val("");
		
	}else{
		console.log("Error on Chat", sock);
	}
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
