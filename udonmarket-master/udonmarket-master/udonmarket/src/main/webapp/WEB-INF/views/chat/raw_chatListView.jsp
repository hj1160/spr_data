<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

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

<!-- Modal -->
<div class="">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
  
      <div class="modal-header">
        <h5 class="modal-title" id="loginModalLabel">채팅</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
  
  
		<div class="container py-2 px-4">
		
		  <div class="row rounded-lg overflow-hidden shadow">
		    <!-- Users box-->
		    <div class="col-5 px-0">
		      <div class="bg-white">
		
		        <div class="bg-gray px-4 py-2 bg-light">
		          <p class="h5 mb-0 py-1">Recent</p>
		        </div>
		
		        <div class="messages-box">
		          <div class="list-group rounded-0">
		            <a class="list-group-item list-group-item-action active text-white rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">25 Dec</small>
		                  </div>
		                  <p class="font-italic mb-0 text-small">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">14 Dec</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">Lorem ipsum dolor sit amet, consectetur. incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">9 Nov</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">18 Oct</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">17 Oct</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">2 Sep</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-1">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">30 Aug</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		            <a href="#" class="list-group-item list-group-item-action list-group-item-light rounded-0">
		              <div class="media"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		                <div class="media-body ml-4">
		                  <div class="d-flex align-items-center justify-content-between mb-3">
		                    <h6 class="mb-0">Jason Doe</h6><small class="small font-weight-bold">21 Aug</small>
		                  </div>
		                  <p class="font-italic text-muted mb-0 text-small">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.</p>
		                </div>
		              </div>
		            </a>
		
		          </div>
		        </div>
		      </div>
		    </div>
		    <!-- Chat Box-->
		    <div class="col-7 px-0">
		      <div class="px-4 py-5 chat-box bg-white">
		        <!-- Sender Message-->
		        <div class="media w-50 mb-3"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		          <div class="media-body ml-3">
		            <div class="bg-light rounded py-2 px-3 mb-2">
		              <p class="text-small mb-0 text-muted">Test which is a new approach all solutions</p>
		            </div>
		            <p class="small text-muted">12:00 PM | Aug 13</p>
		          </div>
		        </div>
		
		        <!-- Reciever Message-->
		        <div class="media w-50 ml-auto mb-3">
		          <div class="media-body">
		            <div class="bg-primary rounded py-2 px-3 mb-2">
		              <p class="text-small mb-0 text-white">Test which is a new approach to have all solutions</p>
		            </div>
		            <p class="small text-muted">12:00 PM | Aug 13</p>
		          </div>
		        </div>
		
		        <!-- Sender Message-->
		        <div class="media w-50 mb-3"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		          <div class="media-body ml-3">
		            <div class="bg-light rounded py-2 px-3 mb-2">
		              <p class="text-small mb-0 text-muted">Test, which is a new approach to have</p>
		            </div>
		            <p class="small text-muted">12:00 PM | Aug 13</p>
		          </div>
		        </div>
		
		        <!-- Reciever Message-->
		        <div class="media w-50 ml-auto mb-3">
		          <div class="media-body">
		            <div class="bg-primary rounded py-2 px-3 mb-2">
		              <p class="text-small mb-0 text-white">Apollo University, Delhi, India Test</p>
		            </div>
		            <p class="small text-muted">12:00 PM | Aug 13</p>
		          </div>
		        </div>
		
		        <!-- Sender Message-->
		        <div class="media w-50 mb-3"><img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
		          <div class="media-body ml-3">
		            <div class="bg-light rounded py-2 px-3 mb-2">
		              <p class="text-small mb-0 text-muted">Test, which is a new approach</p>
		            </div>
		            <p class="small text-muted">12:00 PM | Aug 13</p>
		          </div>
		        </div>
		
		        <!-- Reciever Message-->
		        <div class="media w-50 ml-auto mb-3">
		          <div class="media-body">
		            <div class="bg-primary rounded py-2 px-3 mb-2">
		              <p class="text-small mb-0 text-white">Apollo University, Delhi, India Test</p>
		            </div>
		            <p class="small text-muted">12:00 PM | Aug 13</p>
		          </div>
		        </div>
		
		      </div>
		
		      <!-- Typing area -->
		      <form action="#" class="bg-light">
		        <div class="input-group">
		          <input type="text" id="message" placeholder="Type a message" aria-describedby="button-addon2" class="form-control rounded-0 border-0 py-4 bg-light">
		          <div class="input-group-append">
		            <button id="sendBtn" type="button" class="btn btn-link">전송<i class="far fa-paper-plane"></i></button>
		          </div>
		        </div>
		      </form>
		
		    </div>
		  </div>
		</div>
    </div>
  </div>
</div>
<script>
$("#sendBtn").click(function() {
	let $msg = $("#message").val();
	
	
});
</script>
</body>
</html>