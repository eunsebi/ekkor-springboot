<!--
  Created by IntelliJ IDEA.
  User: yong
  Date: 2014. 9. 22.
  Time: 오후 10:57
-->

{{# partial "content" }}

    <!-- contents -->
    <!-- qna top contents -->
    <div class="container qna-top-search">
        <form class="navbar-form navbar-left" role="search">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Search">
            </div>
            <a href="#" class="form-control btn btn-primary">검색</a>
        </form>
        <div class="btn-group pull-right">
            <a href="/qa/total/list" class="btn btn-primary">총 질문({{qaTotalCount}})</a>
            <a href="/qa/wait_reply/list" class="btn btn-primary">답변을 기다리는 Q&A({{qaNotReplyedCount}})</a>
            {{#if isLogin}}
            <a href="/qa" class="btn btn-primary">Q&A</a>
            <a href="/qa/form" class="btn btn-primary">질문하기</a>
            {{/if}}
        </div>
    </div>
    <!--// qna top contents -->

    <!-- 메뉴 -->
    <div class="container contents-container top-buffer">
        <!-- keyword -->
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
            <div class="nav-tabs-header">분류키워드</div>
            <!-- 분류키워드 list start -->
            <div id="categorizeKeywordListArea"></div>
            <!-- 분류키워드 list end -->
        </div>
        <!--// lnb -->

        <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
            <!-- 내가 작성한 Q&A -->
            <div class="nav-tabs-header">내가 작성한 Q&A</div>

            <!-- 내가 작성한 Q&A list start -->
            <div id="myWriteQaListArea"></div>
            <!-- 내가 작성한 Q&A list end -->

            <!--// 내가 작성한 Q&A -->

            <div class="top-buffer">&nbsp;</div>

            <!-- 내가 답변한 Q&A -->
            <div class="nav-tabs-header">내가 답변한 Q&A</div>

            <!-- 내가 답변한 Q&A list start -->
            <div id="myReplyQaListArea"></div>
            <!-- 내가 답변한 Q&A list end -->

            <!-- 내가 답변한 Q&A -->

            <div class="top-buffer">&nbsp;</div>

            <!-- 내가 추천한 Q&A -->
            <div class="nav-tabs-header">내가 추천한 Q&A</div>

            <!-- 내가 추천한 Q&A list start -->
            <div id="myRecommendQaListArea"></div>
            <!-- 내가 추천한 Q&A list end -->

            <!-- 내가 추천한 Q&A -->
        </div>
    </div>

{{/partial}}

{{#partial "script-page"}}
    {{embedded "common/_keywordList"}}
    {{embedded "qa/template/_myList"}}
    <script type="text/javascript">
        $(document).ready(function(){
            Qa.init();
        });

        var Qa = {
            init : function(){
                this.renderKeywordList();
                this.renderMyWriteQaList();
                this.renderMyReplyQaList();
                this.renderMyRecommendQaList();
            },
            renderKeywordList : function(){
                $.ajax({
                    url: "/common/findKeywordList",
                    type: "POST",
                    data: { keywordType : 'QA', keywordName : Qa.selectedKeywordName() },
                    success : function(data){
                        if(data.resultCode == 1) {
                            var source = $('#common-_keywordList-hbs').html();
                            var template = Handlebars.compile(source);

                            var html = template(data);
                            $('#categorizeKeywordListArea').html(html);
                            Qa.bindKeywordListEvent();
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
            renderMyWriteQaList : function(){
                $.ajax({
                    url: "/qa/myWriteQaList",
                    type: "POST",
                    data: { keywordType : 'QA', keywordName : Qa.selectedKeywordName()},
                    success : function(data){
                        if(data.resultCode == 1) {
                            var source = $('#qa-template-_myList-hbs').html();
                            var template = Handlebars.compile(source);

                            var html = template(data);
                            $('#myWriteQaListArea').html(html);
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
            renderMyReplyQaList : function(){
                $.ajax({
                    url: "/qa/myReplyQaList",
                    type: "POST",
                    data: { keywordType : 'QA', keywordName : Qa.selectedKeywordName()},
                    success : function(data){
                        if(data.resultCode == 1) {
                            var source = $('#qa-template-_myList-hbs').html();
                            var template = Handlebars.compile(source);

                            var html = template(data);
                            $('#myReplyQaListArea').html(html);
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
            renderMyRecommendQaList : function(){
                $.ajax({
                    url: "/qa/myRecommendQaList",
                    type: "POST",
                    data: { keywordType : 'QA', keywordName : Qa.selectedKeywordName()},
                    success : function(data){
                        if(data.resultCode == 1) {
                            var source = $('#qa-template-_myList-hbs').html();
                            var template = Handlebars.compile(source);

                            var html = template(data);
                            $('#myRecommendQaListArea').html(html);
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
            selectedKeywordName : function(){
                var keywordName = $('#categorizeKeywordListArea').find('li.active').attr('data-keywordList-name');
                return keywordName;
            },
            bindKeywordListEvent : function(){
                $('#categorizeKeywordListArea').find('li').click(function(){
                    KeywordList.findKeywordList(this);
                });
            }
        };

        var KeywordList = {
            findKeywordList : function(keywordListObj){
                var ulObj = $(keywordListObj).parent();
                ulObj.find('li').removeClass('active');
                var keywordListValue = keywordListObj.getAttribute('data-keywordList-name');
                if(keywordListValue == ''){
                    ulObj.find('li[data-keywordList-name=""]').addClass('active');
                } else {
                    ulObj.find('li[data-keywordList-name=' + keywordListValue + ']').addClass('active');
                }
                Qa.renderMyWriteQaList();
                Qa.renderMyReplyQaList();
            }
        }

    </script>
{{/partial}}

{{> template/base}}