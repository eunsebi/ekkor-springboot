{{#if spaceActivityLists}}
    {{#each spaceActivityLists}}
        <div class="media" style="padding-left:15px">
            <a href="#" class="pull-left">
                <div class="user-profile-sm">
                    <img alt="avatar" class="profile-image" src="/imageView?path={{user.userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                </div>
            </a>

            <div class="media-body" style="font-size:13px">
                <span class="pull-left"><u><i>{{activity.activityDesc}}</i></u></span>
                <span class="pull-right">{{formatDate activity.insertDate "yyyy-MM-dd hh:MM:ss"}}</span>
            </div>
        </div>
    {{/each}}
    <small><cite title="Source Title">더보기</cite></small>

{{^}}
    <div class="media">
        <div class="media-body">
            활동 내역이 존재하지 않습니다.
        </div>
    </div>
{{/if}}