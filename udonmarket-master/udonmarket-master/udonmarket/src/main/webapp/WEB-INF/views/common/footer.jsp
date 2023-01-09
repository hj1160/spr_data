<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<script type="text/javascript"
    	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>

<script>
var sock = null;

$(function(){
	connectWS();
});

function connectWS(){
	
	var host = "localhost:9090";

    sock = new SockJS("http://" + host + '${pageContext.request.contextPath}/webSocket');
    sock.onmessage = onMessage;
    sock.onclose = onClose;
    
    // 서버로부터 메시지를 받았을 때
    function onMessage(msg) {

        let myId = "${userId}";

    	console.log("메세지를 받았습니다");
        //채팅
        //console.log(typeof msg.data);
        //console.log((msg.data).includes('sendMsg'));
         if((msg.data).includes('sendMsg')){

        		let msgArr = (msg.data).split("@");
        		
				if(msgArr[0] == $("#sendBtn").val()){     	
					    	 
					$("#chatBox").prepend(msgArr[1]);       	 
				}
				
            // $("#chatBox").append(msg.data);	

		 //알림
        }else{
        	let $socketAlert = $("#socketAlert");
	        $socketAlert.html(msg.data);
	        $socketAlert.css('display', 'block');
	
	        //알림 유지 시간 (5초)
	        setTimeout( function(){
	        	$socketAlert.css('display', 'none');
	        }, 5000);      

        }
    }
    
    // 서버와 연결을 끊었을 때
    function onClose(evt) {
        console.log("연결 끊김");
    }
    
}
</script>
    
    
    <!--::footer_part start::-->
    <footer class="footer_part">
        <div class="copyright_part">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="copyright_text">
                            <P><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved <i class="ti-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">UdonMarket Inc</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></P>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!--::footer_part end::-->

    <!-- jquery plugins here-->
    <script src="${pageContext.request.contextPath }/resources/js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="${pageContext.request.contextPath }/resources/js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
    <!-- easing js -->
    <script src="${pageContext.request.contextPath }/resources/js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
  	<script src="${pageContext.request.contextPath }/resources/js/lightslider.min.js"></script>
    <!-- swiper js -->
    <script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
    <!-- swiper js -->
    <script src="${pageContext.request.contextPath }/resources/js/masonry.pkgd.js"></script>
    <!-- particles js -->
    <script src="${pageContext.request.contextPath }/resources/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.nice-select.min.js"></script>
    <!-- slick js -->
    <script src="${pageContext.request.contextPath }/resources/js/slick.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.counterup.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/contact.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.ajaxchimp.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/mail-script.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/stellar.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/price_rangs.js"></script>
    <!-- custom js -->
    <script src="${pageContext.request.contextPath }/resources/js/theme.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/custom.js"></script>
</body>

</html>