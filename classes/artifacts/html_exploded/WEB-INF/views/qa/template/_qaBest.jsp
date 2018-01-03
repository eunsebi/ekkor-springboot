{{#unless bestQAContents}}
    <div class="best-qna-item">
        최근에 작성된 Q&A가 없습니다.
    </div>
{{/unless}}

{{#each bestQAContents}}
    <div class="best-qna-item">
        <div>
            <strong> <a class="form" href="/qa/{{qaId}}">{{{abbreviate (htmlDelete title) 30}}}</a></strong>
            <span class="comments pull-right"><i class="glyphicon glyphicon-comment"></i> {{replyCnt}}</span>
            <br>{{> common/_keywordBadge}}
        </div>
        <div class="media">
            <a class="pull-left" href="#">
                <div class="user-profile">
                    <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                </div>
            </a>
            <div class="media-body best-qna-item-body">
                {{subString (htmlDelete contents) 0 78 }}
            </div>
            <div class="user-profile-sm">
                <span class="nickname"><i class="fa fa-pencil-square-o"></i> {{userNick}}</span>
            </div>
            <div class="pull-right"><i class="fa fa-clock-o"></i> {{formatDate insertDate "yyyy-MM-dd hh:MM"}}</div>
        </div>
    </div>
{{/each}}
