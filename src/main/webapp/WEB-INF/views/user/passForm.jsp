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

        <h3 class="page-header">비밀번호 변경 {{info}}</h3>
        <!-- form start -->


        <form name="passwdForm" id="passwdForm" class="form-horizontal well" role="form" method="post">
            <div class="form-group">
                <label for="inputEmail" class="col-sm-2 control-label">신규 비밀번호</label>

                <div class="col-sm-5 col-md-5">
                    <input type="password" class="form-control" id="newUserPass" name="newUserPass" placeholder="Password">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-5 col-md-5">
                    <input name="userId" id="userId" value="{{user.userId}}" type="hidden">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-12 text-center">
                    <button type="button" class="btn btn-info" id="btnSave">저장</button>
                    <button type="button" class="btn btn-default" id="btnCancel">메인으로</button>
                </div>
            </div>

        </form>
        <!--/form-->
    </div>

{{/partial}}
{{# partial "script-page" }}
    <script type="text/javascript">
        // bind the on-change event

        $('#btnSave').on('click', function () {
            $.confirm({
                title: '확인',
                content: '비밀번호를 수정하겠습니까?',
                confirmButton: '비밀번호 수정',
                cancelButton: '취소',
                confirmButtonClass: 'btn-info',
                confirm: function () {
                    updatePasswd();
                },
                cancel: function(){

                }
            });
        });

        $('#btnCancel').on('click', function () {
            $.confirm({
                title: '확인',
                content: '메인 화면으로 이동합니다. ',
                confirmButton: '확인',
                cancelButton: '취소',
                confirm: function () {
                    $(location).attr('href', "/index");
                }
            });
        });

        function updatePasswd() {
            var userPass = $("#newUserPass").val();
            var data = $("#passwdForm").serialize();
            if (checkValidation()) {
                $.ajax({
                    type: "post",
                    dataType: "json",
                    data: data,
                    url: "/user/updaePasswd",
                    cache: false,
                    success: function (req) {
                        if (req.resultCode == 1) {
                            $.alert({
                                title: '확인',
                                content: '비밀번호가 수정 되었습니다.',
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                    $(location).attr('href', "/index");
                                }
                            });
                        }
                    },
                    error: function (req) {
                        // Handle upload error
                        if (req.status == 500) {
                            error500(true, '');
                        } else {
                            error500(false, req.status);
                        }
                    }
                });
            }
        }

        /**
         * Form value 검증
         */
        function checkValidation() {
            // 에러가 발생할 경우 false 를 리턴한다.
            var userPass = $("#newUserPass").val();

            if (userPass == null || userPass.length == 0) {
                $.alert({
                    title: '정보',
                    confirmButton: '확인',
                    content: '비밀번호 정보가 존재 하지 않습니다.'
                });
                return false;
            }

            return true;
        }

    </script>
{{/partial}}

{{> template/base}}