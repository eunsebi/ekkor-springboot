{{#partial "title"}}Alpaka~{{/partial}}

{{# partial "content" }}
    <div class="container-fluid">

        <div class="col-sm-12">
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <a href="#" class="form-control btn btn-primary">공간검색</a>
            </form>

            <div class="btn-group pull-right">
                <a href="/space/spaces" class="btn btn-primary" id="spaceCount"></a>
                <a href="/space/keywords" class="btn btn-primary" id="keywordCount"></a>
                <a href="/space/form" class="btn btn-primary">공간 생성하기</a>
            </div>
        </div>


        <div class="col-sm-12 top-buffer" style="padding-bottom: 20px">
            <!-- keyword -->
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">

                <div class="nav-tabs-header">분류키워드</div>
                <div id="categorizeKeywordListArea"></div>
            </div>
            <!--// lnb -->

            <div class="col-md-10">

                <!-- 내가 작성한 Q&A -->
                <div class="nav-tabs-header">전체 공간</div>
                {{> space/template/_spaceList}}

                <!--// 내가 작성한 Q&A -->
                <div class="top-buffer">&nbsp;</div>
            </div>
        </div>
    </div>
    <!--// contents -->
{{/partial}}

{{#partial "script-page"}}
    {{embedded "common/_keywordList"}}
    <script type="text/javascript">
        $(document).ready(function(){
            Space.init();
        });

        var Space = {
            init : function(){
                this.renderKeywordList();
                this.spaceCount();
                this.keywordCount();
            },
            renderKeywordList : function(keywordName){
                $.ajax({
                    url: "/common/findKeywordList",
                    type: "POST",
                    data: { keywordType : 'SPACE', keywordName : Space.selectedKeyword(keywordName) },
                    success : function(data){
                        if(data.resultCode == 1) {
                            var source = $('#common-_keywordList-hbs').html();
                            var template = Handlebars.compile(source);

                            var html = template(data);
                            $('#categorizeKeywordListArea').html(html);
                            Space.bindKeywordListEvent();
                        }
                    },
                    error : function(req){
                        alert('키워드 목록 조회에서 에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                    }
                });
            },
            selectedKeyword : function(keywordName){
                if(!keywordName){
                    keywordName = '';
                }
                return keywordName;
            },
            spaceCount : function() {
                $("#spaceCount").text("개설된 공간수({{totalCount}})");
            },
            keywordCount : function() {
                $.ajax({
                    url: "/keyword/count",
                    type: "GET",
                    success : function(data){
                        $("#keywordCount").text("등록된 키워드수(" + data + ")");
                    },
                    error : function(req){
                        alert('키워드 수 조회 에러. 에러코드 [' + req.status + ']');
                    }
                })
            },
            bindKeywordListEvent : function(){
                $('#categorizeKeywordListArea').find('li').click(function(){
                    Space.renderKeywordList(this.getAttribute('value'));
                });
            }
        };
    </script>
{{/partial}}

{{> template/base}}
