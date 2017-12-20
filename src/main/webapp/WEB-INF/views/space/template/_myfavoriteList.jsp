{{#if myFavoriteSpaceList}}
    {{#each myFavoriteSpaceList}}
    <div class="best-qna-item">
        <div>
            {{> common/_keywordBadge}}
            <strong> <a class="form" href="/space/{{spaceId}}">{{title}}</a></strong>
        </div>
        <div class="media">
            <a class="pull-left" href="#">
                <div class="user-profile">
                    <img alt="avatar" class="profile-image" src="/imageView?path={{titleImagePath}}/{{titleImage}}" />
                </div>
            </a>
            <div class="media-body">
                {{subString (htmlDelete description) 0 70 }}
                <div class="pull-right"><span class="badge">{{wikiCount}}</span></div>
            </div>
            <div class="user-profile-sm">

            </div>
            <div class="pull-left"><span class="nickname"><i class="fa fa-pencil-square-o"></i> {{insertUserNick}}</span></div>
            <div class="pull-right"><i class="fa fa-clock-o"></i> {{updateDate}}</div>

        </div>
    </div>
    {{/each}}
{{^}}
    <div class="best-qna-item">
        즐겨찾기 공간이 없습니다.
    </div>
{{/if}}