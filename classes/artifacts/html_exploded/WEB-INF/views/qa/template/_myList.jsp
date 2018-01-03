{{#unless data}}
    <div class="best-qna-item">
        작성된 Q&A가 없습니다.
    </div>
{{/unless}}

{{#each data}}
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
            <a class="pull-left" href="#">
                <div class="user-profile">
                    <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}"  onerror='this.src="/resource/images/avatar.png"'/>
                </div>
            </a>
            <div class="row">
                <div class="col-lg-9">
                    <div class="media-body">
                        {{subString (htmlDelete contents) 0 150 }}
                        <span class="badge">{{replyCnt}}</span>
                    </div>
                </div>
                <div class="col-lg-1 pull-right" style="margin-right: 15px;">
                    <div class="my-qna-rating">
                        <button class="btn btn-sm btn-default btn-sm-fixed">조회 {{viewCount}}</button>
                        <button class="btn btn-sm btn-default btn-sm-fixed">추천 {{recommendCount}}</button>
                    </div>
                </div>
            </div>
            <div class="pull-left"><span class="nickname"><i class="fa fa-pencil-square-o"></i> {{userNick}}</span></div>
            <div class="pull-right"><i class="fa fa-clock-o"></i> {{formatDate insertDate "yyyy-MM-dd hh:MM"}}</div>
        </div>
    </div>

{{/each}}