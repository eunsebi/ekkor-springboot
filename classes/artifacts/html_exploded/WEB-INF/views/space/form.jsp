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
<!-- contents -->
<div class="container-fluid">
    <div class="col-sm-12">
        <section id="forms">

            <div class="page-header">
                <h2>공간 생성하기</h2>
            </div>

            <div class="row" style="width:100%">
                <div style="padding-left:30px">
                    <form name="spaceCreateForm" id="spaceCreateForm" class="form-horizontal well" enctype="multipart/form-data">
                        <fieldset>
                            <legend>공간 제목</legend>
                            <div class="control-group">
                                <div class="controls">
                                    <input type="text" class="form-control input-xlarge" id="title" name="title">
                                </div>
                            </div>
                            <p style="padding-top:20px"></p>
                            <legend>공간 이미지</legend>
                            <div class="control-group">

                                <div class="col-lg-8">
                                    <div class="col-xs-8 col-md-8">
                                        <input id="userId" value="{{user.userId}}" type="hidden">
                                        <input id="uploadType" value="Space" type="hidden">
                                        <input name="titleImagePath" id="titleImagePath" type="hidden">
                                        <input name="titleImage" id="titleImage" type="hidden">
                                        <input id="viewType" name="viewType" value="Image" type="hidden" />
                                        <input id="file-attachment" type="file" name="uploadfile" accept="*" />
                                        <p class="help-block" id="spaceImage">(*) 공간을 표현할 수 있는 대표 이미지를 등록하세요.</p>
                                    </div>
                                </div>

                                <div class="col-lg-4 text-right" id="imagePreviewArea">
                                    <img src="/resource/public/images/icons/pictures.png" width="200" alt="이미지 미리보기" class="img-thumbnail image-preview" id="image-preview">
                                </div>
                            </div>
                            <p style="padding-top:20px"></p>
                            <legend style="margin-bottom: 0px">공간 설명</legend>
                            <div class="control-group">
                                <div class="modal-body">
                                    <div id="editorArea" name="editorArea" class="form-group"></div>
                                    <input type="hidden" id="description" name="description" />
                                    <input type="hidden" id="descriptionMarkup" name="descriptionMarkup" />
                                    <div id="editor" class="form-group"></div>
                                    <p class="help-block">(*) 공간 메인 화면에 입력한 설명이 display 됩니다. (markdown 지원)</p>
                                </div>
                            </div>

                            <legend>공개 여부</legend>
                            <div class="control-group">
                                <div class="controls">
                                    <label class="checkbox-inline">
                                        <input type="radio" name="isPrivateYn" id="memberPublic" value="Y" checked> 공개
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="radio" name="isPrivateYn" id="memberPrivate" value="N" data-toggle="modal" data-target="#selectMemberModal"> 비공개
                                    </label>
                                    <input type="hidden" id="private" name="private" value=""/>
                                </div>
                            </div>
                            <p style="padding-top:20px"></p>
                            <legend>레이아웃</legend>
                            <div class="control-group">

                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="panel panel-info">
                                            <div class="panel-heading"><input type="radio" name="layoutType" id="layoutTypeDefault" value="CENTER" checked> 기본형</div>
                                            <div class="panel-body">
                                                <table class="table table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th colspan="2" class="text-center">
                                                            <div style="margin: 30px"><strong>공간설명</strong></div>
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">
                                                            <div style="margin: 30px"><strong>메뉴목록</strong></div>
                                                        </td>
                                                        <td class="text-center">
                                                            <div style="margin: 30px"><strong>최근위키</strong></div>
                                                        </td>
                                                    </tr>
                                                    </thead>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="panel panel-primary">
                                            <div class="panel-heading"><input type="radio" name="layoutType" id="layoutTypeLeft" value="LEFT"> 좌측 메뉴</div>
                                            <div class="panel-body">
                                                <table class="table table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th rowspan="2" class="text-center" style="width:80px">
                                                            <div style="margin: 30px"><strong>메뉴목록</strong></div>
                                                        </th>
                                                        <th class="text-center">
                                                            <div style="margin: 30px"><strong>공간설명</strong></div>
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">
                                                            <div style="margin: 30px"><strong>최근위키</strong></div>
                                                        </td>
                                                    </tr>
                                                    </thead>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="panel panel-success">
                                            <div class="panel-heading"><input type="radio" name="layoutType" id="layoutTypeRight" value="RIGHT"> 우측 메뉴</div>
                                            <div class="panel-body">
                                                <table class="table table-bordered">
                                                    <thead>
                                                    <tr>
                                                        <th class="text-center">
                                                            <div style="margin: 30px"><strong>공간설명</strong></div>
                                                        </th>
                                                        <th rowspan="2" class="text-center" style="width:80px">
                                                            <div style="margin: 30px"><strong>메뉴목록</strong></div>
                                                        </th>
                                                    </tr>
                                                    <tr>
                                                        <td class="text-center">
                                                            <div style="margin: 30px"><strong>최근위키</strong></div>
                                                        </td>
                                                    </tr>
                                                    </thead>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <p style="padding-top:20px"></p>
                            <legend>키워드 </legend>

                            <div class="control-group">
                                <div class="col-sm-3 col-md-3">
                                    <div id="tag-info" class="form-inline" style="padding-bottom: 10px;width:400px;">
                                        <input type="text" class="form-control" size="29" id="interesting" placeholder="Keyword">
                                        <button class="btn btn-primary" type="button" id="keywordAdd">Add <i class="glyphicon glyphicon-plus"></i></button>

                                    </div>
                                </div>
                                <input type="hidden" name="keywords" id="keywords" />
                                <div class="col-sm-4 col-md-4">
                                    <ul id="tag-cloud" style="padding-left: 0px; width:100%; "></ul>
                                </div>
                            </div>
                        </fieldset>

                        <div class="form-actions text-center">
                            <button type="button" class="btn btn-primary" id="btnSave" name="btnSave">저장</button>
                            <button type="button" class="btn" id="btnCancel" name="btnCancel">취소</button>
                        </div>

                    </form>
                </div>
            </div>

        </section>
    </div>
</div>

<!-- file upload start -->
<div class="modal fade" id="selectMemberModal" tabindex="-1" role="dialog" aria-hidden="true" aria-labelledby="selectMemberModalLabel">
    <div class="modal-dialog" style="overflow-y: initial !important; overflow-y: scroll; max-height:70%;  margin-top: 50px; margin-bottom:30px;">
    <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="selectMemberModalLabel">접근 허용 멤버 선택</h4>
            </div>
            <div class="modal-body" style="height: 350px;overflow-y: auto;">

                <div class="form-group">
                    <table class="table" id="memberListArea">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th style="width:30%">닉네임</th>
                            <th style="width:40%">이메일</th>
                            <th>구분</th>
                        </tr>
                        </thead>
                        <tbody id="allUserList">

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" name="selectMember">선택완료</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- file upload modal end -->

{{/partial}}


{{# partial "script-page" }}
{{embedded "space/template/_userList"}}
<script type="text/javascript">
    // bind the on-change event
    $(document).ready(function() {

        DualEditor.setting({
                              src : '/resource/app'
                            , tarketId : 'editor'
                            , type : 'mini'
                            , width : '100%'
                            , height : '400px;'
        });
        $("#file-attachment").on("change", uploadFile);
    });

    var keywordData = [];

    /**
     * 키워드 추가
     * 키워드가 3건 이상 등록 될 경우 폼을 disabled 한다.
     * 대소문자 중복 허용하지 않는다.
     */
    $('#keywordAdd').click(function () {
        var keyword = $('#interesting').val();

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
    });

    $('#btnSave').on('click', function () {
        $.confirm({
            title: '확인',
            content: '공간을 생성 하겠습니까?',
            confirmButton: '공간생성',
            cancelButton: '취소',
            confirmButtonClass: 'btn-info',
            confirm: function () {
                create();
            },
            cancel: function(){

            }
        });
    });

    $('#memberPrivate').on('click', function () {
        var sort = "";        // Role 선택
        $.ajax({
            type: "get",
            dataType: "json",
            data: { "accessLevel" : ""},
            url: "/space/allUser",
            cache: false,
            success: function (response) {
                console.log("## response = " + response.resultCode);
                console.log("## response = " + response.data);

                if(response.resultCode == 1) {

                    var source = $('#space-template-_userList-hbs').html();
                    var template = Handlebars.compile(source);

                    var html = template(response.data);
                    $('#allUserList').html(html);

                }
            },
            error: function (response) {
                // Handle upload error
                if (req.status == 500) {
                    error500(true, '');
                } else {
                    error500(false, response.status);
                }
            }
        });
    });


    $('#btnCancel').on(function () {
        $.confirm({
            title: '확인',
            content: '공간 생성을 취소하겠습니까?',
            confirmButton: '확인',
            cancelButton: '취소',
            confirm: function () {
                $(location).attr('href', "main");
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

        if (index > -1) {
            keywordData.splice(index, 1);
            $('input[name=keywords]').val(keywordData);
            $("#interesting").attr("readonly", false);
            $("#keywordAdd").attr("disabled", false);
        }
    });

    /**
     * Save the Space
     */
    function create() {
        $("#keywords").val(keywordData);
        $("#description").val(DualEditor.getMarkupConvertToHtml());
        $("#descriptionMarkup").val(DualEditor.getMarkupEditHtml());

        if ($(':radio[name="isPrivateYn"]:checked').val() == 'Y') {
            $("#private").val(0);   // 공개
        } else {
            $("#private").val(1);   // 비공개
        }
        var data = $("#spaceCreateForm").serialize();
        if (checkValidation()) {
            $.ajax({
                type: "post",
                dataType: "json",
                data: data,
                url: "/space/add",
                cache: false,
                success: function (req) {
                    if (req.resultCode == 1) {
                        $.confirm({
                            title: '완료',
                            content: '공간 정보를 저장하였습니다. 공간 메인 화면으로 이동하겠습니까?',
                            confirmButton: '이동',
                            cancelButton: '취소',
                            confirmButtonClass: 'btn-info',
                            icon: 'fa fa-question-circle',
                            animation: 'top',
                            confirm: function () {
                                $(location).attr('href', req.data.spaceId);
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
                content: '공간 정보 저장중 에러가 발생했습니다.',
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
                content: '공간 정보 저장중 에러가 발생했습니다. 에러코드 [' + status + ']',
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
     * Upload the file sending it via Ajax at the Spring Boot server.
     */
    function uploadFile() {
        var field = $("#file-attachment").val();
        if (field != '') {
            $.ajax({
                url: "/common/uploadFile",
                type: "POST",
                data: new FormData($("#spaceCreateForm")[0]),
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                cache: false,
                success: function (req) {
                    console.log('성공 req : ' + req);
                    console.log('성공 req : ' + req.resultCode);
                    if (req.resultCode == 1) {
                        if (req.data.uploadType === 'image') {
                            $("#image-preview").remove();
                            $("#titleImagePath").val("");
                            $("#imagePreviewArea").html("<img src='/imageView?path=" + req.data.filePath + "/" + req.data.savedName + "' width=\"200\" class=\"img-thumbnail image-preview\" id=\"image-preview\">");
                            $("#titleImagePath").val(req.data.filePath);
                            $("#titleImage").val(req.data.savedName);
                        }
                    } else {
                        $.alert({
                            title: '정보',
                            confirmButton: '확인',
                            content: req.comment
                        });
                        $("#file-attachment").val('');
                    }
                },
                error: function (req) {
                // Handle upload error

                    console.log('req status: ' + req.status);
                    console.log('req ready : ' + req.readyState);

                    $.alert({
                        title: '에러',
                        confirmButton: '확인',
                        icon: 'fa fa-info',
                        content: '[' + req.status + '] 업로드 중 에러가 발생했습니다. 파일 용량이 허용범위를 초과 했거나 올바르지 않은 파일 입니다.'
                    });
                    $("#file-attachment").val('');

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
        var title = $("#title").val();
        var imagePath = $("#titleImagePath").val();
        var description = $("#wikiEditor").val();


        if (userId == null || userId.length == 0) {
            $.alert({
                title: '정보',
                confirmButton: '확인',
                content: '로그인 정보가 존재 하지 않습니다.'
            });
            return false;
        }
        if (title == null || title.length == 0) {
            $.alert({
                title: '정보',
                confirmButton: '확인',
                icon: 'fa fa-info',
                content: '공간 제목을 입력하세요.'
            });
            return false;
        }
        if (imagePath == null || imagePath.length == 0) {
            $.alert({
                title: '정보',
                confirmButton: '확인',
                icon: 'fa fa-info',
                content: '공간의 이미지 정보는 필수값입니다.'
            });
            return false;
        }
        if (description == null || description.length == 0) {
            $.alert({
                title: '정보',
                confirmButton: '확인',
                icon: 'fa fa-info',
                content: '공간 설명은 필수값입니다.'
            });
            return false;
        }
        return true;
    }
</script>
{{/partial}}

{{> template/base}}
