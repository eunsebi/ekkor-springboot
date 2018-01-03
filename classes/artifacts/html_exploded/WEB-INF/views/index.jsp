{{# partial "content" }}
    <div class="index-container">
    {{#with displayIndex}}
        <div class="container-fluid">
            <div class="col-sm-12" style="margin-top: -20px;">
                <div class="col-sm-12">
                    {{#if notice.empty}}
                    <div class="index-thread-box first">
                        <h3 class="page-header"><i class="glyphicon glyphicon-volume-up"></i> 공지사항</h3>
                        <div class="index-thread-item" style="cursor: pointer;">
                            공지사항이 존재하지 않습니다.
                        </div>
                        <div style="border-bottom:1px solid #eee">&nbsp; </div>
                    </div>
                    {{/if}}
                    {{#unless notice.empty}}
                    <div class="index-thread-box first">
                        <a href="{{notice.moreUrl}}">
                            <span class="label label-default pull-right notice-more">more</span>
                        </a>
                        <h3 class="page-header"><i class="glyphicon glyphicon-volume-up"></i> {{notice.title}}</h3>
                        <div class="index-thread-item" style="cursor: pointer;">
                            <div class="title" style="margin-top: 10px;">
                                <a href="{{notice.viewUrl}}">{{{abbreviate (htmlDelete notice.contents) 300}}}</a>
                                <span class="comments"><i class="glyphicon glyphicon-comment"></i> {{notice.countOfReply}}</span>
                                <div class="pull-right"><i class="fa fa-clock-o"></i> {{notice.insertDate}}</div>
                            </div>
                        </div>
                        <div style="border-bottom:1px solid #eee">&nbsp; </div>
                    </div>
                    {{/unless}}
                </div>
            </div>
    
            <!--center-->
            <div class="col-sm-8" style="margin-top: -10px;">
                <div class="col-sm-12">
                    <div class="index-thread-box first">
                        <h3 class="page-header"><i class="glyphicon glyphicon-question-sign"></i> Q&amp;A</h3>
                        {{#each qaContents}}
                        <div class="index-thread-item">
                            <div class="title"><strong>{{{abbreviate (htmlDelete title) 30}}}</strong></div>
                            <div class="pull-right">
                                {{#each keywords}}
                                    {{{keywordBadge name}}}
                                {{/each}}
                            </div>
                            <div class="media">
                                <div class="pull-left">
                                    <div class="user-profile">
                                        <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                                    </div>
                                </div>
                                <div class="media-body">
                                    <a href="/qa/{{qaId}}">{{{abbreviate (htmlDelete contents) 200}}}</a>
                                    <span class="comments"><i class="glyphicon glyphicon-comment"></i> {{countOfReply}}</span>
                                </div>
                                <div class="pull-left"><span class="nickname">{{userNick}}</span></div>
                                <div class="pull-right"><i class="fa fa-clock-o"></i> {{insertDate}}</div>
                            </div>
                        </div>
                        {{/each}}
                    </div>
                </div>
                <div class="col-sm-6" >
                    <h3 class="page-header"><i class="fa fa-database"></i> Space</h3>
                    {{#each spaces}}
                    <div class="panel panel-default">
                        <div class="panel-heading"><strong>{{{abbreviate (htmlDelete title) 30}}}</strong></div>
                        <div class="panel-body">
                            <a href="/space/{{spaceId}}">{{{abbreviate (htmlDelete description) 70}}}</a>
                        </div>
                    </div>
                    {{/each}}
               </div>
                <div class="col-sm-6">
                    <h3 class="page-header"><i class="glyphicon glyphicon-book"></i> Wiki</h3>
                    {{#each wikies}}
                        <div class="panel panel-default">
                            <div class="panel-heading"><strong>{{{abbreviate (htmlDelete title) 30}}}</strong></div>
                            <div class="panel-body">
                                <a href="/wiki/{{wikiId}}">{{{ abbreviate (htmlDelete description) 70}}}</a>
                            </div>
                        </div>
                    {{/each}}
                </div>
            </div>

            <div class="col-sm-4" style="margin-top: -10px;">
                <div class="index-thread-box first col-sm-12">
                    <h3 class="page-header"><i class="fa fa-weixin"></i> Feed</h3>
                    {{#each feeds}}
                    <div class="index-thread-item">
                        <div class="media">
                            <div class="pull-left">
                                <div class="user-profile">
                                    <img alt="avatar" class="profile-image" src="/imageView?path={{userImage}}" onerror='this.src="/resource/images/avatar.png"'  />
                                </div>
                            </div>
                            <div class="media-body">
                                <a href="/feed/{{feedThreadId}}">{{{abbreviate (htmlDelete feedContent) 40}}}</a>
                                <span class="comments pull-right"><i class="glyphicon glyphicon-comment"></i> {{countOfReply}}</span>
                            </div>
                            <div class="pull-left"><span class="nickname">{{userNick}}</span></div>
                        </div>
                    </div>
                    {{/each}}
                </div>
            </div>
        </div>
    </div>
    {{/with}}
    </div>
{{/partial}}

{{> template/base}}
