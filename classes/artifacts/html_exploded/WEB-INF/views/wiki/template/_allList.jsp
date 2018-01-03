{{#each allWiki}}
    <div class="media qna-item">
        <a class="pull-left" style="cursor: pointer">
            <div class="user-profile">
                <img src="/imageView?path={{user.userImage}}" class="profile-image" alt="avatar" onerror='this.src="/resource/images/avatar.png"'>
            </div>
        </a>
        <div class="row">
            <div class="col-xs-8 col-sm-8 col-md-8">
                <div class="media-body">
                    <div class="media-heading">
                        <strong> <a class="form" href="/wiki/{{wiki.wikiId}}">{{wiki.title}}</a></strong>
                        <span class="my-qna-writer pull-right">
                            <div class="user-profile-xs">
                                <span class="nickname"><i class="fa fa-pencil-square-o"></i> {{user.insertUserNick}}</span>
                            </div>
                        </span>
                        <br>
                        {{#each keywords}}
                            {{#keywordBadge keywordName}}{{/keywordBadge}}
                        {{/each}}
                    </div>
                    <div>
                        {{subString (htmlDelete wiki.contents) 0 80 }}
                        <span class="pull-right"><i class="fa fa-clock-o"></i>{{formatDate wiki.insertDate "yyyy-MM-dd hh:MM"}}</span>
                    </div>
                </div>
            </div>
            <div class="col-xs-1 col-sm-1 col-md-1">
                <ul class="nav nav-pills nav-stacked ">
                    <li><button class="btn btn-sm btn-default btn-sm-fixed">댓글 {{wiki.replyCount }}</button></li>
                    <li><button class="btn btn-sm btn-default btn-sm-fixed">추천 {{wiki.likeCount }}</button></li>
                </ul>
            </div>
        </div>
    </div>
{{/each}}
<div class="top-buffer">&nbsp;</div>