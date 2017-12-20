{{#each data.qaReplyChoice}}
    <div class="bs-callout bs-callout-danger">
        <div class="bg-info qna-reply-title"><span class="qna-reply-title">{{qaReply.title}}</span></div>
        <div class="feed well">
            <ul>
                <li class="thread" data-qa-reply-id="{{qaReply.replyId}}">
                    <div class="author">
                        <div class="user-profile">
                            <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"'/>
                        </div>
                    </div>
                    <div class="name">{{userNick}}</div>
                    <div class="date">{{qaReply.insertDate}}</div>
                    <div class="config"><i class="fa fa-check popover-config" tabindex="0" data-container="body" data-toggle="popover" data-placement="right"></i></div>

                    <div class="thread-message-box">
                        <div class="message">
                            {{{qaReply.contents}}}
                        </div>
                        <div class="action-buttons">
                            <div class="qna-reply-icon">
                                <i class="reply-choice fa fa-thumb-tack {{#xif qaReply.choice '==' true}}fa-2x{{/xif}}">
                                    <span>답변선택</span>
                                </i>
                                <i class="reply-recommend fa fa-thumbs-o-up {{#xif selfRecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="UP" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each votes}}{{userNick}}<br>{{/each}}">
                                    <span class="like-count">({{qaReply.voteUpCount}})</span>
                                </i>
                                <i class="reply-recommend fa fa-thumbs-o-down {{#xif selfNonrecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="DOWN" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each nonVotes}}{{userNick}}<br>{{/each}}">
                                    <span class="claim-count">({{qaReply.voteDownCount}})</span>
                                </i>
                            </div>
                        </div>
                    </div>

                    <ul>
                        {{#each qaReplies}}
                            <li class="thread" data-qa-reply-id="{{qaReply.replyId}}">
                                <div class="author">
                                    <div class="user-profile-sm">
                                        <img alt="avatar" class="profile-image" src="/imageView?path={{qaReply.userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                                    </div>
                                </div>
                                <div class="name">{{qaReply.userNick}}</div>
                                <div class="date">{{qaReply.insertDate}}</div>
                                {{#if writer}}
                                    <div class="config"><i class="fa fa-close qaReplyDeleteBtn" data-qa-reply-id="{{qaReply.replyId}}"></i></div>
                                {{/if}}
                                <div class="message-box">
                                    <div class="message">{{qaReply.contents}}</div>
                                    <div class="action-buttons">
                                        <div class="qna-reply-icon">
                                            <i class="reply-recommend fa fa-thumbs-o-up {{#xif selfRecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="UP" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each votes}}{{userNick}}<br>{{/each}}">
                                                <span class="like-count">({{qaReply.voteUpCount}})</span>
                                            </i>
                                            <i class="reply-recommend fa fa-thumbs-o-down {{#xif selfNonrecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="DOWN" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each nonVotes}}{{userNick}}<br>{{/each}}">
                                                <span class="claim-count">({{qaReply.voteDownCount}})</span>
                                            </i>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        {{/each}}
                    </ul>

                    <ul class="input-reply-area">
                        <li>
                            <div class="row">
                                <form name="qaChildReplyForm" onsubmit="return false;">
                                    <input type="hidden" name="qaId" value="{{qaReply.qaId}}" />
                                    <input type="hidden" id="title" name="title" value="RE:{{qaReply.title}}" />   <!-- 답변 계층 -->
                                    <input type="hidden" id="orderIdx" name="orderIdx" value="{{qaReply.orderIdx}}" />   <!-- 답변 계층 -->
                                    <input type="hidden" id="depthIdx" name="depthIdx" value="{{qaReply.depthIdx}}" />   <!-- 답변 계층 -->
                                    <input type="hidden" id="parentsId" name="parentsId" value="{{qaReply.replyId}}" />   <!-- 답변 계층 -->

                                    <div class="col-xs-9 col-md-10">
                                        <input type="text" name="contents" class="form-control input-sm" placeholder="댓글 입력">
                                    </div>
                                    <div class="col-xs-3 col-md-2 feed-comment">
                                        <button class="btn btn-sm btn-info" name="saveChildReplyButton" type="button">저장</button>
                                    </div>
                                </form>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
{{/each}}

{{#each data.qaReplyList}}
    <div class="bg-info qna-reply-title"><span class="qna-reply-title">{{qaReply.title}}</span></div>
    <div class="feed well">
        <ul>
            <li class="thread" data-qa-reply-id="{{qaReply.replyId}}">
                <div class="author">
                    <div class="user-profile">
                        <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"'/>
                    </div>
                </div>
                <div class="name">{{userNick}}</div>
                <div class="date">{{qaReply.insertDate}}</div>
                <div class="config"><i class="fa fa-check popover-config" tabindex="0" data-container="body" data-toggle="popover" data-placement="right"></i></div>

                <div class="thread-message-box">
                    <div class="message">
                        {{{qaReply.contents}}}
                    </div>
                    <div class="action-buttons">
                        <div class="qna-reply-icon">
                            <i class="reply-choice fa fa-thumb-tack {{#xif qaReply.choice '==' true}}fa-2x{{/xif}}">
                                <span>답변선택</span>
                            </i>
                            <i class="reply-recommend fa fa-thumbs-o-up {{#xif selfRecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="UP" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each votes}}{{userNick}}<br>{{/each}}">
                                <span class="like-count">({{qaReply.voteUpCount}})</span>
                            </i>
                            <i class="reply-recommend fa fa-thumbs-o-down {{#xif selfNonrecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="DOWN" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each nonVotes}}{{userNick}}<br>{{/each}}">
                                <span class="claim-count">({{qaReply.voteDownCount}})</span>
                            </i>
                        </div>
                    </div>
                </div>

                <ul>
                    {{#each qaReplies}}
                        <li class="thread" data-qa-reply-id="{{qaReply.replyId}}">
                            <div class="author">
                                <div class="user-profile-sm">
                                    <img alt="avatar" class="profile-image" src="/imageView?path={{qaReply.userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                                </div>
                            </div>
                            <div class="name">{{qaReply.userNick}}</div>
                            <div class="date">{{qaReply.insertDate}}</div>
                            {{#if writer}}
                                <div class="config"><i class="fa fa-close qaReplyDeleteBtn" data-qa-reply-id="{{qaReply.replyId}}"></i></div>
                            {{/if}}
                            <div class="message-box">
                                <div class="message">{{qaReply.contents}}</div>
                                <div class="action-buttons">
                                    <div class="qna-reply-icon">
                                        <i class="reply-recommend fa fa-thumbs-o-up {{#xif selfRecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="UP" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each votes}}{{userNick}}<br>{{/each}}">
                                            <span class="like-count">({{qaReply.voteUpCount}})</span>
                                        </i>
                                        <i class="reply-recommend fa fa-thumbs-o-down {{#xif selfNonrecommend '==' true}}fa-2x{{/xif}}" data-qa-vote-type="DOWN" data-toggle="tooltip" data-html="true" data-placement="top" title="{{#each nonVotes}}{{userNick}}<br>{{/each}}">
                                            <span class="claim-count">({{qaReply.voteDownCount}})</span>
                                        </i>
                                    </div>
                                </div>
                            </div>
                        </li>
                    {{/each}}
                </ul>

                <ul class="input-reply-area">
                    <li>
                        <div class="row">
                            <form name="qaChildReplyForm" onsubmit="return false;">
                                <input type="hidden" name="qaId" value="{{qaReply.qaId}}" />
                                <input type="hidden" id="title" name="title" value="RE:{{qaReply.title}}" />   <!-- 답변 계층 -->
                                <input type="hidden" id="orderIdx" name="orderIdx" value="{{qaReply.orderIdx}}" />   <!-- 답변 계층 -->
                                <input type="hidden" id="depthIdx" name="depthIdx" value="{{qaReply.depthIdx}}" />   <!-- 답변 계층 -->
                                <input type="hidden" id="parentsId" name="parentsId" value="{{qaReply.replyId}}" />   <!-- 답변 계층 -->

                                <div class="col-xs-9 col-md-10">
                                    <input type="text" name="contents" class="form-control input-sm" placeholder="댓글 입력">
                                </div>
                                <div class="col-xs-3 col-md-2 feed-comment">
                                    <button class="btn btn-sm btn-info" name="saveChildReplyButton" type="button">저장</button>
                                </div>
                            </form>
                        </div>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
{{/each}}

<script type="text/javascript">
    $(function(){
        $('.popover-config').popover({
            html: true,
            trigger: 'focus',
            content: function () {
                return $('#popover-config-content').html();
            }
        });

        var QaReply = {
            init: function(){
                this.bindDelete();
                Qa.saveChildReplyEvent();
                Qa.saveVoteEvent();
                Qa.saveChoiceEvent();
                this.tooltipEvent();
            },
            bindDelete: function() {
                $('.qaReplyDeleteBtn').click(function () {
                    Qa.qaReplyDelete($(this).closest('.thread').attr('data-qa-reply-id'));
                });
            },
            tooltipEvent : function(){
                $('.qna-reply [data-toggle="tooltip"]').tooltip();
            }
        };

        QaReply.init();
    });
</script>