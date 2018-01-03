{{# partial "content" }}
    <!--  메뉴  -->
    <div class="container-fluid">

        <div class="col-sm-12">

            {{> search/form/wiki}}

            <div class="btn-group pull-right">
                <a class="form-control btn btn-primary" href="/wiki/write">
                    위키생성
                </a>
            </div>
        </div>

        <div class="col-sm-12 top-buffer wiki-main">
            <!-- 하단 컨텐츠 -->
            <div class="col-md-12 col-lg-12">
                <!-- 전체 키워드 선택 -->
                <div class="col-md-2" style="padding-left: 0px;" id="categorizeKeywordListArea">
                    <div class="well">전체 키워드 선택</div>
                    <ul class="nav nav-pills nav-stacked" >

                    </ul>
                </div>
                <!--// 전체 키워드 선택 -->

                <div class="col-md-6">
                    <!-- 전체 위키 -->
                    <div>
                        <div class="nav-tabs-header">
                            전체 위키
                            <span class="pull-right section-category">
                                <ul class="nav nav-tabs" id="allListSearch">
                                    <li class="active"><a href="#" data-val="insertDate">최신순</a></li>
                                    <li><a href="#" data-val="title">이름순</a></li>
                                </ul>
                            </span>
                        </div>
                        <div id="allWikiList" class="tab-content">
                            <div></div>
                            {{> wiki/template/_allList}}
                        </div>
                    </div>
                    <!--// 위키 -->

                </div>

                <div class="col-md-4" style="padding-right: 0px;">

                    <div class="nav-tabs-header">베스트 위키</div>
                    {{> wiki/template/_bestList}}
                    <div class="top-buffer">&nbsp;</div>

                    <!-- 최근 활동 -->
                    <div class="nav-tabs-header">최근 활동</div>
                    <div id="recentWikiList">
                        {{> wiki/template/_recentList}}
                    </div>
                    <!--// 최근 활동 -->
                </div>
            </div>
        </div>
    </div>


{{/partial}}

{{# partial "script-page" }}
{{embedded "common/_keywordList"}}
{{embedded "wiki/template/_allList"}}

    <script>
        $(document).ready(function() {
            Wiki.init();
        });
        var Wiki = {
            init : function(){
                Wiki.renderKeywordList();
                Wiki.bindingBtnWiki();
            },

            renderKeywordList : function(keywordName){
                $.ajax({
                    url: "/common/findKeywordList",
                    type: "POST",
                    data: { keywordType : 'WIKI', keywordName : Wiki.selectedKeyword(keywordName) },
                    success : function(data){
                        if(data.resultCode == 1) {
                            var source = $('#common-_keywordList-hbs').html();
                            var template = Handlebars.compile(source);

                            var html = template(data);
                            $('#categorizeKeywordListArea').html(html);
                            Wiki.bindKeywordListEvent();
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
            selectedKeyword : function(keywordName){
                if(!keywordName){
                    keywordName = '';
                }
                return keywordName;
            },
            bindKeywordListEvent : function(){
                $('#categorizeKeywordListArea').find('li').click(function(){
                    Wiki.renderKeywordList(this.getAttribute('value'));
                });
            },

            searchAllWikiListType : function(listViewType){
                $.ajax({
                    url: "/wiki/allList/"+listViewType,
                    type: "GET",
                    success : function(result){
                        if( result.data != null){
                            if( result.resultCode == 1  ){
                                var source = $('#wiki-template-_allList-hbs').html();
                                var template = Handlebars.compile(source);

                                var html = template(result.data);
                                html = "<div></div>"+html;
                                $('#allWikiList').html(html);
                            }
                        }
                    },
                    error : function(req){
                        console.log('req : ' + req.status);
                        console.log('req : ' + req.readyState);
                        alert('에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                    }
                });

            },

            bindingBtnWiki : function(){
                $("#allListSearch a").click(function(){
                    Wiki.searchAllWikiListType(this.dataset.val);
                    $("#allListSearch li").each(function(){
                        if( this.className == "active" ){
                            this.className = "";
                        }else{
                            this.className = "active";
                        }
                    });
                });

                $("#bestAddBtn").click(function(){
                    location.href = "/wiki/list/best?page=0";
                });

                $("#resentAddBtn").click(function(){
                    location.href = "/wiki/list/resent?page=0";
                });
            }
        }
    </script>
{{/partial}}


{{> template/base}}