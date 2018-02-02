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

    <!--<csrf disabled="true"/>-->
    <!-- contents -->
    <div class="container">

        <h3 class="page-header">회원 가입 {{info}}</h3>
        <!-- form start -->


        <form  role="form" method="post" name="registForm" id="registForm">
            <input type="hidden" name="loginType" id="loginType"/>
            <input type="hidden" name="cToken" id="cToken" value="Y"/>
            <input type="hidden" name="emailCheck" id="emailCheck" value="N"/>
            <input type="hidden" name="nickCheck" id="nickCheck" value="N"/>
            <input type="hidden" name="targetUrl" id="targetUrl" value="{{returnUrl}}"/>
            <div class="omb_login">
                <!--
                Social login 은 추후 지원한다.
                <h3 class="omb_authTitle"><a href="#">Sign up with</a></h3>
                <div class="row omb_row-sm-offset-3 omb_socialButtons">
                    <div class="col-xs-4 col-sm-2">
                        <a href="#" class="btn btn-lg btn-block omb_btn-facebook">
                            <i class="fa fa-facebook visible-xs"></i>
                            <span class="hidden-xs">Facebook</span>
                        </a>
                    </div>
                    <div class="col-xs-4 col-sm-2">
                        <a href="#" class="btn btn-lg btn-block omb_btn-twitter">
                            <i class="fa fa-twitter visible-xs"></i>
                            <span class="hidden-xs">Twitter</span>
                        </a>
                    </div>
                    <div class="col-xs-4 col-sm-2">
                        <a href="#" class="btn btn-lg btn-block omb_btn-google">
                            <i class="fa fa-google-plus visible-xs"></i>
                            <span class="hidden-xs">Google+</span>
                        </a>
                    </div>
                </div>

                <div class="row omb_row-sm-offset-3 omb_loginOr">
                    <div class="col-xs-12 col-sm-6">
                        <hr class="omb_hrOr">
                        <span class="omb_spanOr">or</span>
                    </div>
                </div>


                    <div class="col-xs-12 col-sm-6">
                        <span class="fa-stack fa-lg">
                          <i class="fa fa-square-o fa-stack-2x"></i>
                          <i class="fa fa-twitter fa-stack-1x"></i>
                        </span>

                        <span class="fa-stack fa-lg">
                          <i class="fa fa-square-o fa-stack-2x"></i>
                          <i class="fa fa-facebook fa-stack-1x"></i>
                        </span>

                        <span class="fa-stack fa-lg">
                          <i class="fa fa-square-o fa-stack-2x"></i>
                          <i class="fa fa-github fa-stack-1x"></i>
                        </span>

                        <span class="fa-stack fa-lg">
                          <i class="fa fa-square-o fa-stack-2x"></i>
                          <i class="fa fa-instagram fa-stack-1x"></i>
                        </span>
                    </div>
                -->


                <div class="row omb_row-sm-offset-3">
                    <div class="col-xs-12 col-sm-6">

                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-user" style="width:14px"></i></span>
                            <!--<input type="text" class="form-control" name="loginUserMail" id="loginUserMail" placeholder="Email address">-->
                            <input type="text" class="form-control" name="loginUserMail" id="loginUserMail" placeholder="Email address">
                        </div>
                        <span class="help-block"></span>

                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-pencil-square-o"></i></span>
                            <input type="text" class="form-control" name="loginUserNick" id="loginUserNick" placeholder="User Nickname">
                        </div>
                        <span class="help-block"></span>

                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-lock" style="width:14px"></i></span>
                            <input  type="password" class="form-control" name="loginUserPass" id="loginUserPass" placeholder="Password">
                        </div>
                        <span class="help-block" id="helpInfo" style="display: none;"></span>
                        <span class="help-block"></span>
                        <button class="btn btn-lg btn-primary btn-block" type="button" id="signUser">Sign up</button>
                    </div>
                </div>
                <div class="row omb_row-sm-offset-3">
                    <div class="col-xs-12 col-sm-3">
                        <label class="checkbox">

                        </label>
                    </div>
                    <div class="col-xs-12 col-sm-3">
                        <p class="omb_forgotPwd">
                            <a href="#" data-toggle="modal" data-target="#loginLayer">이미 가입 되어 있습니까?</a>
                        </p>
                    </div>
                </div>
            </div>

        </form>
        <!--/form-->
    </div>

{{/partial}}
{{# partial "script-page" }}
    <script type="text/javascript">
        // bind the on-change event
        $(document).ready(function() {


            $('#loginUserMail').focusout(function(){
                var userEmail = $("#loginUserMail").val();
                $.post('/user/checkEmail', { userEmail: userEmail })
                        .done(function (data) {
                            console.log("## data = " + data);
                            if (data == "1") {
                                $("#emailCheck").val("Y");
                            } else if (data == "0") {
                                $("#emailCheck").val("N");

                                $("#helpInfo").html("");
                                $("#helpInfo").html("메일 주소가 이미 존재합니다. 다른 메일 주소로 가입해주세요.");
                                for(i=0;i<2;i++) {
                                    $("#helpInfo").fadeTo('slow', 0.5).fadeTo('slow', 1.5);
                                }
                                $("#helpInfo").hide(0);
                                setTimeout(function() {
                                    $("#loginUserMail").val('');
                                    $("#loginUserMail").focus();
                                }, 2500);

                            }
                        }).fail(function () {
                    $("#emailCheck").val("N");
                    $.alert({
                        title: '확인',
                        content: '이메일 중복 조회중 에러가 발생하였습니다. 다시 시도하세요.',
                        confirmButton: 'OK',
                        confirmButtonClass: 'btn-primary',
                        icon: 'fa fa-info',
                        animation: 'zoom',
                        confirm: function () {
                        }
                    });
                });
            });

            $('#loginUserNick').focusout(function(){
                var userNick = $("#loginUserNick").val();
                $.post('/user/checkDupNick', { userNick: userNick })
                        .done(function (data) {
                            console.log("## data = " + data);
                            if (data == "1") {
                                $("#nickCheck").val("Y");
                            } else if (data == "0") {
                                $("#nickCheck").val("N");

                                $("#helpInfo").html("");
                                $("#helpInfo").html("닉네임이 이미 존재합니다. 다른 닉네임으로 가입해주세요.");
                                for(i=0;i<2;i++) {
                                    $("#helpInfo").fadeTo('slow', 0.5).fadeTo('slow', 1.5);
                                }
                                $("#helpInfo").hide(0);
                                setTimeout(function() {
                                    $("#loginUserNick").val('');
                                    $("#loginUserNick").focus();
                                }, 2500);
                            }
                        }).fail(function () {
                    $("#emailCheck").val("N");
                    $.alert({
                        title: '확인',
                        content: '닉네임 중복 조회중 에러가 발생하였습니다. 다시 시도하세요.',
                        confirmButton: 'OK',
                        confirmButtonClass: 'btn-primary',
                        icon: 'fa fa-info',
                        animation: 'zoom',
                        confirm: function () {
                        }
                    });
                });
            });


            $("#signUser").click(function() {
                var userEmail = $("#loginUserMail").val();
                var userNick = $("#loginUserNick").val();
                var userPass = $("#loginUserPass").val();

                console.log('userEmail=' + userEmail);
                console.log('userNick=' + userNick);
                console.log('userPass=' + userPass);
                /*if (!checkValidEmail(userEmail)) {
                    alertEmail();
                    return false;
                }*/

                if (!checkValidName(userNick)) {
                    alertName();
                    return false;
                }

                if (!checkLength(userPass, 4)) {
                    alertPass();
                    return false;
                }

                createUser();
            });
        });


        function createUser() {
            var userEmail = $("#loginUserMail").val();
            var userNick = $("#loginUserNick").val();
            var data = $("#registForm").serialize();
            $.confirm({
                title: '가입확인',
                content: 'Login ID : ' + userEmail + " <BR>닉네임 : " + userNick +"<BR>현재 정보로 가입하시겠습니까?",
                confirmButton: '가입',
                cancelButton: '취소',
                confirmButtonClass: 'btn-info',
                icon: 'fa fa-question-circle',
                animation: 'top',
                confirm: function () {
                    $.ajax({
                        type: "post",
                        dataType: "json",
                        data: data,
                        url: "/user/createUser",
                        cache: false,
                        success: function (req) {
                            if (req.resultCode == 1) {
                                $.confirm({
                                    title: '완료',
                                    content: '회원가입 완료! 로그인 후 이용 가능합니다.' ,
                                    confirmButton: '확인',
                                    cancelButton: '취소',
                                    confirmButtonClass: 'btn-info',
                                    icon: 'fa fa-question-circle',
                                    animation: 'top',
                                    confirm: function () {
                                        $(location).attr('href', req.data.targetUrl);
                                    }
                                });
                            }
                        },
                        error: function (req) {
                            // Handle upload error
                            console.log("#req = " + req.status);
                            $.alert({
                                title: '에러',
                                content: '회원 가입시 에러가 발생했습니다. 다시 시도 하세요.',
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                }
                            });

                        }
                    });
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
         * 닉네임 확인
         */
        function alertName(){
            $.alert({
                title: '확인',
                content: '닉네임은 글 작성자를 표시하는 것으로 최소 2자 이상 필수값입니다.',
                confirmButton: 'OK',
                confirmButtonClass: 'btn-primary',
                icon: 'fa fa-info',
                animation: 'zoom',
                confirm: function () {
                }
            });
        }
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

        function checkValidName(name) {
            if (name.length < 2) {
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