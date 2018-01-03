<!--
  Created by IntelliJ IDEA.
  User: yong
  Date: 2014. 9. 22.
  Time: 오후 10:57
-->

{{# partial "content" }}

<!-- contents -->
<div class="container-fluid">
    <div class="col-sm-12">

        {{> search/form/qa}}

        <div class="btn-group pull-right">
            <a href="/qa/total/list" class="btn btn-primary">총 질문({{qaTotalCount}})</a>
            <a href="/qa/wait_reply/list" class="btn btn-primary">답변을 기다리는 Q&A({{qaNotReplyedCount}})</a>
            {{#if isLogin}}
                <a href="/my/qa" class="btn btn-primary">내 QA 목록</a>
                <a href="/qa/form" class="btn btn-primary">질문하기</a>
            {{/if}}
        </div>
    </div>

    <div class="col-sm-12 top-buffer">
        <!-- keyword -->
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
            <div class="nav-tabs-header">분류키워드</div>
            <!-- 분류키워드 list start -->
            <div id="categorizeKeywordListArea"></div>
            <!-- 분류키워드 list end -->
        </div>
        <!--// lnb -->

        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
            <!-- 최근 Q&A -->
            <div class="nav-tabs-header">최근 Q&A
                <span class="pull-right section-category">
                    <ul id="recentQaDayTypeUl" class="nav nav-tabs">
                        <li value="WEEK" data="defalut"><a href="#">Week</a></li>
                        <li value=""><a href="#">Today</a></li>
                    </ul>
                </span>
            </div>
            <!-- 최근 Q&A list start -->
            <div id="recentQaListArea">
                {{> qa/template/_recentList}}
            </div>
            <!-- 최근 Q&A list end -->
            <!--// 최근 Q&A -->

            <div class="top-buffer">&nbsp;</div>
            <!-- 답변을 기다리는 Q&A -->
            <div class="nav-tabs-header">답변을 기다리는 Q&A
                <span class="pull-right section-category">
                    <ul id="waitReplyQaDayTypeUl" class="nav nav-tabs">
                        <li value="ALL" data="defalut"><a href="#">All</a></li>
                        <li value="WEEK"><a href="#">Week</a></li>
                        <li value=""><a href="#">Today</a></li>
                    </ul>
                </span>
            </div>

            <!-- 답변을 기다리는 Q&A list start -->
            <div id="waitReplyQaListArea">
                {{> qa/template/_waitReplyList}}
            </div>
            <!-- 답변을 기다리는 Q&A list end -->

            <!--// 답변을 기다리는 Q&A -->
        </div>

        <div class="col-md-4">
            <!-- BEST Q&A -->
            <div class="nav-tabs-header">BEST Q&A</div>
            {{> qa/template/_qaBest}}
            <!--// BEST Q&A -->
        </div>
    </div>
</div>

{{/partial}}

{{#partial "script-page"}}
{{embedded "common/_keywordList"}}
{{embedded "qa/template/_noData"}}
{{embedded "qa/template/_mainList"}}
    <script src="/resource/app/js/keywordList/keywordList.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            Qa.init();
        });

        var Qa = {
            init : function(){
                KeywordList.renderKeywordList('QA');
                this.renderDayType($('#recentQaDayTypeUl'));
                this.renderDayType($('#waitReplyQaDayTypeUl'));
                this.bindDayTypeEvent();
                this.bindSearch();
            },
            renderRecentQaList : function(dayType){
                var me = this;
                $.ajax({
                    url: "/qa/qaList",
                    type: "POST",
                    data: { keywordType : 'QA', keywordName : KeywordList.selectedKeywordName(), dayType : dayType },
                    success : function(data){
                        if(data.resultCode == 1) {
                            $('#recentQaListArea').html(me.makeQaList(data));
                        }
                    },
                    error : function(req){
                        // Handle upload error
                        alert('req : ' + req);
                        console.log('req : ' + req.status);
                        console.log('req : ' + req.readyState);

                        alert('에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                    }
                });
            },
            renderWaitReplyQaList : function(dayType){
                var me = this;
                $.ajax({
                    url: "/qa/qaList",
                    type: "POST",
                    data : {keywordType : 'QA', keywordName : KeywordList.selectedKeywordName(), waitReplyType : 'WAIT', dayType : dayType},
                    success : function(data){
                        if(data.resultCode == 1) {
                            $('#waitReplyQaListArea').html(me.makeQaList(data));
                        }
                    },
                    error : function(req){
                        // Handle upload error
                        alert('req : ' + req);
                        console.log('req : ' + req.status);
                        console.log('req : ' + req.readyState);

                        alert('에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                    }
                });
            },
            makeQaList : function (jsonData) {
                var source;
                if(jsonData.data.length == 0){
                    source = $('#qa-template-_noData-hbs').html();
                } else {
                    source = $('#qa-template-_mainList-hbs').html();
                }
                var template = Handlebars.compile(source);
                var html = template(jsonData);
                return html;

            },
            bindDayTypeEvent : function(){
                $('#recentQaDayTypeUl > li').click(function(){
                    Qa.changeDayType(this);
                    Qa.renderRecentQaList(this.getAttribute('value'));
                });
                $('#waitReplyQaDayTypeUl > li').click(function(){
                    Qa.changeDayType(this);
                    Qa.renderWaitReplyQaList(this.getAttribute('value'));
                });
            },
            changeDayType : function(dayTypeObj){
                var ulObj = $(dayTypeObj).parent();
                var dayTypeValue = dayTypeObj.getAttribute('value');
                ulObj.find('li').removeClass('active');
                ulObj.find('li[value="'+dayTypeValue+'"]').addClass('active');
            },
            renderDayType : function(targetObj){
                targetObj.find('li').removeClass('active');
                targetObj.find('li[data="defalut"]').addClass('active');
            },
            bindSearch : function(){
                $('#searchBtn').click(function(){
                    Qa.search();
                });
                $('[name=searchName]').keydown(function(e){
                    if(e.which == 13) {
                        Qa.search();
                    }
                });
            },
            search : function(){
                var searchName = $('[name=searchName]').val();
                if(searchName == ''){
                    alert("검색어를 입력하세요");
                    return false;
                } else {
                    location.href = '/qa/search/' + searchName;
                }
            }
        };

        KeywordList.bindKeywordListImplEvent = function () {
            var selectedRecentQaDayType = $('#recentQaDayTypeUl').find('li.active').attr('value');
            var selectedWaitReplyQaDayType = $('#waitReplyQaDayTypeUl').find('li.active').attr('value');
            Qa.renderRecentQaList(selectedRecentQaDayType);
            Qa.renderWaitReplyQaList(selectedWaitReplyQaDayType);
        }

    </script>
{{/partial}}

{{> template/base}}
