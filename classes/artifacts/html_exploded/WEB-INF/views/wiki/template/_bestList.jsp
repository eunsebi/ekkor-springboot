{{#if bestWikiList}}
    {{#each bestWikiList}}
        <div class="best-qna-item">
            <div>
                <strong> <a class="form" href="/wiki/{{wiki.wikiId}}">{{wiki.title}}</a></strong>
                <span class="comments pull-right"><i class="glyphicon glyphicon-comment"></i> {{wiki.replyCount}}</span>
                <br>
                {{#each keywords}}
                    {{#keywordBadge keywordName}}{{/keywordBadge}}
                {{/each}}
            </div>
            <div class="media">
                <a class="pull-left" href="#">
                    <div class="user-profile">
                        <img alt="avatar" class="profile-image" src="/imageView?path={{user.userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                    </div>
                </a>
                <div class="media-body">
                    {{subString (htmlDelete wiki.contents) 0 78 }}
                    <!-- TODO 위키 리플갯수  추후 구해와야 함
                    <div class="pull-right"><span class="badge">{{replyCount}}</span></div>
                    -->
                </div>
                <div class="user-profile-sm">
                    <span class="nickname"><i class="fa fa-pencil-square-o"></i> {{wiki.insertUserNick}}</span>
                </div>
                <div class="pull-right"><i class="fa fa-clock-o"></i>{{formatDate wiki.insertDate "yyyy-MM-dd hh:MM"}}</div>
            </div>
        </div>
    {{/each}}
    <div class="pull-right" style="padding-top:10px"><button id="bestAddBtn" class="btn btn-sm btn-default btn-sm-fixed">더보기</button></div>
{{^}}
    <div class="best-qna-item">
        베스트 위키가 없습니다.
    </div>
{{/if}}