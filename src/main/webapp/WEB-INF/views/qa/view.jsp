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

{{#partial "script-header"}}
    <script src="/resource/app/js/DualEditor/DualEditor-core.js"></script>
{{/partial}}

{{# partial "content" }}
    <!-- 메뉴 -->
    <div class="container-fluid">
        <!-- contents -->
        <div class="col-md-12">
            <form id="qaForm">
                <!-- 관련키워드 -->
                <div class="row top-buffer">
                    <span class="col-md-12 pull-left section-category qna-alert-info">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#">관련 키워드</a></li>
                            <li class="pull-left qa-view-keyowrdList">
                                {{#each keywordList}}
                                    <!--<span class="label label-primary">{{keywordName}}</span>-->
                                    {{#keywordBadge keywordName}}{{/keywordBadge}}
                                {{/each}}
                            </li>
                            <li class="pull-right">
                                <div class="user-profile-sm">
                                    <span class="nickname">{{qaContent.userNick}}</span>
                                    <img alt="avatar" class="profile-image" src="/imageView?path={{writer.userImage}}" onerror='this.src="/resource/images/avatar.png"'/>
                                </div>
                            </li>
                        </ul>
                    </span>
                </div>
                <!--// 관련키워드 -->
                <div class="media form-group top-buffer">
                    <!-- 본문 제목, 내용 -->
                    <div class="alert alert-info">
                        <div class="row">
                            <div class="col-md-8">
                                <span class="qna-alert-title">{{qaContent.title}}</span>
                                <span class="badge">{{qaReplyCnt}}</span>
                            </div>
                            <div class="col-md-4 text-right">
                                <span class="qna-alert-title">{{formatDate qaContent.insertDate "yyyy-MM-dd HH:mm"}}</span>
                                <span class="readCnt qna-alert-title">조회수 : {{qaContent.viewCount}}</span>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <p>
                                {{{qaContent.contents}}}
                            </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div id="uploadFilesArea" style="display: none;">
                            <span class="glyphicon glyphicon-paperclip btn-m"></span>
                            <span>Attachments</span>
                            <div id="uploadfileList" class="alert attachment-thumbnail">
                            </div>
                        </div>
                        <input name="uploadType" value="Qa" type="hidden">
                        <input name="uploadFilePath" id="uploadFilePath" type="hidden">
                        <input id="file-attachment" name="uploadfile" type="file" style="display:none">
                        <p class="help-block"></p>
                    </div>
                    <input type="hidden" name="qaId" value="{{qaContent.qaId}}">
                </div>
                <!--// 본문 제목, 내용 -->
                <div class="qa form-group">
                    <div class="action-buttons qna-content">
                        <i class="fa fa-thumbs-o-up {{#if qaContent.selfRecommend}}fa-2x{{/if}}" data-qa-recommend-type="UP" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each qaContent.qaRecommendList}}{{userNick}}<br>{{/each}}">
                            <span class="like-count">({{qaContent.recommendCount}})</span>
                        </i>
                        <i class="fa fa-thumbs-o-down {{#if qaContent.selfNonrecommend}}fa-2x{{/if}}" data-qa-recommend-type="DOWN" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each qaContent.qaNonRecommendList}}{{userNick}}<br>{{/each}}">
                            <span class="claim-count">({{qaContent.nonrecommendCount}})</span>
                        </i>
                    </div>
                    <div class="text-right">
                        {{#if isLogin}}
                            <button id="editButton" type="button" class="btn btn-primary btn-sm">수정</button>
                            <button id="deleteButton" type="button" class="btn btn-danger btn-sm">삭제</button>
                            <button id="listButton" type="button" class="btn btn-primary btn-sm">목록</button>
                        {{/if}}
                    </div>
                </div>

            </form>

            <!-- 댓글 영역 list -->
            <div id="replyList" class="replyList"></div>

            <!-- 댓글 입력 영역 -->
            {{#if isLogin}}
            <div class="replyList">
                <div class="top-buffer">
                    <form name="qaReplyForm">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    답변
                                </h3>
                            </div>
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <div style="margin-left: 5px; margin-bottom: 10px;">
                                        <div class="avatar avatar-medium clearfix ">
                                            <div class="user-profile-sm">
                                                <!-- 세션에서 userNick 가져와야함 -->
                                                <span class="nickname">{{loggedUser.userNick}}</span>
                                                <img alt="avatar" class="profile-image" src="/imageView?path={{loggedUser.userImage}}" onerror='this.src="/resource/images/avatar.png"'/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 댓글작성 Bootstrap Live Editor -->
                                    <div class="row" style="margin-left: 5px; margin-bottom: 10px; width: 90%">
                                        <input type="text" class="form-control" id="title" name="title" placeholder="title">
                                    </div>
                                    <div class="form-group">
                                        <input type="hidden" id="contents" name="contents" />
                                        <input type="hidden" id="contentsMarkup" name="contentsMarkup" />
                                        <input type="hidden" id="depthIdx" name="depthIdx" value="1" />   <!-- 답변 계층 -->
                                        <input type="hidden" id="parentsId" name="parentsId" value="0" />   <!-- 답변 계층 -->
                                        <div id="editor">
                                        </div>
                                    </div>
                                    <!--// 댓글작성 Bootstrap Live Editor -->

                                    <!-- 댓글작성 저장 button -->
                                    {{#if isLogin}}
                                    <div class="feed-write-bottom text-right">
                                        <button id="saveReplyButton" type="button" class="btn btn-primary btn-default">저장</button>
                                        <button id="cancleReplyButton" type="button" class="btn hide" data-dismiss="modal">취소</button>
                                    </div>
                                    {{/if}}
                                </li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
            {{/if}}
            <!-- //댓글 입력 영역-->

        </div>
    </div>

    <!-- popover-config start -->
    {{#if isLogin}}
    <div id="popover-config-content" style="display: none;">
        <div class="button"><a href="javascript:void(0);" onclick="Qa.modifyReply(this);">수정</a></div>
        <div class="button"><a href="javascript:void(0);" onclick="Qa.qaReplyDelete(this);">삭제</a></div>
    </div>
    {{/if}}

{{/partial}}

{{#partial "script-page"}}
{{embedded "qa/template/_fileList"}}
{{embedded "qa/template/_replyList"}}
    <script type="text/javascript">
        $(document).ready(function(){
            Qa.bindEvent();
            Qa.makeFileList();
            Qa.searchList();
            Qa.makeEditor();
        });

        function setParam(){
            $('#contents').val(DualEditor.getMarkupConvertToHtml());
            $('#contentsMarkup').val(DualEditor.getMarkupEditHtml());
        }

        var Qa = {
            makeEditor : function(){
                DualEditor.setting({
                    src : '/resource/app'
                    , tarketId : 'editor'
                    , type : 'mini'
                    , width : '100%'
                    , height : '400px;'
                });
            },
            clearEditor : function(){
                $('[name=qaReplyForm] #title').val('');
                $('#contents').val('');
                $('#contentsMarkup').val('');
                $("#wikiEditor").val('');
            },
            searchList : function(){
                $.get("/qa/replyList",{qaId : $('[name=qaId]').val()}, function (response) {
                    if(response.resultCode != 1) {
                        alert(response.comment);
                        return;
                    }
                    var source = $('#qa-template-_replyList-hbs').html();
                    var template = Handlebars.compile(source);

                    var html = template(response);
                    $('#replyList').html(html);
                    {{#unless isLogin}}
                        $('.input-reply-area').html('');
                    {{/unless}}
                });
            },
            buttonEvent : function(){
                $('#editButton').on("click", function(){
                    location.href = "/qa/edit/" + $('[name=qaId]').val();
                });
                $('#deleteButton').on("click",function(){
                    ConfirmDialog.deleteConfirm();
                });
                $('#listButton').on("click", function(){
                    location.href = "/qa/main";
                });
            },
            bindEvent : function(){
                this.cancleEvent();
                this.buttonEvent();
                this.saveRecommendEvent();
                this.tooltipEvent();
                this.saveReplyEvent();
                this.cancleReplyButtonEvent();
            },
            saveReplyEvent : function(){
                $("#saveReplyButton").on("click", this.saveReply);
            },
            saveChildReplyEvent : function(){
                $('button[name=saveChildReplyButton]').on("click", this.saveChildReply);
            },
            cancleEvent : function(){
                $("#cancelButton").on("click", this.cancelContents);
            },
            cancelContents : function(){
                location.href = '/qa/main';
            },
            makeFileList : function(){
                var that = this;
                $.get("/qa/fileList",{qaId : $('[name=qaId]').val()}, function (response) {
                    if(response.resultCode != 1) {
                        alert(response.comment);
                        return;
                    }
                    if(response.data.length != 0){
                        $('#uploadFilesArea').show();
                        var source = $('#qa-template-_fileList-hbs').html();
                        var template = Handlebars.compile(source);

                        var html = template(response);
                        $('#uploadfileList').html(html);
                        that.unBindDeleteEventFileList();
                    }
                });
            },
            saveRecommendEvent : function(){
                $('.qna-content > i').click(function(){
                    Qa.checkSaveRecommend(this);
                });
            },
            saveReply : function(){
                setParam();
                var replyId = '';
                var url = '/qa/saveReply';
                if($('[name=qaReplyForm] .form-group').attr('data-reply-id')){
                    url = '/qa/updateReply';
                    replyId = $('[name=qaReplyForm] .form-group').attr('data-reply-id');
                }
                $.ajax({
                    type : 'POST',
                    data : $(this).closest('form').serialize() + '&qaId='+$('[name=qaId]').val() + '&replyId='+replyId,
                    url : url,
                    success : function(data){
                        if(data.resultCode == 1) {
                            Qa.searchList();
                            Qa.clearEditor();
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            saveChildReply: function() {
                if(Qa.checkChildReplyForm(this)){
                    return false;
                }
                var data = $(this).closest('form').serialize();
                $.ajax({
                    type : 'POST',
                    data : data,
                    url : '/qa/saveChildReply',
                    success : function(data){
                        if(data.resultCode == 1) {
                            Qa.searchList();
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            tooltipEvent : function(){
                var tooltipObj = $('.qna-content [data-toggle="tooltip"]');
                tooltipObj.tooltip();
            },
            deleteContents : function(){
                $.ajax({
                    type : 'POST',
                    data : {qaId : $('[name=qaId]').val()},
                    url : '/qa/delete',
                    success : function(data){
                        if(data.resultCode == 1) {
                            ConfirmDialog.successConfirm();
                        } else {
                            $.alert(data.data);
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            unBindDeleteEventFileList : function(){
                $('.fileDiv').find('[href=#fileDiv]').remove();
            },
            saveVoteEvent : function(){
                $('.qna-reply-icon > i.reply-recommend').click(function(){
                    Qa.checkSaveVote(this);
                });
            },
            saveChoiceEvent : function(){
                $('.qna-reply-icon > i.reply-choice').click(function(){
                    Qa.saveChoice(this);
                });
            },
            checkSaveRecommend : function(recommendLiObj){
                var recommendType = $(recommendLiObj).attr('data-qa-recommend-type');
                var isCommend;
                if( recommendType == 'UP' ){
                    isCommend = true;
                } else {
                    isCommend = false;
                }
                $.ajax({
                    type : 'POST',
                    data : { qaId : $('[name=qaId]').val(),
                             isCommend : isCommend},
                    url : '/qa/recommend',
                    success : function(data){
                        if(data.resultCode == 1) {
                            if(data.data == null){
                                Qa.saveRecommend(recommendLiObj);
                            } else {
                                alert("이미 추천/비추천 하셨습니다.");
                            }
                        } else if(data.resultCode == 10){
                            $.alert({
                                title: 'Alert!',
                                content: data.comment,
                                confirm: function(){
                                    location.href = '/loginPage';
                                }
                            });
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            checkChildReplyForm : function(obj){
                var validResult = false;
                var inputObj = $(obj).closest('form').find('[name=contents]');
                if( !inputObj.val().trim().length ){
                    $.alert({
                        title: '알림',
                        content: '댓글을 입력해주세요.',
                        confirm: function(){
                            inputObj.focus();
                        }
                    });
                    validResult = true;
                }
                return validResult;
            },
            checkSaveVote : function(voteLiObj){
                var replyId = $(voteLiObj).closest('.thread').attr('data-qa-reply-id');
                var voteType = $(voteLiObj).attr('data-qa-vote-type');
                var isVote;
                if( voteType == 'UP' ){
                    isVote = true;
                } else {
                    isVote = false;
                }
                $.ajax({
                    type : 'POST',
                    data : { qaId : $('[name=qaId]').val(),
                             replyId : replyId,
                             isVote : isVote},
                    url : '/qa/reply/vote',
                    success : function(data){
                        if(data.resultCode == 1) {
                            if(data.data == null){
                                Qa.saveVote(voteLiObj);
                            } else {
                                alert("이미 추천/비추천 하셨습니다.");
                            }
                        } else if(data.resultCode == 10){
                            $.alert({
                                title: 'Alert!',
                                content: data.comment,
                                confirm: function(){
                                    location.href = '/loginPage';
                                }
                            });
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            saveRecommend : function(recommendLiObj){
                var recommendType = $(recommendLiObj).attr('data-qa-recommend-type');
                var url = '/qa/saveRecommend';
                var isCommend;
                if( recommendType == 'UP' ){
                    isCommend = true;
                } else {
                    isCommend = false;
                }
                $.ajax({
                    type : 'POST',
                    data : { qaId : $('[name=qaId]').val(),
                             isCommend : isCommend},
                    url : url,
                    success : function(data){
                        if(data.resultCode == 1) {
                            Qa.refrashRecommendTooltip(data.data.qaRecommendList, data.data.qaNonRecommendList);
                            Qa.refrashRecommendCount(data.data.recommendCount, data.data.nonrecommendCount);
                            Qa.refrashSelfRecommend(data.data.selfRecommend, data.data.selfNonrecommend);
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            saveVote : function(voteLiObj){
                var replyId = $(voteLiObj).closest('.thread').attr('data-qa-reply-id');
                var voteType = $(voteLiObj).attr('data-qa-vote-type');
                var url = '';
                if(voteType == 'UP'){
                    url = '/qa/saveVoteUp';
                } else if(voteType == 'DOWN'){
                    url = '/qa/saveVoteDown';
                }
                $.ajax({
                    type : 'POST',
                    data : {qaId : $('[name=qaId]').val(),
                            replyId : replyId},
                    url : url,
                    success : function(data){
                        if(data.resultCode == 1) {
                            Qa.searchList();
                        } else {
                            $.alert(data.comment);
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            saveChoice : function(voteLiObj){
                var replyId = $(voteLiObj).closest('.thread').attr('data-qa-reply-id');
                $.ajax({
                    type : 'POST',
                    data : {qaId : $('[name=qaId]').val(),
                        replyId : replyId},
                    url : '/qa/saveReplyChoice',
                    success : function(data){
                        if(data.resultCode == 1) {
                            Qa.searchList();
                        } else {
                            $.alert(data.data);
                        }
                    },
                    error : function(XMLHttpRequest,textStatus,errorThrown){
                        alert(errorThrown);
                    }
                });
            },
            getQaReplyId : function(obj){
                var popoverId = $(obj).closest('.popover').attr('id');
                var qaReplyId = $('.thread .config').find('[aria-describedby='+ popoverId +']').closest('.thread').attr('data-qa-reply-id');
                return qaReplyId;
            },
            qaReplyDelete : function(obj){
                var qaReplyId = Qa.getQaReplyId(obj);
                if (!confirm("댓글을 삭제하시겠습니까?")) {
                    return;
                }
                $.post('/qa/reply/delete/' + qaReplyId)
                    .done(function (response) {
                        if (response.resultCode != 1) {
                            alert(response.comment);
                            return;
                        }
                        Qa.searchList();
                    }).fail(function () {
                        alert('Error delete Qa Reply');
                    });
            },
            refrashRecommendCount : function(recommendCount, nonrecommendCount){
                $('.qna-content').find('.like-count').text('('+recommendCount+')');
                $('.qna-content').find('.claim-count').text('('+nonrecommendCount+')');
            },
            refrashRecommendTooltip : function(recommendList, nonRecommendList){
                var upUserNick = '';
                var downUserNick = '';
                $(recommendList).each(function(){
                    upUserNick += this.userNick + '<br>';
                });
                $(nonRecommendList).each(function(){
                    downUserNick += this.userNick + '<br>';
                });

                var recommendObj = $('.qna-content .fa-thumbs-o-up');
                var nonRecommendObj = $('.qna-content .fa-thumbs-o-down');
                recommendObj.attr('data-original-title', upUserNick);
                nonRecommendObj.attr('data-original-title', downUserNick);
            },
            refrashSelfRecommend : function (selfRecommend, selfNonrecommend) {
                $('.qna-content > i').removeClass('fa-2x');
                if(selfRecommend){
                    $('.qna-content .fa-thumbs-o-up').addClass('fa-2x');
                }
                if(selfNonrecommend){
                    $('.qna-content .fa-thumbs-o-down').addClass('fa-2x');
                }
            },
            modifyReply : function (obj) {
                var qaReplyId = Qa.getQaReplyId(obj);
                // 기능구현 필요
                this.getReplyMarkUp(qaReplyId);

            },
            getReplyMarkUp : function (qaReplyId) {
                $.get("/qa/getReplyMarkUp",{replyId : qaReplyId}, function (response) {
                    if(response.resultCode != 1) {
                        alert(response.comment);
                        return;
                    } else {
                        Qa.setReplyData(response.data);
                        $('#cancleReplyButton').removeClass('hide');
                        $("html, body").animate({
                            'scrollTop' : $('[name=qaReplyForm]').offset().top
                        }, 500);
                    }
                });
            },
            setReplyData : function(qaReplyData){
                $('[name=qaReplyForm] .form-group').attr('data-reply-id',qaReplyData.replyId);
                $('[name=qaReplyForm] #title').val(qaReplyData.title);
                $('#wikiEditor').val(qaReplyData.contentsMarkup);
                $('.dualEditor-preview').html(qaReplyData.contents);
            },
            cancleReplyButtonEvent : function () {
                $("#cancleReplyButton").on("click", this.cancleReplyButton);
            },
            cancleReplyButton : function () {
                $('#cancleReplyButton').addClass('hide');
                $('[name=qaReplyForm] .form-group').removeAttr('data-reply-id');
                $('[name=qaReplyForm] #title').val('');
                $('#wikiEditor').val('');
                $('.dualEditor-preview').html('');
            }
        };

        var ConfirmDialog = {
            deleteConfirm : function(){
                $.confirm({
                    title: '확인',
                    content: '질문을 삭제하시겠습니까?',
                    confirmButton: '질문삭제',
                    cancelButton: '취소',
                    confirmButtonClass: 'btn-info',
                    confirm: function () {
                        Qa.deleteContents();
                    },
                    cancel: function(){
                        return true;
                    }
                });
            },
            successConfirm : function(){
                $.confirm({
                    title: '완료',
                    content: '삭제 완료 ',
                    confirmButton: '이동',
                    cancelButton: '취소',
                    confirmButtonClass: 'btn-info',
                    icon: 'fa fa-question-circle',
                    animation: 'top',
                    confirm: function () {
                        location.href = "/qa/main";
                    }
                });
            }
        }

    </script>
{{/partial}}

{{> template/base}}