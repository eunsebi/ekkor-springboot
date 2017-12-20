<!--
  Created by IntelliJ IDEA.
  User: yong
  Date: 2014. 9. 22.
  Time: 오후 10:57
-->

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

{{#partial "title"}}Alpaka~{{/partial}}

{{# partial "content" }}
    <div class="container">
        <section id="forms">

            <fieldset>
                <div class="page-header">
                    <h2>질문하기</h2>
                </div>
                <div class="row" style="width:100%">
                    <div style="padding-left:30px">
                        <form id="qaForm" name="qaForm" class="form-horizontal well" enctype="multipart/form-data">
                            <legend>제목</legend>
                            <input type="text" class="form-control" id="title" name="title" placeholder="" value="{{qaContent.title}}">

                            <div style="padding: 8px 12px;">
                                <!-- 에디터 -->
                                <div id="editor" class="form-group">
                                    <input type="hidden" id="contents" name="contents"/>
                                    <input type="hidden" id="contentsMarkup" name="contentsMarkup" value="{{qaContent.contentsMarkup}}"/>
                                </div>
                                <!--// 에디터 -->
                                <div class="form-group">
                                    <div class="col-md-4">
                                        <div class="form-inline" id="tag-info">
                                            <input type="text" class="form-control" size="29" id="interesting" placeholder="Keyword">
                                            <button type="button" class="btn btn-primary" id="keywordAdd">Add <i class="glyphicon glyphicon-plus"></i></button>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <ul id="tag-cloud" style="padding-left: 0px; width:100%;">
                                            {{#each keywordList}}
                                                <li class="tag-cloud tag-cloud-info" data-keyword-name-id="{{keywordId}}">{{keywordName}}</li>
                                            {{/each}}
                                        </ul>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div id="uploadFilesArea">
                                        <span class="glyphicon glyphicon-paperclip btn-m"></span>
                                        <span>Attachments</span>
                                        <div id="uploadfileList" class="alert alert-success attachment-thumbnail">
                                        </div>
                                    </div>
                                    <input name="uploadType" value="Qa" type="hidden">
                                    <input name="uploadFilePath" id="uploadFilePath" type="hidden">
                                    <input id="viewType" name="viewType" value="Image" type="hidden" />
                                    <input id="file-attachment" name="uploadfile" type="file" style="display:none">
                                    <p class="help-block"></p>
                                    <button class="btn btn-info btn-default" type="button" onclick="$('#file-attachment').click();">파일선택</button>

                                </div>
                                <input type="hidden" name="qaId" value="{{qaContent.qaId}}">
                                <input type="hidden" name="wikiId" value="{{qaContent.wikiId}}">
                            </div>
                        </form>
                    </div>
                </div>
            </fieldset>
            <div class="col-md12 text-center">
                <button id="cancelButton" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button id="saveButton" class="btn btn-primary">저장</button>
            </div>
        </section>
    </div>

{{/partial}}

{{embedded "qa/template/_fileList"}}
{{#partial "script-page"}}
    <script type="text/javascript">

        $(document).ready(function(){
            Qa.makeEditor();
            Qa.makeFileList();
            Qa.bindEvent();
        });

        function setParam(){
            $('#contents').val(DualEditor.getMarkupConvertToHtml());
            $('#contentsMarkup').val(DualEditor.getMarkupEditHtml());
            $('#tag-cloud').find('li').each(function(){
                if(!$(this).attr('data-keyword-name-id')) {
                    $('#qaForm').append('<input type="hidden" name="keywords" value="' + this.innerHTML + '">');
                }
            });

            $(Qa.deleteFileData).each(function(idx){
                $('#qaForm').append('<input type="hidden" name="deleteFiles" value="'+Qa.deleteFileData[idx]+'">');
            });
            $(Qa.deleteKeywordData).each(function(idx){
                $('#qaForm').append('<input type="hidden" name="deleteKeywords" value="'+Qa.deleteKeywordData[idx]+'">');
            });
        }

        var Qa = {
            deleteKeywordData: [],
            deleteFileData: [],
            makeEditor: function () {
                DualEditor.setting({
                    src: '/resource/app'
                    , tarketId: 'editor'
                    , width: '100%'
                    , data: $("input[name=contentsMarkup]").val()
                });
            },
            bindEvent: function () {
                this.fileAttachmentEvent();
                this.keywordAddEvent();
                this.tagCloudEvent();
                this.formEvent();
            },
            fileAttachmentEvent: function () {
                $("#file-attachment").on("change", this.uploadFile);
            },
            uploadFile: function () {
                var field = $("#file-attachment").val();
                if (field != '') {
                    $.ajax({
                        url: "/common/uploadFile",
                        type: "POST",
                        data: new FormData($("#qaForm")[0]),
                        enctype: 'multipart/form-data',
                        processData: false,
                        contentType: false,
                        cache: false,
                        success: function (req) {
                            console.log('req : ' + req);
                            console.log('req.data.uploadType : ' + req.data.uploadType);
                            if (req.resultCode == 1) {
                                var fileDivTemplat = Qa.makeFileDivTemplate(req);
                                $('#uploadfileList').append(fileDivTemplat);
                            }
                        },
                        error: function (req) {
                            // Handle upload error
                            alert('req : ' + req);
                            console.log('req : ' + req.status);
                            console.log('req : ' + req.readyState);

                            if (req.status == 500) {
                                alert('업로드 중 에러가 발생했습니다. 파일 용량이 허용범위를 초과 했거나 올바르지 않은 파일 입니다.');
                            } else {
                                alert('에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                            }
                        }
                    });
                }
            },
            /**
             * 키워드 추가
             * 키워드가 3건 이상 등록 될 경우 폼을 disabled 한다.
             */
            keywordAddEvent: function () {
                $('#keywordAdd').click(function () {
                    if ($('#tag-cloud').find('li').length > 3) {
                        alert('키워드는 최대 3건만 등록할 수 있습니다.');
                        $('#tag-cloud').find('li')[3].remove();
                        $("#interesting").attr("readonly", true);
                        $("#keywordAdd").attr("disabled", true);
                    }
                });
            },

            /**
             * 키워드 삭제
             * 키워드가 삭제되면 폼을 enabled 한다.
             */
            tagCloudEvent: function () {
                $('#tag-cloud').on('click', 'li', function (event) {
                    if( $(this).attr('data-keyword-name-id') != null ){
                        Qa.deleteKeywordData.push($(this).attr('data-keyword-name-id'));
                    }
                    if ($('#tag-cloud').find('li').length < 4) {
                        $("#interesting").attr("readonly", false);
                        $("#keywordAdd").attr("disabled", false);
                    }
                });
            },
            formEvent: function () {
                $("#cancelButton").on("click", this.cancelContents);
                $("#saveButton").on("click", ConfirmDialog.saveConfirm);
            },
            updateContents: function () {
                setParam();
                var data = $('#qaForm').serialize();
                $.ajax({
                    url: '/qa/update',
                    type: "POST",
                    dataType: "json",
                    cache: false,
                    data: data,
                    success: function (data) {
                        if (data.resultCode == 1) {
                            ConfirmDialog.successConfirm(data.data.qaId);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(XMLHttpRequest);
                    }
                });
            },
            cancelContents: function () {
                location.href = '/qa/main';
            },
            makeFileList: function () {
                $.get("/qa/fileList", {qaId: $('[name=qaId]').val()}, function (response) {
                    if (response.resultCode != 1) {
                        alert(response.comment);
                        return;
                    }
                    var source = $('#qa-template-_fileList-hbs').html();
                    var template = Handlebars.compile(source);

                    var html = template(response);
                    $('#uploadfileList').html(html);
                });
            },
            deleteFile: function (fileDeleteObj) {
                var individualFileDivObj = $(fileDeleteObj).parent();
                if(individualFileDivObj.find('[name=fileIds]') != null){
                    this.deleteFileData.push(individualFileDivObj.find('[name=fileIds]').val());
                }
                individualFileDivObj.remove();
            },
            makeFileDivTemplate: function (dataObj) {
                var req = dataObj;
                var template =
                        '<div class="fileDiv" style="padding: 5px;">' +
                        '<input name="fileIds" type="hidden" value="">' +
                        '<input name="realNames" type="hidden" value="' + req.data.realName + '">' +
                        '<input name="savedNames" type="hidden" value="' + req.data.savedName + '">' +
                        '<input name="filePaths" type="hidden" value="' + req.data.filePath + '">' +
                        '<input name="fileSizes" type="hidden" value="' + req.data.fileSize + '">' +
                        '<input name="fileTypes" type="hidden" value="' + req.data.fileExtendType + '">' +
                        '<a href="/download?path=' + req.data.filePath + '/' + req.data.savedName + '">' + req.data.realName + '</a>' +
                        '<a href="#fileDiv" onclick="Qa.deleteFile(this);">' +
                        '<span class="glyphicon glyphicon-remove" style="margin-left:15px;"></span>' +
                        '</a>' +
                        '</div>';
                return template;
            }
        };

        var ConfirmDialog = {
            saveConfirm : function(){
                $.confirm({
                    title: '확인',
                    content: '질문을 저장하시겠습니까?',
                    confirmButton: '질문저장',
                    cancelButton: '취소',
                    confirmButtonClass: 'btn-info',
                    confirm: function () {
                        Qa.updateContents();
                    },
                    cancel: function(){
                        return true;
                    }
                });
            },
            successConfirm : function(qaId){
                $.confirm({
                    title: '완료',
                    content: '저장 완료 ',
                    confirmButton: '이동',
                    cancelButton: '취소',
                    confirmButtonClass: 'btn-info',
                    icon: 'fa fa-question-circle',
                    animation: 'top',
                    confirm: function () {
                        location.href = "/qa/" + qaId;
                    }
                });
            },
            error500 : function(condition, status){
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
        }

    </script>
{{/partial}}

{{> template/base}}
