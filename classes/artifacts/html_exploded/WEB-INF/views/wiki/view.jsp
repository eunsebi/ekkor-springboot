{{#partial "title"}}ekkor~{{/partial}}

{{# partial "content" }}
<div class="container-fluid">
    <div class="col-sm-12" id="mainContent">

        <div style="padding-bottom: 45px;">
            <div class="btn-group" data-toggle="buttons" style="float: left">
                {{#if wiki.test}}
                    <!--추후적용-->
                <a href="#" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                <a href="#" class="btn btn-primary"><i class="fa fa-minus"></i></a>
                <a href="#" class="btn btn-primary"><i class="fa fa-laptop"></i></a>
                <a href="#" class="btn btn-primary"><i class="fa fa-star-o"></i></a>
                {{/if}}
            </div>
            <div class="btn-group" id="sub_menu" data-toggle="buttons" style="float: right">
                {{#if isLogin}}
                <a href="#" class="fun-like btn btn-primary" data-value="{{wiki.wikiId}}" data-type="WIKI">추천하기</a>
                {{/if}}
                <!--<a href="#" class="btn btn-primary">히스토리</a>-->
                {{#if isLogin}}
                <a href="#" class="btn btn-primary" id="update">편집</a>
                <a href="#" class="btn btn-primary" id="delete">삭제</a>
                <a href="#" class="btn btn-primary" id="lock">잠금</a>
                {{/if}}
                {{#unless parentWiki}}
                    <a href="#" class="btn btn-primary" id="write">자식위키생성</a>
                {{/unless}}
                <a href="#" class="btn btn-primary" id="space">공간메인</a>
                <a href="#" class="btn btn-primary" id="convertImg">이미지로 변환</a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-9" role="main" id="mainImages" style="padding-bottom: 20px;">
                <h1 class="page-header" style="margin-top: 15px">{{{wiki.title}}}</h1>
                {{{wiki.contents}}}
            </div>

            <div class="col-md-3">
                <div class="bs-docs-sidebar navigation" >
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>작성자</th>
                            <th>{{wiki.insertUserNick}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>작성일</td>
                            <td>{{formatDate wiki.insertDate "yyyy.MM.dd HH:mm:SS"}}</td>
                        </tr>
                        <tr>
                            <td>수정자</td>
                            <th>{{wiki.updateUserNick}}</th>
                        </tr>
                        <tr>
                            <td>수정일</td>
                            <td>{{formatDate wiki.updateDate "yyyy.MM.dd HH:mm:SS"}}</td>
                        </tr>
                        <tr>
                            <td>조회수</td>
                            <td>{{nullToNumber wiki.viewCount}}</td>
                        </tr>
                        <tr>
                            <td>추천수</td>
                            <td id="wikiIdLike">{{wiki.likeCount }}</td>
                        </tr>
                        <tr>
                            <td>글상태</td>
                            {{#if wiki.lock}}
                                <td>잠금</td>
                            {{else}}
                                <td>기본</td>
                            {{/if}}

                        </tr>
                        </tbody>
                    </table>
                    <!--{{#if isLogin}}-->
                    <!--<a href="#" class="fun-like btn btn-primary" data-value="{{wiki.wikiId}}" data-type="WIKI">추천하기</a>-->
                    <!--{{/if}}-->
                    <!--<a href="#" class="btn btn-primary">인쇄하기</a>-->
                </div>
            </div>
        </div>


        <div class="col-md">
            {{#if wiki.linkList}}
            <div style="padding-bottom: 5px">
                링크목록
                <ul>
                    <li>1. 다운로드 - http://son.com</li>
                    <li>2. 다운로드 - http://son.com</li>
                </ul>
            </div>
            {{/if}}
            {{#if wiki.keywordList}}
            <div style="padding-bottom: 10px">
                관련키워드
                <div>
                    {{#each wiki.keywordList}}
                    <span class="label label-primary">{{keywordName}}</span>
                    {{/each}}
                </div>
            </div>
            {{/if}}
            {{#if wiki.commentList}}
            <div style="padding-bottom: 5px">
                주석
                <ul>
                    <li>son.js : 설명~~~</li>
                    <li>glider.js : 설명~~~</li>
                </ul>
            </div>
            {{/if}}
            {{#if wiki.wikiFiles}}
            <div style="padding-bottom: 5px">
                첨부파일
                <div>
                    {{#each wiki.wikiFiles}}
                    <a href="/download?path={{filePath}}/{{savedName}}" download="{{realName}}"> <i class="fa fa-file">{{realName}}</i> </a>
                    {{/each}}
                    <!--<i class="fa fa-file">압축파일.zip</i>-->
                    <!--<i class="fa fa-file">압축파일.zip</i>-->
                </div>
            </div>
            {{/if}}
        </div>

        <div class="col-md text-center">
            <!--<div class="btn-group">-->
                <!--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">-->
                    <!--EXPORT <span class="caret"></span>-->
                <!--</button>-->
                <!--<ul class="dropdown-menu" role="menu">-->
                    <!--<li><a href="#">HTML</a></li>-->
                    <!--<li><a href="#">PDF</a></li>-->
                <!--</ul>-->
            <!--</div>-->
            <div class="btn-group">
                {{#if isLogin}}
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="modal" data-target="#askModal">
                    이 위키에 질문하기
                </button>
                {{/if}}
            </div>
            <!--<div class="btn-group">-->
                <!--<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">-->
                    <!--이 위키 공유하기 <span class="caret"></span>-->
                <!--</button>-->
                <!--<ul class="dropdown-menu" role="menu">-->
                    <!--<li><a href="#">페이스북에 공유</a></li>-->
                    <!--<li><a href="#" data-toggle="modal" data-target="#emailShareModal">이메일에 공유</a></li>-->
                <!--</ul>-->
            <!--</div>-->
        </div>

        {{#ifWikiRelation parentWiki subWikiList}}
        <div class="col-md">
            <div class="nav-tabs-header">관련 위키</div>

            <div class="my-qna-item">
                {{#if parentWiki}}
                <div class="media">
                    <div class="media-left">
                        <div class="user-profile">
                            <img alt="avatar" class="profile-image" src="/resource/images/avatar.png" />
                        </div>
                    </div>
                    <div class="media-body">
                        <div class="media-heading">
                            {{formatDate parentWiki.insertDate "yyyy.MM.dd"}}
                            <span class="my-qna-writer">작성자 &nbsp;&nbsp;&nbsp;{{parentWiki.insertUserNick}}</span>

                        </div>
                        <a class="form" href="/wiki/{{parentWiki.wikiId}}">
                            {{{subString (htmlDelete parentWiki.contents) 0 300 }}}
                        </a>
                {{/if}}
                {{#if subWikiList}}
                <div class="media">
                    <div class="media-left">
                        <div class="user-profile">
                            <img alt="avatar" class="profile-image" src="/resource/images/avatar.png" />
                        </div>
                    </div>
                    <div class="media-body">
                        <div class="media-heading">
                            {{formatDate wiki.insertDate "yyyy.MM.dd"}}
                            <span class="my-qna-writer">작성자 &nbsp;&nbsp;&nbsp;{{wiki.insertUserNick}}</span>
                        </div>
                        <a class="form" href="/wiki/{{wiki.wikiId}}">
                            {{{subString (htmlDelete wiki.contents) 0 300 }}}
                        </a>
                        {{#each subWikiList}}
                            <div class="media">
                                <div class="media-left">
                                    <div class="user-profile">
                                        <img alt="avatar" class="profile-image" src="/resource/images/avatar.png" />
                                    </div>
                                </div>
                                <div class="media-body">
                                    <div class="media-heading">
                                        {{formatDate insertDate "yyyy.MM.dd"}}
                                        <span class="my-qna-writer">작성자 &nbsp;&nbsp;&nbsp;{{insertUserNick}}</span>
                                    </div>
                                    <a class="form" href="/wiki/{{wikiId}}">
                                        {{{subString (htmlDelete contents) 0 180 }}}
                                    </a>
                                </div>
                            </div>
                        {{/each}}
                    </div>
                </div>
                {{/if}}
                {{#if parentWiki}}
                    </div>
                </div>
                {{/if}}
            </div>
        </div>
        {{/ifWikiRelation}}

        {{#if wiki.wikiReplies}}
        <div class="col-md">
            <div class="nav-tabs-header">{{size wiki.wikiReplies}}개의 댓글</div>
            {{#each wiki.wikiReplies}}
            <div class="my-qna-item">
                <a class="pull-left" href="#">
                    <div class="user-profile">
                        <img alt="avatar" class="profile-image" src="/resource/images/avatar.png" />
                    </div>
                </a>
                <div class="row">
                    <div class="col-md-10">
                        <div class="my-my-qna-item-body">
                            <div class="media-heading">
                                {{formatDate insertDate "yyyy.MM.dd"}}
                                <span class="my-qna-writer">작성자 &nbsp;&nbsp;&nbsp;{{this.insertUserNick}}</span>
                                <!--<strong><span class="pull-right">form facebook</span></strong>-->
                            </div>
                            {{{this.contents }}}
                        </div>
                    </div>
                    <div class="col-md-1 my-qna-rating pull-right">
                        <button class="fun-like btn btn-sm btn-default btn-sm-fixed pull-right"
                                data-value="{{this.replyId}}" data-type="COMMENT" id="replyIdLike{{this.replyId}}">추천 <span>{{this.likeCount}}</span></button>
                        <!--<button class="btn btn-sm btn-default btn-sm-fixed pull-right">비추천</button>-->
                    </div>
                </div>
            </div>
            {{/each}}
        </div>
        {{/if}}
        <br>

        {{#if activityList}}
        <div class="col-md">
            <div class="nav-tabs-header">{{size activityList}}개의 활동</div>
            {{#each activityList}}
                <div class="my-qna-item">
                    <a class="pull-left" href="#">
                        <div class="user-profile">
                            <img alt="avatar" class="profile-image" src="/resource/images/avatar.png" />
                        </div>
                    </a>
                    <div class="row">
                        <div class="col-md-10">
                            <div class="my-my-qna-item-body">
                                <div class="media-heading">
                                    {{formatDate insertDate "yyyy.MM.dd"}}
                                    <span class="my-qna-writer">{{activityDesc}}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {{/each}}
        </div>
        {{/if}}

    </div>

</div>

<div class="modal fade" id="askModal" tabindex="-1" role="dialog" aria-labelledby="askModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="askModalLabel">위키에 질문하기</h4>
            </div>
            <div class="modal-body" id="askEdit">
                <form role="form" id="wikiForm">
                    <input type="hidden" name="wikiId" value="{{wiki.wikiId}}">
                    <div class="form-group">
                        <input type="hidden" name="contents" id="contents" />
                        <input type="hidden" name="contentsMarkup" id="contentsMarkup" value="" />
                        <div id="editor" class="form-group"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="cancel" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="saveWiki">저장</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="emailShareModal" tabindex="-1" role="dialog" aria-labelledby="emailShareModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="emailShareModalLabel">이메일로 공유하기</h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" role="form">
                    <div class="form-group">
                        <input type="text" class="form-control">
                    </div>
                    <button type="button" class="btn btn-primary">추가</button>
                </form>
                <br>
                <button type="button" class="btn btn-default btn-sm">cafeciel@hanmail.net <span class="glyphicon glyphicon-remove"></span></button>
                <button type="button" class="btn btn-default btn-sm">cafeciel@hanmail.net <span class="glyphicon glyphicon-remove"></span></button>
                <button type="button" class="btn btn-default btn-sm">cafeciel@hanmail.net <span class="glyphicon glyphicon-remove"></span></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="wikiId" value="{{wiki.wikiId}}">
<input type="hidden" id="spaceId" value="{{wiki.spaceId}}">

<form id="convertImageForm" name="convertImageForm">
    <input type="hidden" id="data" name="data" value="">
</form>

{{/partial}}


{{# partial "style" }}
    <link href="/resource/app/js/DualEditor/css/DualEditor.css" rel="stylesheet">
{{/partial}}

{{#partial "plugin-style"}}
{{!-- 여기에 .css 파일 경로 --}}
    <link href="/resource/public/css/bootstrap-tag-cloud/bootstrap-tag-cloud.css" rel="stylesheet">
{{/partial}}
{{#partial "script-header"}}
    <script src="/resource/app/js/DualEditor/DualEditor-core.js"></script>
    <script type='text/javascript' src="/resource/public/js/bootstrap-tag-cloud/bootstrap-tag-cloud.js"></script>
    <script type='text/javascript' src="/resource/public/js/html2canvas.js"></script>
{{/partial}}


{{#partial "script-page" }}
    <script type="text/javascript">
        $(document).ready(function() {
            DualEditor.setting({
                src : '/resource/app'
                ,tarketId : 'editor'
                ,type : 'mini'
                ,width : '100%'
                //,height : '300px'
                ,data : $("input[name=contentsMarkup]").val()
            });
            $("#file-attachment").on("change", Wiki.uploadFile);

            $("#outdent").hide();
            $("#outdent").click(function(){
                $("#indent").show();
                $("#outdent").hide();
                var div1 = $("#mainContent").children(".row").children(":first");
                var div2 = $("#mainContent").children(".row").children(":last");
                div2.show();
                div1.toggleClass("col-md-12 col-md-9");
            });

            $("#indent").click(function(){
                $("#outdent").show();
                $("#indent").hide();
                var div1 = $("#mainContent").children(".row").children(":first");
                var div2 = $("#mainContent").children(".row").children(":last");
                div2.hide();
                div1.toggleClass("col-md-9 col-md-12");
            });

            // 이미지 파일로 변환
            $("#convertImg").click(function(){
                html2canvas($("#mainImages"), {
                    //allowTaint: true,
                    //taintTest: false,
                    background : "#fff",
                    useCORS: true,
                    onrendered: function(canvas) {
                        if (typeof FlashCanvas != "undefined") {
                            FlashCanvas.initElement(canvas);
                        }
                        $("#data").val(canvas.toDataURL("image/png"));
                        $('#convertImageForm').attr({action:'/common/convertImage', method:'post'}).submit();
                    }
                });
            });
        });

        $(".btn-group a").on("click", function(){
            var href = $(this).attr("href");
            location.href = href;
        });

        $(".fun-like").on("click", function(){
            var type = this.dataset.type;
            var value = this.dataset.value;
            $.confirm({
                title: '추천',
                content: "추천 하시겠습니까?",
                confirmButton: '추천',
                cancelButton : '취소',
                confirmButtonClass: 'btn-info',
                icon: 'fa fa-question-circle',
                animation: 'top',
                confirm: function () {
                    Wiki.like(type, value);
                }
            });
        });

        $("#saveWiki").on("click", function(){
            Wiki.save();
        });
        $("#sub_menu a").on("click", function(){
           var link = '';
           var text = '';
           var id = this.id;
           if( id == 'update' ){
               text ='이 위키를 수정를';
               link = "/wiki/update/"+$("#wikiId").val();
           }else if( id == 'delete' ){
               text ='이 위키를 삭제를';
               link = "/wiki/delete/"+$("#wikiId").val();
           }else if( id == 'lock' ){
               text ='이 위키를 잠금 처리 ';
               link = "/wiki/lock/"+$("#wikiId").val();
           }else if( id == 'write' ){
               text ='자식위키를 생성';
               link = "/wiki/write/"+$("#wikiId").val();
           }else if( id == 'space' ){
               text ='공간으로 이동';
               link = "/space/"+$("#spaceId").val();
           }
           if( link != '' ){
               $.confirm({
                   title: '알림',
                   content: text+" 하시겠습니까?",
                   confirmButton: '처리',
                   cancelButton : '취소',
                   confirmButtonClass: 'btn-info',
                   icon: 'fa fa-question-circle',
                   animation: 'top',
                   confirm: function () {
                       if( id == 'update' ) {
                           location.href = link;
                       }else if( id == 'delete' ) {
                           Wiki.updateStat(id, link);
                       }else if( id == 'lock' ) {
                           Wiki.updateStat(id, link);
                       }else if( id == 'delete' ){
                           location.href = "/wiki/main";
                       }else if( id == 'lock' ){
                           Wiki.updateStat(id, link);
                       }else if( id == 'write' ){
                           location.href = link;
                       }else if( id == 'space' ) {
                           location.href = link;
                       }
                   }
               });
           }
        });

        var Wiki = {
            like : function(type,num){
                $.ajax({
                    url: "/wiki/saveLike",
                    type: "POST",
                    data: { type : type, num : num },
                    success : function(result){
                        if( result.data != null){
                            if( result.data.result == 1  ){
                                $.alert({
                                    title: '추천',
                                    content: '추천이 되었습니다.',
                                    confirmButton: '확인',
                                    cancelButton : '취소',
                                    confirmButtonClass: 'btn-primary',
                                    icon: 'fa fa-info',
                                    animation: 'zoom',
                                    confirm: function () {
                                    }
                                });
                                $(".fun-like").each(function(){
                                    if( result.data.wikiLike.wikiId != null && this.dataset.type == "WIKI"){
                                        var num = Number($("#wikiIdLike").text())+1;
                                        $("#wikiIdLike").text( num );
                                    }else if( result.data.wikiLike.replyId != null
                                            && this.dataset.type == "COMMENT"
                                            && this.dataset.value == result.data.wikiLike.replyId ){
                                        var id = "replyIdLike"+this.dataset.value;
                                        var num = Number($("#"+id+" span").text())+1;
                                        $("#"+id+" span").text(num);
                                    }
                                })
                            }else{
                                $.alert({
                                    title: '추천',
                                    content: '이미 추천이 되었습니다.',
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
                    },
                    error : function(req){
                        // Handle upload error
                        alert('req : ' + req);
                        console.log('req : ' + req.status);
                        console.log('req : ' + req.readyState);

                        alert('에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                    }
                });
            },

            save:function(){
                $("#contents").val(DualEditor.getMarkupConvertToHtml());
                $("#contentsMarkup").val(DualEditor.getMarkupEditHtml());
                var data = $("#wikiForm").serialize();
                jQuery.ajax({
                    type:'POST',
                    data:data,
                    url:'/wiki/reply/save',
                    success:function(req){
                        if (req.resultCode == 1) {
                            var href = "/wiki/"+$("#wikiId").val();
                            location.href = href;
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

            updateStat:function(id, link){
                jQuery.ajax({
                    type:'GET',
                    url : link,
                    success:function(req){
                        if (req.resultCode == 1) {
                            if( id == "update" || id == "delete" ){
                                $.alert({
                                    title: '확인',
                                    content: '처리되었습니다',
                                    confirmButton: 'OK',
                                    confirmButtonClass: 'btn-primary',
                                    icon: 'fa fa-info',
                                    animation: 'zoom',
                                    confirm: function () {
                                        location.href = "/wiki/main";
                                    }
                                });
                            } else {
                                $.alert({
                                    title: '확인',
                                    content: '처리되었습니다',
                                    confirmButton: 'OK',
                                    confirmButtonClass: 'btn-primary',
                                    icon: 'fa fa-info',
                                    animation: 'zoom',
                                    confirm: function () {
                                        location.reload();
                                    }
                                });
                            }
                        }else{

                            $.alert({
                                title: '확인',
                                content: req.data,
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
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
            }
        }
    </script>
{{/partial}}

{{> template/base}}