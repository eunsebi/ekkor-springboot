
{{#partial "title"}}Alpaka~{{/partial}}

{{# partial "content" }}
<div class="container-fluid">
    <div class="col-sm-12">
        <section id="forms">

            <div class="page-header">
                <h2>위키 생성하기</h2>
            </div>

            <div class="modal-body well">
                <form role="form" id="wikiForm">
                    <input name="parentsId" value="{{parentWiki.wikiId}}" type="hidden" />
                    <input name="depthIdx" value="{{parentWiki.depthIdx}}" type="hidden" />
                    <input name="orderIdx" value="{{parentWiki.orderIdx}}" type="hidden" />
                    <input name="groupIdx" value="{{parentWiki.groupIdx}}" type="hidden" />
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="space_title" class="col-sm-1 control-label">공간제목</label>
                            <div class="col-sm-11">
                                {{#if space.spaceId}}
                                    <input type="text" class="form-control" id="space_title" placeholder="{{space.title}}" readonly>
                                    <input type="hidden" id="spaceId" name="spaceId" value="{{space.spaceId}}">
                                {{else}}
                                    <select class="form-control" id="spaceId" name="spaceId">
                                        {{#each spaceList}}
                                        <option value="{{spaceId}}">{{title}}</option>
                                        {{/each}}
                                    </select>
                                {{/if}}
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="title" class="col-sm-1 control-label">위키제목</label>
                            <div class="col-sm-11">
                                <input type="text" value="{{wiki.title}}" class="form-control" id="title" name="title" placeholder="">
                            </div>
                        </div>

                    </div>
                    <hr style="background-color:#ccc; height: 1px; margin-top:0px; margin-bottom: 10px;">
                    <!-- 에디터 -->
                    <div class="form-group">
                        <input type="hidden" name="contents" id="contents" />
                        <input type="hidden" name="contentsMarkup" id="contentsMarkup" value="{{wiki.contentsMarkup}}" />
                        <div id="editor" class="form-group"></div>
                    </div>
                    <!--// 에디터 -->

                    <div class="form-inline form-group">
                        <div class="row">
                            <div class="col-lg-4" id="tag-info">
                                <label for="keyword" class="sr-only">키워드</label>
                                <input type="text" class="form-control" size="29" id="interesting" placeholder="키워드를 입력하세요. (최대 3개)">
                                <button class="btn btn-primary" type="button" id="keywordAdd">Add <i class="glyphicon glyphicon-plus"></i></button>
                            </div>
                            <ul id="tag-cloud" style="padding-left: 0px; width:100%;">
                                {{#if keywordList}}
                                    {{#each keywordList}}
                                        <li class="tag-cloud tag-cloud-info" data-keyword-name-id="{{keywordId}}" >{{keywordName}}</li>
                                    {{/each}}
                                {{/if}}
                            </ul>
                        </div>
                    </div>

                    <div class="form-group">
                        <div id="uploadFilesArea">
                            <span class="glyphicon glyphicon-paperclip btn-m"></span>
                            <span>Attachments</span>
                            <div id="uploadfileList" class="alert alert-success attachment-thumbnail">
                                {{#if wiki.wikiFiles}}
                                    {{#each wiki.wikiFiles}}
                                        <div class="fileDiv" style="padding: 5px;">
                                            <input name="wikiFiles[{{@index}}].fileId"    id="fileId" type="hidden" value="{{fileId}}">
                                            <input name="wikiFiles[{{@index}}].realName"  id="realName" type="hidden" value="{{realName}}">
                                            <input name="wikiFiles[{{@index}}].savedName" id="savedName" type="hidden" value="{{savedName}}">
                                            <input name="wikiFiles[{{@index}}].filePath"  id="filePath" type="hidden" value="{{filePath}}">
                                            <input name="wikiFiles[{{@index}}].fileSize"  id="fileSize" type="hidden" value="{{fileSize}}">
                                            <input name="wikiFiles[{{@index}}].fileType"  id="fileType" type="hidden" value="{{fileExtendType}}">
                                            <input name="wikiFiles[{{@index}}].Deleted" id="isDeleted" type="hidden" value="false">
                                            <a href="{{filePath}}/{{savedName}}">{{realName}}</a>
                                            <a href="#" onclick="Wiki.deleteFile(this); return false;">
                                                <span class="glyphicon glyphicon-remove" style="margin-left:15px;"></span>
                                            </a>
                                        </div>
                                    {{/each}}
                                {{/if}}
                            </div>
                        </div>
                        <input name="uploadType" value="WIKI" type="hidden">
                        <input name="uploadFilePath" id="uploadFilePath" type="hidden">
                        <input id="viewType" name="viewType" value="" type="hidden" />
                        <input id="file-attachment" name="uploadfile" type="file" style="display:none">
                        <p class="help-block"></p>
                        <button class="btn btn-info btn-default" type="button" onclick="$('#file-attachment').click();">파일선택</button>

                    </div>
                    <input type="hidden" name="wikiId" value="{{wiki.wikiId}}"/>
                </form>
            </div>
            <div class="form-actions text-center">
                <button type="button" class="btn btn-primary" id="saveWiki">저장</button>
                <button type="button" class="btn" id="cancel">취소</button>

            </div>
        </section>
    </div>
</div>
{{/partial}}


{{# partial "style" }}
    <link href="/resource/app/js/DualEditor/css/DualEditor.css" rel="stylesheet">
{{/partial}}

{{#partial "plugin-style"}}
{{!-- 여기에 .css 파일 경로 --}}
    <link href="/resource/public/css/bootstrap-tag-cloud/bootstrap-tag-cloud.css" rel="stylesheet">
{{/partial}}
{{#partial "script-header"}}
    <link href="/resource/app/js/summernote/summernote.css" rel="stylesheet">
    <script src="/resource/app/js/summernote/summernote.js"></script>
    <script src="/resource/app/js/summernote/summernote-ext-highlight.js"></script>
    <!--<script src="/resource/app/js/DualEditor/DualEditor-core.js"></script>-->
    <script src="/resource/app/js/summernote/summernote_sub.js"></script>
    <script type='text/javascript' src="/resource/public/js/bootstrap-tag-cloud/bootstrap-tag-cloud.js"></script>
{{/partial}}


{{# partial "script-page" }}
    <script type="text/javascript">
        $(document).ready(function() {
            $("#file-attachment").on("change", Wiki.uploadFile);
        });

        $('#editor').summernote({
            height: 450,
            callbacks: {
                onImageUpload: function (files, editor, welEditable) {
                    summertnote_sub().sendImage(files[0], this);
                },
            },
            prettifyHtml:false,
            lang:'ko-KR',
            toolbar: [
                ['style', ['style']],
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['fontsize', ['fontsize']],
                ['insert',['picture','link','table','hr', 'video']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['etc', ['fullscreen','codeview','help']]
            ]
        });
        $('#editor').summernote('code', $("input[name=contentsMarkup]").val());
//        DualEditor.setting({
//            src : '/resource/app'
//            ,tarketId : 'editor'
//            //,type : 'mini'
//            //,width : window.screen.width+'px'
//            //,width : '100%'
//            //,height : '300px'
//            ,data : $("input[name=contentsMarkup]").val()
//        });


        $("#saveWiki").on("click", function(e){
            $.confirm({
                title: '저장',
                content: '이 위키를 저장하시겠습니까?',
                confirmButton: '저장',
                cancelButton : '취소',
                confirmButtonClass: 'btn-info',
                icon: 'fa fa-question-circle',
                animation: 'top',
                confirm: function () {
                    if( location.href.indexOf("update") > 0 ){
                        Wiki.update();
                    }else{
                        Wiki.save();
                    }
                }
            });
        });
        $("#cancel").on("click", function(e){
            history.go(-1);
        });

        var Wiki = {
            deleteKeywordData: [],


            setParam:function(){
//                $("#contents").val(DualEditor.getMarkupConvertToHtml());
//                $("#contentsMarkup").val(DualEditor.getMarkupEditHtml());
                $("#contents").val($("#editor").summernote("code"));
                $("#contentsMarkup").val($("#editor").summernote("code"));

                $('#tag-cloud').find('li').each(function(){
                    if(!$(this).attr('data-keyword-name-id')) {
                        $(this).append('<input type="hidden" name="keywords" value="' + this.innerHTML + '">');
                    }
                });

                $(this.deleteKeywordData).each(function(idx){
                    $('#tag-cloud').append('<input type="hidden" name="deleteKeywords" value="'+Wiki.deleteKeywordData[idx]+'">');
                });

            },
            save:function(){
                this.setParam();
                var data = $("#wikiForm").serialize();
                jQuery.ajax({
                    type:'POST',
                    data:data,
                    url:'/wiki/save',
                    success:function(req){
                        if (req.resultCode == 1) {
                            $.alert({
                                title: '확인',
                                content: '위키를 저장했습니다.',
                                confirmButton: '확인',
                                cancelButton : '취소',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                    $(location).attr('href', "/wiki/"+req.data.wikiId);
                                }
                            });
                        }
                    },
                    error:function(req){
                        if (req.status == 500) {
                            error500(true, '');
                        } else {
                            error500(false, req.status);
                        }
                    }});
                return false;
            },
            update:function(){
                this.setParam();
                var data = $("#wikiForm").serialize();
                jQuery.ajax({
                    type:'POST',
                    data:data,
                    url:'/wiki/update',
                    success:function(req){
                        if (req.resultCode == 1) {
                            $.alert({
                                title: '확인',
                                content: '위키를 저장했습니다.',
                                confirmButton: '확인',
                                cancelButton : '취소',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                    $(location).attr('href', "/wiki/"+req.data.wikiId);
                                }
                            });

                        }
                    },
                    error:function(req){
                        if (req.status == 500) {
                            error500(true, '');
                        } else {
                            error500(false, req.status);
                        }
                    }});
                return false;
            },
            uploadFile : function(){
                var field = $("#file-attachment").val();
                if (field != '') {
                    $.ajax({
                        url: "/common/uploadFile",
                        type: "POST",
                        data: new FormData($("#wikiForm")[0]),
                        enctype: 'multipart/form-data',
                        processData: false,
                        contentType: false,
                        cache: false,
                        success: function (req) {
                            if (req.resultCode == 1) {
                                var idx = $("#uploadfileList > div").size();
                                var fileDivTemplat = '<div class="fileDiv" style="padding: 5px;">' +
                                        '<input name="wikiFiles['+idx+'].realName"  id="realName" type="hidden" value="'+req.data.realName+'">' +
                                        '<input name="wikiFiles['+idx+'].savedName" id="savedName" type="hidden" value="'+req.data.savedName+'">' +
                                        '<input name="wikiFiles['+idx+'].filePath"  id="filePath" type="hidden" value="'+req.data.filePath+'">' +
                                        '<input name="wikiFiles['+idx+'].fileSize"  id="fileSize" type="hidden" value="'+req.data.fileSize+'">' +
                                        '<input name="wikiFiles['+idx+'].fileType"  id="fileType" type="hidden" value="'+req.data.fileExtendType+'">' +
                                        '<input name="wikiFiles['+idx+'].isDeleted"  id="isDeleted" type="hidden" value="false">' +
                                        '<a href="/download?path='+req.data.filePath+'/'+req.data.savedName+'">'+req.data.realName+'</a>' +
                                        '<a href="#fileDiv" onclick="Wiki.deleteFile(this); return false;">' +
                                        '<span class="glyphicon glyphicon-remove" style="margin-left:15px;"></span>' +
                                        '</a>' +
                                        '</div>';
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
            deleteFile : function(fileDeleteObj){
                var individualFileDivObj = $(fileDeleteObj).parent();
                individualFileDivObj.find("#isDeleted").val(true)
                individualFileDivObj.hide();
                return false;
            }
        };

        function error500(condition, status) {
            if (condition) {
                $.alert({
                    title: '확인',
                    content: '위키 정보 저장중 에러가 발생했습니다.',
                    confirmButton: '확인',
                    cancelButton : '취소',
                    confirmButtonClass: 'btn-primary',
                    icon: 'fa fa-info',
                    animation: 'zoom',
                    confirm: function () {
                    }
                });
            } else {
                $.alert({
                    title: '확인',
                    content: '위키 정보 저장중 에러가 발생했습니다. 에러코드 [' + status + ']',
                    confirmButton: '확인',
                    cancelButton : '취소',
                    confirmButtonClass: 'btn-primary',
                    icon: 'fa fa-info',
                    animation: 'zoom',
                    confirm: function () {
                    }
                });
            }
        }

        /**
         * 키워드 추가
         * 키워드가 3건 이상 등록 될 경우 폼을 disabled 한다.
         * 대소문자 중복 허용하지 않는다.
         */
        $('#keywordAdd').click(function () {
            if ($('#tag-cloud').find('li').length > 3) {
                alert('키워드는 최대 3건만 등록할 수 있습니다.');
                $('#tag-cloud').find('li')[3].remove();
                $("#interesting").attr("readonly", true);
                $("#keywordAdd").attr("disabled", true);
            }
        });

        /**
         * 키워드 삭제
         * 키워드가 삭제되면 폼을 enabled 한다.
         */
        $('#tag-cloud').on('click', 'li', function () {
            if( $(this).attr('data-keyword-name-id') != null ){
                Wiki.deleteKeywordData.push($(this).attr('data-keyword-name-id'));
            }
            if ($('#tag-cloud').find('li').length < 4) {
                $("#interesting").attr("readonly", false);
                $("#keywordAdd").attr("disabled", false);
            }
        });

    </script>
{{/partial}}

{{> template/base}}