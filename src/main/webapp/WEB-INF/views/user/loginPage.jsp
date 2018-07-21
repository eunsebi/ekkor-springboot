{{# partial "header" }}
<!--<csrf disabled="true"/>-->
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header" style="background-color: #428bca">

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <div class="bootstrap-dialog-title" id="modal-title" style="font-size: 16px;color: #ffffff">Log in</div>
            </div>

            <div class="modal-body" style="height: 260px">

                <form id="loginForm" name="loginForm" method="post" class="form-horizontal">
                    <div class="row" style="height: 40px">
                        <div class="col-xs-4 text-left">
                            <span style="color: #428bca;"><a href="#">Forgot password?</a></span>
                        </div>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                        <input type="text" class="form-control" name="userEmail" id="userEmail" placeholder="email address">
                    </div>
                    <span class="help-block"></span>

                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                        <input type="password" class="form-control" name="userPass" id="userPass" placeholder="Password">
                    </div>

                    <span class="help-block" style="color: red; display: none" id="loginInfo">로그인 정보가 올바르지 않습니다. 아이디/비밀번호를 확인하세요.</span>

                    <div style="padding-top:10px;border-top: 1px solid #e5e5e5">
                        <div class="col-xs-4">
                            <label class="checkbox">
                                <input type="checkbox" id="remember-me" name="remember-me" value="Y">Save ID
                            </label>
                        </div>
                        <div class="col-xs-4" >
                            <button type="button" class="btn btn-primary" id="loginBtn">Log in</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>

                    </div>

                </form>
            </div>
        </div>
    </div>
<!-- Place this tag right after the last button or just before your close body tag. -->
<script async defer id="github-bjs" src="https://buttons.github.io/buttons.js"></script>

{{/partial}}

{{# partial "footer" }}
<footer id="footer">
    <div class="container">
        <div class="col-md-12 text-center">
            <ul class="list-inline">
                <li>사이트 소개</li>
                <li>Wiki 다운로드</li>
                <li>Contact Us</li>
                <li>Home</li>
            </ul>
        </div>
        <div class="col-md-12 text-center">
            <p class="">
                Copyright © 2016 ekkor™
            </p>
        </div>
    </div>
</footer>
{{/partial}}

{{# partial "script-body" }}
<script type="text/javascript">
    // bind the on-change event
    $(document).ready(function () {
        $("#loginBtn").click(function() {
            submitLogin();
            payLogin();
        });

        $('#userPass').keypress(function(e) {
            if (e.which == 13) { // 13 == enter key ascii
                submitLogin();
            }
        });
        $("#payLoginBtn").click(function() {
            payLogin();
        });

        $("#btnLogOut").click(function() {
            logOut();
        });

    });

    function logOut() {
        $.post("http://ekkor.ze.am/logoutUser",
            function () {
                location.href = getContextPath()+"/";
            }
        );
        $.get("http://ekkor.ze.am/pay/user/logout.do");
    }

    function payLogin() {
        userEmail = $("#userEmail").val();
        userPass = $("#userPass").val();
        $.ajax({
            url : 'http://ekkor.ze.am/pay/home/payLogin.do',
            data : {email:userEmail,passwd:userPass},
            type : 'post',
            success:function(response){
                var result = JSON.parse(response);
                /*if(result.isLogin){
                        location.href = 'http://ekkor.ze.am/pay/home/main.do';
                }else{
                        alert(result.msg);
                }*/
            },
            error:function(response){
                console.log(response);
            }
        });
    }

    function test1(){
        var div1 = $("#mainContent").children(".row").children(":first");
        var div2 = $("#mainContent").children(".row").children(":last");
        if( div2.css("display") == "none" ){
            div2.show();
            div1.toggleClass("col-md-12 col-md-9");
        }else{
            div2.hide();
            div1.toggleClass("col-md-9 col-md-12");
        }
    }

    function submitLogin() {
        userEmail = $("#userEmail").val();
        userPass = $("#userPass").val();
        /*if (!checkValidEmail(userEmail)) {
            alertEmail();
            return false;
        }*/

        if (!checkLength(userPass, 4)) {
            alertPass();
            return false;
        }

        var data = $("#loginForm").serialize();
        $.post('/user/login/authenticate', data).done(function(response){
            var result = jQuery.parseJSON(response);

            console.log("@ result = " + result);

            if (result.status == true) {
                $(location).attr('href', result.returnUrl);
            }
        }).fail(function(response){
            console.log("# ERROR login : " + response.status);

            $("#loginInfo").show(0).delay(5000).hide(0);
        });
    }

    /**
     * 이메일 입력 확인
     */
    function alertEmail(){
        $.alert({
            title: '확인',
            content: '이메일 주소를 확인하세요.',
            confirmButton: 'OK',
            confirmButtonClass: 'btn-primary',
            icon: 'fa fa-info',
            animation: 'zoom',
            confirm: function () {
            }
        });
    }
    /**
     * 패스워드 확인
     */
    function alertPass(){
        $.alert({
            title: '확인',
            content: '비밀번호는 최소 4자 이상으로 필수값입니다.',
            confirmButton: 'OK',
            confirmButtonClass: 'btn-primary',
            icon: 'fa fa-info',
            animation: 'zoom',
            confirm: function () {
            }
        });
    }

    function checkValidEmail(email) {
        if (email.length < 4) {
            return false;
        }
        var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (!regExp.test(email)) {
            return false;
        } else {
            // Ajax로 중복 검사
            return true;
        }
    }

    function checkLength(value, length) {
        if (value.length < length) {
            return false;
        } else {
            return true;
        }
    }
</script>
{{/partial}}

{{> template/layout}}
