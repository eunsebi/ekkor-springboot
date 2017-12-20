{{#if resecntWiki}}
    {{#each resecntWiki}}
        <!-- 최근 활동 -->
        <div class="best-qna-item">
            <div>
                {{#each keywords}}
                    {{#keywordBadge keywordName}}{{/keywordBadge}}
                {{/each}}
                <strong> {{wiki.title}}</strong>
                <span class="comments pull-right"><i class="glyphicon glyphicon-comment"></i> {{wiki.replyCount}}</span>
            </div>
            <div class="media">
                <a class="pull-left" href="#">
                    <div class="user-profile">
                        <img alt="avatar" class="profile-image" src="/imageView?path={{user.userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                    </div>
                </a>
                <div class="media-body">
                    <div>
                        <a class="form" href="/wiki/{{wiki.wikiId}}">
                            {{{subString (htmlDelete wiki.contents) 0 50 }}}
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- 최근 활동 -->
    {{/each}}

    <div class="pull-right" style="padding-top:10px"><button id="resentAddBtn" class="btn btn-sm btn-default btn-sm-fixed">더보기</button></div>

{{^}}
    <div class="best-qna-item">
        최근 활동이 없습니다.
    </div>
{{/if}}