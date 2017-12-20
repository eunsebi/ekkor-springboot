{{# partial "title" }}Feed View{{/partial}}

{{# partial "content" }}
<div class="container">
    <div class="col-md-12 col-xs-12">
    {{#if displayFeed.empty}}
        <div class="feed well text-center">
            해당 Feed가 존재하지 않습니다.
        </div>
    {{/if}}

    {{#unless displayFeed.empty}}
        {{#with displayFeed}}
        <div class="feed well">
            <ul id="feedList">
                <li class="thread" data-feed-thread-id="{{feedThreadId}}">
                    <div class="author">
                        <div class="user-profile">
                            <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                        </div>
                    </div>
                    <div class="name">{{userNick}}</div>
                    <div class="date">{{insertDate}}</div>
                    {{#if writer}}
                        <div class="config">
                            <i class="fa fa-check popover-config" data-container="body" data-toggle="popover"
                               data-placement="right" tabindex="0"></i>
                        </div>
                    {{/if}}
                    <div class="thread-message-box">
                        <div class="message">
                            <div class="feed-contents-box">{{{feedContent}}}</div>
                            <div class="feed-modify well">
                                <form class="feed-modify-form">
                                    <input type="hidden" name="feedThreadId" value="{{feedThreadId}}"/>
                                    <textarea class="form-control" name="feedContent" rows="6">{{originFeedContent}}</textarea>
                                    <div class="feed-modify-bottom">
                                        <button class="btn btn-sm btn-info pull-right modifyBtn" type="button">수정</button>
                                        <button class="btn btn-sm btn-default pull-right cancelBtn" type="button">취소</button>
                                    </div>
                                </form>
                            </div>
                            <div class="images text-center">
                                {{#each images}}
                                    <a href="/imageView?path={{fullPath}}"
                                       data-toggle="lightbox" data-title="Feed Image Viewer"
                                       data-gallery="feed-images-{{../feedThreadId}}"><img width="190" class="img-thumbnail" src="/imageView?path={{fullPath}}" /></a>
                                {{/each}}
                            </div>
                            <div class="attachment">
                                {{#each files}}
                                    <a href="/download?path={{fullPath}}">
                                        <i class="fa fa-file-o"></i> {{realName}}
                                    </a>&nbsp;
                                {{/each}}
                            </div>
                        </div>
                        <div class="action-buttons">
                            <i class="fa fa-thumbs-o-up {{#if likeFeedAction.hasActor}}hasActor{{/if}}"
                               onclick="Feed.like(this)" title="좋아요">
                                <span class="like-count">({{likeFeedAction.count}})</span>
                            </i>
                            <i class="fa fa-bullhorn {{#if claimFeedAction.hasActor}}hasActor{{/if}}"
                               onclick="Feed.claim(this)" title="신고하기">
                                <span class="claim-count">({{claimFeedAction.count}})</span>
                            </i>
                        </div>
                    </div>

                    <ul class="feed-replies">
                        {{#each replies}}
                            <li class="reply-thread" data-feed-reply-id="{{feedReplyId}}">
                                <div class="author">
                                    <div class="user-profile-sm">
                                        <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                                    </div>
                                </div>
                                <div class="name">{{userNick}}</div>
                                <div class="date">{{insertDate}}</div>
                                {{#if writer}}
                                    <div class="config" onclick="FeedReply.removeItem(this)">
                                        <i class="fa fa-close feedReplyDeleteBtn"></i>
                                    </div>
                                {{/if}}
                                <div class="message-box">
                                    <div class="message">{{feedReplyContent}}</div>
                                    <div class="action-buttons">
                                        <i class="fa fa-thumbs-o-up {{#if likeFeedAction.hasActor}}hasActor{{/if}}"
                                           onclick="FeedReply.like(this)" title="좋아요">
                                            <span class="like-count">({{likeFeedAction.count}})</span>
                                        </i>
                                        <i class="fa fa-bullhorn {{#if claimFeedAction.hasActor}}hasActor{{/if}}"
                                           onclick="FeedReply.claim(this)" title="신고하기">
                                            <span class="claim-count">({{claimFeedAction.count}})</span>
                                        </i>
                                    </div>
                                </div>
                            </li>
                        {{/each}}
                    </ul>

                    <ul>
                        <li>
                            <div class="row">
                                <form name="feedReplyForm" onsubmit="return false;">
                                    <input type="hidden" name="feedThread.feedThreadId" value="{{feedThreadId}}"/>
                                    <div class="col-xs-9 col-md-10">
                                        <input type="text" name="feedReplyContent" class="form-control input-sm"
                                               placeholder="댓글 입력">
                                    </div>
                                    <div class="col-xs-3 col-md-2 feed-comment">
                                        <button class="btn btn-sm btn-info" name="saveReply" type="submit">저장</button>
                                    </div>
                                </form>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        {{/with}}
    {{/unless}}
    </div>
</div>
<!-- popover-config start -->
<div id="popover-config-content" style="display: none;">
    <div class="button"><a href="javascript:void(0);" onclick="Feed.modifyItem(this);">수정</a></div>
    <div class="button"><a href="javascript:void(0);" onclick="Feed.removeItem(this, '/feed');">삭제</a></div>
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
            Feed.bindImageGallery();
            FeedReply.init();
            FeedUtil.bindPopOver();
        });
    </script>
{{/partial}}

{{> template/base}}

{{embedded "feed/template/reply"}}
