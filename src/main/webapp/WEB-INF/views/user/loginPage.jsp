{{!--
Created by IntelliJ IDEA.
User: yion
Date: 2014. 12. 7.
Time: 16:20
--}}

{{#partial "plugin-style"}}
{{!-- 여기에 .css 파일 경로 --}}
    <link href="/resource/public/css/bootstrap-tag-cloud/bootstrap-tag-cloud.css" rel="stylesheet">
{{/partial}}
{{#partial "script-header"}}
    <script type='text/javascript' src="/resource/public/js/bootstrap-tag-cloud/bootstrap-tag-cloud.js"></script>
{{/partial}}

{{#partial "title"}}ekkor~{{/partial}}

{{# partial "content" }}

    <csrf disabled="true"/>
    <!-- contents -->
    <div class="container">
        <form class="form-horizontal well" style="background-color:#ffffff" role="form" method="post" name="registForm" id="registForm">

            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #428bca">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div class="bootstrap-dialog-title" id="modal-title" style="font-size: 16px;color: #ffffff">Log in</div>
                    </div>

                    <div class="modal-body" style="height: 260px">

                        <form id="loginFormArea" name="loginFormArea" method="post" class="form-horizontal">
                            <div class="row" style="height: 40px">
                                <div class="col-xs-4 text-left">
                                    <span style="color: #428bca;"><a href="#">Forgot password?</a></span>
                                </div>
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                <!--<input type="text" class="form-control" name="loginUserEmail" id="loginUserEmail" placeholder="email address">-->
                                <input type="text" class="form-control" name="loginUserEmail" id="loginUserEmail" size="30">
                            </div>
                            <span class="help-block"></span>

                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                <!--<input type="password" class="form-control" name="loginUserPass" id="loginUserPass" placeholder="Password">-->
                                <input type="password" class="form-control" name="loginUserPass" id="loginUserPass">
                            </div>

                            <span class="help-block" style="color: red; display: none;" id="loginPageInfo">로그인 정보가 올바르지 않습니다. 아이디/비밀번호를 확인하세요.</span>

                            <div style="padding-top:10px;border-top: 1px solid #e5e5e5">
                                <div class="col-xs-4">
                                    <label class="checkbox">

                                    </label>
                                </div>
                                <div class="col-xs-4" >
                                    <button type="button" class="btn btn-primary" id="loginFormBtn">Log in</button>
                                    <button type="button" class="btn btn-default" id="loginFormCancel">Cancel</button>
                                </div>

                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </form>
        <!--/form-->
    </div>

{{/partial}}
{{# partial "script-page" }}
<script type="text/javascript">

    $(document).ready(function () {
        $("#loginFormBtn").click(function() {
            submitLogin();
            payLoginPage();
        });
        $('#userPass').keypress(function(e) {
            if (e.which == 13) { // 13 == enter key ascii
                submitLogin();
            }
        });
        $("#loginFormCancel").click(function() {
            location.href = '/index';
        });
    });


    function submitLogin() {
        userEmail = $("#loginUserEmail").val();
        userPass = $("#loginUserPass").val();
        if (!checkValidEmail(userEmail)) {
            alertEmail();
            return false;
        }

        if (!checkLength(userPass, 4)) {
            alertPass();
            return false;
        }

        //var data = $("#registForm").serialize();

        /*$.post('/user/login/authenticate', data).done(function(response){
            var result = jQuery.parseJSON(response);

            console.log("@ result = " + result);

            if (result.status == true) {
                $(location).attr('href', result.returnUrl);
            }
        }).fail(function(response){
            console.log("# ERROR login : " + response.status);

            $("#loginPageInfo").show(0).delay(5000).hide(0);
        });*/

        jQuery.ajax({
            type:'POST',
            data: { userEmail : userEmail, userPass : userPass },
            url: '/user/login/authenticate',
            success:function(response){
                var result = jQuery.parseJSON(response);
                console.log("## result = " + result);
                if (result.status == true) {
                    $(location).attr('href', "{{returnUrl}}");
                }

            },
            error:function(req){
                console.log("# ERROR login : " + req.status);
                $("#loginPageInfo").show(0).delay(5000).hide(0);
            }});
    }

    function payLoginPage() {
        $.ajax({
            url : 'http://ekkor.ze.am/pay/home/payLogin.do',
            data : {email:$("#loginUserEmail").val(),passwd:$("#loginUserPass").val()},
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

{{> template/base}}
