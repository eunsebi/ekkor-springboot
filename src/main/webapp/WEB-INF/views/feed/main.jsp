{{# partial "title" }}Feed{{/partial}}

{{# partial "content" }}
<div class="container">
    <div class="col-md-12 col-xs-12">
        <form id="feedForm">
            <div class="feed feed-write well">
                <ul>
                    <li>
                        <div class="author">
                            <div class="user-profile">
                                <img alt="avatar" class="profile-image" src="{{#if isLogin}}/imageView?path={{loggedUser.userImage}}{{else}}/resource/images/avatar.png{{/if}}" />
                            </div>
                        </div>
                        <div class="write-box">
                            <textarea class="form-control" name="feedContent" rows="6" placeholder="오늘 있었던 일을 동료와 공유해주세요"></textarea>
                        </div>
                        <div class="attachmentArea">
                            <div class="images text-left"></div>
                            <div class="files">&nbsp;</div>
                        </div>
                    </li>
                </ul>

                <div class="feed-write-bottom">
                    <button class="btn btn-primary btn-feed-image" type="button" data-toggle="modal" data-target="#fileUploadModal">이미지 및 파일첨부</button>
                    <button class="btn btn-info pull-right btn-feed-save" type="button" id="feedSave">저장</button>
                </div>
            </div>
        </form>

        <div class="feed well">
            <ul id="feedList">
                {{> feed/template/list}}
            </ul>
            <button class="btn btn-default form-control btn-feed-more" type="button" id="feedMoreBtn">more</button>

            {{#unless data}}
                <div class="text-center" id="emptyFeedMore">
                    등록된 Feed가 존재하지 않습니다.
                </div>
            {{/unless}}
        </div>
    </div>
</div>

<!-- file upload start -->
<div class="modal fade" id="fileUploadModal" tabindex="-1" role="dialog" aria-hidden="true" aria-labelledby="fileUploadModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="fileUploadModalLabel">이미지 및 파일 첨부</h4>
            </div>
            <div class="modal-body">
                <div class="feed well">
                    <form class="form-horizontal attachmentForm" role="form" id="feedFileForm">
                        <div class="form-group">
                            <input id="uploadfile" type="file" name="uploadfile" accept="*" style="display:none">
                            <label for="fileAttachmentInput" class="col-sm-2 control-label">첨부파일</label>

                            <div class="col-sm-10 col-md-10">
                                <div class="row">
                                    <div class="col-sm-9 col-xs-9 col-md-9">
                                        <input id="fileAttachmentInput" class="form-control" type="text" />
                                    </div>
                                    <div class="col-sm-3 col-xs-3 col-md-3">
                                        <button class="btn btn-info btn-default" type="button" onclick="$('#uploadfile').click();">선택</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- file upload modal end -->
<!-- popover-config start -->
<div id="popover-config-content" style="display: none;">
    <div class="button"><a href="javascript:void(0);" onclick="Feed.modifyItem(this);">수정</a></div>
    <div class="button"><a href="javascript:void(0);" onclick="Feed.removeItem(this);">삭제</a></div>
</div>

<!-- popover-config end -->
{{/partial}}

{{# partial "style" }}
    <link rel="stylesheet" href="/resource/public/ekko-lightbox/ekko-lightbox.min.css">
    <link rel="stylesheet" href="/resource/public/ekko-lightbox/dark-theme.css">
{{/partial}}

{{# partial "script-page" }}
    <script src="/resource/public/ekko-lightbox/ekko-lightbox.min.js"></script>
    <script type="text/javascript" src="/resource/app/js/feed/app.js"></script>
    <script type="text/javascript">
        $(function(){
            Feed.init();
            FeedPager.init(FeedList.getSize(), Feed.moreList);
        });
    </script>
{{/partial}}

{{> template/base}}
{{embedded "feed/template/list"}}
{{embedded "feed/template/reply"}}

