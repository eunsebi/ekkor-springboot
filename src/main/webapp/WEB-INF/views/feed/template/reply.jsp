<li class="reply-thread" data-feed-reply-id="{{feedReplyId}}">
    <div class="author">
        <div class="user-profile-sm">
            <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" />
        </div>
    </div>
    <div class="name">{{userNick}}</div>
    <div class="date">{{insertDate}}</div>
    <div class="config" onclick="FeedReply.removeItem(this)"><i class="fa fa-close feedReplyDeleteBtn"></i></div>
    <div class="message-box">
        <div class="message">{{feedReplyContent}}</div>
        <div class="action-buttons">
            <i class="fa fa-thumbs-o-up {{#if likeFeedAction.hasActor}}hasActor{{/if}}" onclick="FeedReply.like(this)" title="좋아요">
                <span class="like-count">({{likeFeedAction.count}})</span>
            </i>
            <i class="fa fa-bullhorn {{#if claimFeedAction.hasActor}}hasActor{{/if}}" onclick="FeedReply.claim(this)" title="신고하기">
                <span class="claim-count">({{claimFeedAction.count}})</span>
            </i>
        </div>
    </div>
</li>
