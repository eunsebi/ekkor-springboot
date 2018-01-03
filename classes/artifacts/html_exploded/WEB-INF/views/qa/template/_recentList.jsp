{{#unless recentQAContents}}
    <div class="best-qna-item">
        최근에 작성된 Q&A가 없습니다.
    </div>
{{/unless}}

{{#each recentQAContents}}
    <div class="best-qna-item">
        <div>
            <strong><a href="/qa/{{qaId}}">{{title}}</a></strong>
            <div class="pull-right">
                {{#each keywords}}
                    {{#keywordBadge keywordName}}{{/keywordBadge}}
                {{/each}}
            </div>
        </div>
        <div class="media">
            <div class="user-profile pull-left">
                <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"'/>
            </div>
            <div class="row media-body">
                {{subString (htmlDelete contents) 0 150 }}
                <span class="badge">{{replyCnt}}</span>
            </div>
            <div class="pull-left">
                <span class="nickname"><i class="fa fa-pencil-square-o"></i> {{userNick}}</span>
                <!--<span class="comments"><i class="fa fa-eye"></i> {{viewCount}}</span>-->
            </div>
            <div class="pull-right">
                <span class="recommends"><i class="fa fa-thumbs-o-up"></i> {{recommendCount}}</span>
                <span class="insertDate"><i class="fa fa-clock-o"></i> {{formatDate insertDate "yyyy-MM-dd hh:MM"}}</span>
            </div>
        </div>
    </div>
{{/each}}