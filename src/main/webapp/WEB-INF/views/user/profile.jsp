{{!--
Created by IntelliJ IDEA.
User: yion
Date: 2014. 12. 7.
Time: 16:20
To change this template use File | Settings | File Templates.
--}}
{{#partial "style"}}
{{!-- 여기에 사용자 css 정의 --}}
    <link href="/resource/app/js/DualEditor/css/DualEditor.css" rel="stylesheet">
{{/partial}}

{{#partial "plugin-style"}}
{{!-- 여기에 .css 파일 경로 --}}
    <link href="/resource/public/css/bootstrap-tag-cloud/bootstrap-tag-cloud.css" rel="stylesheet">
{{/partial}}
{{#partial "script-header"}}
    <script src="/resource/app/js/DualEditor/DualEditor-core.js"></script>
    <script type='text/javascript' src="/resource/public/js/bootstrap-tag-cloud/bootstrap-tag-cloud.js"></script>
{{/partial}}

{{#partial "title"}}ekkor~{{/partial}}

{{# partial "content" }}
    <section id="forms">
    <div class="container">
        <h3 class="page-header">회원 정보 수정</h3>
        <!-- form start -->
        <form name="userProfileForm" id="userProfileForm" class="form-horizontal well" role="form" method="post">

            <div class="form-group">
                <label for="inputEmail" class="col-sm-2 control-label">이메일</label>

                <div class="col-sm-5 col-md-5">
                    <input type="text" class="form-control" id="userEmail" name="userEmail" placeholder="Email" value="{{userEmail}}" disabled/>
                </div>
            </div>
            <div class="form-group">
                <label for="visit" class="col-sm-2 control-label">방문수</label>

                <div class="col-sm-5 col-md-5">
                    <input type="text" class="form-control" id="visitCount" value="{{user.visitCount}}" disabled/>
                </div>
            </div>
            <div class="form-group">
                <label for="visit" class="col-sm-2 control-label">포인트</label>

                <div class="col-sm-5 col-md-5">
                    <input type="text" class="form-control" id="userTotalPoint" value="{{user.userTotalPoint}}" disabled/>
                </div>
            </div>
            <div class="form-group">
                <label for="visit" class="col-sm-2 control-label">가입일</label>

                <div class="col-sm-5 col-md-5">
                    <input type="email" class="form-control" id="insertDate" value="{{formatDate user.insertDate "yyyy/MM/dd HH:MM:ss"}}" disabled/>
                </div>
            </div>
            <div class="form-group">
                <label for="visit" class="col-sm-2 control-label">최종방문일</label>

                <div class="col-sm-5 col-md-5">
                    <input type="email" class="form-control" id="lastVisiteDate" value="{{formatDate user.lastVisiteDate "yyyy/MM/dd HH:MM:ss"}}" disabled/>
                </div>
            </div>
            <div class="form-group">
                <label for="nickname" class="col-sm-2 control-label">닉네임</label>

                <div class="col-sm-5 col-md-5">
                    <div id="tag-info" class="form-inline">
                    <input type="text" class="form-control" name="userNick" id="userNick" value="{{user.userNick}}"/>
                        <a class="btn btn-warning" id="checkUserNick"><i class="fa fa-check"></i> 중복확인</a>
                    </div>
                </div>
                <div class="col-sm-5 col-md-5">
                    <label id="dupNick" class="control-label error-label hide">닉네임을 입력해주세요.</label>
                </div>
            </div>


            <div class="form-group">
                <label for="homepage" class="col-sm-2 control-label">홈페이지</label>

                <div class="col-sm-5 col-md-5">
                    <input type="text" class="form-control" name="userSite" id="userSite" placeholder="Homepage" value="{{user.userSite}}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="profile_image" class="col-sm-2 control-label">이미지</label>
                <div class="col-sm-1 col-md-1">
                    <div class="user-profile" id="imagePreviewArea" div-data="{{user.userThumbnailImagePath}}/{{user.userThumbnailImageName}}">
                        <img alt="avatar" class="profile-image" width="64" src="/imageView?path={{user.userThumbnailImagePath}}/{{user.userThumbnailImageName}}" onerror='this.src="/resource/images/avatar.png"' id="image-preview" />
                    </div>
                </div>
                <div class="col-sm-5 col-md-5">
                    <input name="checkDupNickname" id="checkDupNickname" value="" type="hidden">
                    <input name="checkImageUpload" id="checkImageUpload" value="" type="hidden">
                    <input name="userId" id="userId" value="{{user.userId}}" type="hidden">
                    <input id="uploadType" value="User" type="hidden">
                    <input id="thumbNail" type="hidden">
                    <input name="userImagePath" id="userImagePath" type="hidden">
                    <input name="userImageName" id="userImageName" type="hidden">
                    <input name="userThumbnailImageName" id="userThumbnailImageName" type="hidden">
                    <input name="userThumbnailImagePath" id="userThumbnailImagePath" type="hidden">
                    <input id="viewType" name="viewType" value="Image" type="hidden" />
                    <input id="file-attachment" type="file" name="uploadfile" accept="*" />
                </div>
            </div>

            <div class="form-group">
                <label for="interesting" class="col-sm-2 control-label">관심 분야</label>
                <div class="control-group">
                    <div class="col-sm-4 col-md-4">
                        <div id="tag" class="form-inline" style="padding-bottom: 10px;width:400px;">
                            <input type="text" class="form-control" size="29" id="interesting" placeholder="Keyword">
                            <button class="btn btn-primary" type="button" id="keywordAdd">Add <i class="glyphicon glyphicon-plus"></i></button>

                        </div>
                    </div>
                    <input type="hidden" name="keywords" id="keywords" />
                    <div class="col-sm-4 col-md-4">
                        <ul id="tag-cloud" style="padding-left: 0px; width:100%; ">
                            {{#if userKeywordList}}
                                {{#each userKeywordList}}
                                    <li class="tag-cloud">{{keywordName}}</li>
                                {{/each}}
                            {{^}}

                            {{/if}}
                        </ul>
                    </div>
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
    </section>

{{/partial}}


{{# partial "script-page" }}
    <script type="text/javascript">
    // bind the on-change event
    var keywordData = [];

    $(document).ready(function() {
        $("#file-attachment").on("change", uploadFile);
        var tagLength = $('.tag-cloud').length;

        for (var i = 0; i < tagLength; i++) {
            console.log("## $('.tag-cloud').eq(i) = " + $('.tag-cloud').eq(i).text());
            keywordData.push($('.tag-cloud').eq(i).text());
        }
        if (tagLength == 3) {
            $("#interesting").attr("readonly", true);
            $("#keywordAdd").attr("disabled", true);
        }

    });

    $("#checkUserNick").click(function () {
        var userNick = $("#userNick").val();

        $.ajax({
            type: "post",
            dataType: "json",
            data: { userNick : userNick},
            url: "/user/checkDupNick",
            cache: false,
            success: function (req) {
                if (req == '1') {
                    $.alert({
                        title: '확인',
                        content: '사용할 수 있는 닉네임 입니다.',
                        confirmButton: 'OK',
                        confirmButtonClass: 'btn-primary',
                        icon: 'fa fa-info',
                        animation: 'zoom',
                        confirm: function () {
                        }
                    });
                    $("#checkDupNickname").val("Y");
                } else {
                    $("#checkDupNickname").val("N");
                    $.alert({
                        title: '확인',
                        content: '중복된 닉네임입니다. 다른 닉네임을 선택하세요.',
                        confirmButton: 'OK',
                        confirmButtonClass: 'btn-primary',
                        icon: 'fa fa-info',
                        animation: 'zoom',
                        confirm: function () {
                        }
                    });
                }
            },
            error: function (req) {
                $("#checkDupNickname").val("N");
                $.alert({
                    title: '확인',
                    content: '닉네임 중복 확인중 에러가 발생했습니다. 다시 시도하세요.',
                    confirmButton: 'OK',
                    confirmButtonClass: 'btn-primary',
                    icon: 'fa fa-info',
                    animation: 'zoom',
                    confirm: function () {
                    }
                });
            }
        });
    });



    $("#interesting").keyup(function (e) {

        if (e.keyCode == 13) {
            var tagLength = $('.tag-cloud').length;
            console.log("- tagLength :" + tagLength);
            if (tagLength == 3) {
                $.alert({
                    title: 'Error',
                    confirmButton: '확인',
                    content: '관심분야 키워드는 3건 이상 등록할 수 없습니다.'
                });
            } else {
                addUserKeyword();
            }
        }
    });

    $('#keywordAdd').on("click", function () {
        addUserKeyword();
    });

    /**
     * 키워드 추가
     * 키워드가 3건 이상 등록 될 경우 폼을 disabled 한다.
     * 대소문자 중복 허용하지 않는다.
     */
    function addUserKeyword() {
        var keyword = $('#interesting').val();

        console.log("addkey =" + keyword);

        if (keywordData.length == 3) {
            $.alert({
                title: '확인',
                content: '키워드는 최대 3건만 등록할 수 있습니다.',
                confirmButton: 'OK',
                confirmButtonClass: 'btn-primary',
                icon: 'fa fa-info',
                animation: 'zoom',
                confirm: function () {

                }
            });
        }

        keywordData.push(keyword);

        var taskArray = [];
        $("input[name=keywords]").each(function () {
            taskArray.push(keyword);
        });

        if (keywordData.length > 2) {
            $("#interesting").attr("readonly", true);
            $("#keywordAdd").attr("disabled", true);
        }
    }

    $('#btnSave').on('click', function () {
        $.confirm({
            title: '확인',
            content: '프로필을 수정하겠습니까?',
            confirmButton: '프로필 수정',
            cancelButton: '취소',
            confirmButtonClass: 'btn-info',
            confirm: function () {
                updateProfile();
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

    /**
     * 키워드 삭제
     * 키워드가 삭제되면 폼을 enabled 한다.
     */
    $('#tag-cloud').on('click', 'li', function (event) {

        var keyword = $(event.target).text();
        var index = keywordData.indexOf(keyword);

        console.log("# 태그 keyword : " + keyword);
        console.log("# 태그 index : " + index);


        if (index > -1) {
            keywordData.splice(index, 1);
            $('input[name=keywords]').val(keywordData);
            $("#interesting").attr("readonly", false);
            $("#keywordAdd").attr("disabled", false);
        }
    });

    /**
     * Save the updateProfile
     */
    function updateProfile() {
        var nickChange = $("#checkDupNickname").val();

        if (nickChange == "N") {
            $.alert({
                title: '확인',
                content: '닉네임 중복 검사가 제대로 되지 않았습니다. 닉네임 변경시 중복검사를 실행해주세요.',
                confirmButton: 'OK',
                confirmButtonClass: 'btn-primary',
                icon: 'fa fa-info',
                animation: 'zoom',
                confirm: function () {
                }
            });
            return;
        }

        $("#keywords").val(keywordData);

        var data = $("#userProfileForm").serialize();
        if (checkValidation()) {
            $.ajax({
                type: "post",
                dataType: "json",
                data: data,
                url: "/user/updateProfile",
                cache: false,
                success: function (req) {
                    if (req.resultCode == 1) {
                        $.alert({
                            title: '확인',
                            content: '프로필 정보가 수정 되었습니다.',
                            confirmButton: 'OK',
                            confirmButtonClass: 'btn-primary',
                            icon: 'fa fa-info',
                            animation: 'zoom',
                            confirm: function () {
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

    function error500(condition, status) {
        if (condition) {
            $.alert({
                title: '확인',
                content: '프로필 수정 중 에러가 발생했습니다.',
                confirmButton: 'OK',
                confirmButtonClass: 'btn-primary',
                icon: 'fa fa-info',
                animation: 'zoom',
                confirm: function () {
                }
            });
        } else {
            $.alert({
                title: '확인',
                content: '프로필 수정 중 에러가 발생했습니다. 에러코드 [' + status + ']',
                confirmButton: 'OK',
                confirmButtonClass: 'btn-primary',
                icon: 'fa fa-info',
                animation: 'zoom',
                confirm: function () {
                }
            });
        }
    }
    /**
     * 이미지 파일 임시 저장
     * Upload the file sending it via Ajax at the Spring Boot server.
     */
    function uploadFile() {
        var field = $("#file-attachment").val();
        $("#checkImageUpload").val("Y");
        if (field != '') {
            $.ajax({
                url: "/common/userProfileImage",
                type: "POST",
                data: new FormData($("#userProfileForm")[0]),
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: function (req) {
                    console.log('req : ' + req);
                    console.log('req.data.uploadType : ' + req.data.uploadType);
                    if (req.resultCode == 1) {
                        if (req.data.uploadType === 'image') {
                            $("#image-preview").remove();
                            $("#userImagePath").val("");
                            $("#imagePreviewArea").html("<img src='/imageView?path=" + req.data.filePath + "/" + req.data.savedName + "' width=\"64\" class=\"profile-image image-preview\" id=\"image-preview\">");
                            $("#userImagePath").val(req.data.filePath);
                            $("#userImageName").val(req.data.savedName);
                            $("#userThumbnailImageName").val(req.data.thumbName);
                            $("#userThumbnailImagePath").val(req.data.thumbPath);
                            $("#thumbNail").val("Y");
                        }
                    }
                },
                error: function (req) {
                    // Handle upload error
                    console.log('req : ' + req.status);
                    console.log('req : ' + req.readyState);

                    if (req.status == 500) {
                        $.alert({
                            title: 'Error',
                            confirmButton: '확인',
                            content: '업로드 중 에러가 발생했습니다. 파일 용량이 허용범위를 초과 했거나 올바르지 않은 파일 입니다.'
                        });
                    } else {
                        $.alert({
                            title: 'Error',
                            confirmButton: '확인',
                            content: '에러가 발생하였습니다. 에러코드 [' + req.status + ']'
                        });
                    }

                }
            });
        }
    } // function uploadFile
    /**
     * Form value 검증
     */
    function checkValidation() {
        // 에러가 발생할 경우 false 를 리턴한다.
        var userId = $("#userId").val();

        if (userId == null || userId.length == 0) {
            $.alert({
                title: '정보',
                confirmButton: '확인',
                content: '로그인 정보가 존재 하지 않습니다.'
            });
            return false;
        }

        return true;
    }


    </script>
{{/partial}}

{{> template/base}}
