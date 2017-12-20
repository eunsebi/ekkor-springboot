
{{#partial "plugin-style"}}
{{!-- 여기에 .css 파일 경로 --}}
    <link href="/resource/public/css/bootstrap-tag-cloud/bootstrap-tag-cloud.css" rel="stylesheet">
{{/partial}}
{{#partial "script-header"}}
    <script src="/resource/app/js/DualEditor/DualEditor-core.js"></script>
    <script type='text/javascript' src="/resource/public/js/bootstrap-tag-cloud/bootstrap-tag-cloud.js"></script>
{{/partial}}

{{#partial "title"}}Alpaka~{{/partial}}

{{# partial "content" }}
<!-- contents -->
<div class="container-fluid">
    <div class="col-sm-12">

        {{> search/form/space}}

        <div class="btn-group pull-right">
            <a href="/space/spaces" class="btn btn-primary" id="spaceCount"></a>
            <a href="/space/keywords" class="btn btn-primary" id="keywordCount"></a>
            <a href="/space/form" class="btn btn-primary">공간 생성하기</a>
        </div>

    </div>

    <div class="col-sm-12 top-buffer" style="padding-bottom: 20px">
        <input type="hidden" id="tabName" value="">
        <input type="hidden" id="currentPage" value="{{currentPage}}">
        <input type="hidden" id="pageSize" value="{{spacePageSize}}">
        <!-- keyword -->
        <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">

            <div class="nav-tabs-header">분류키워드</div>
            <!-- 분류키워드 list start -->
            <div id="categorizeKeywordListArea"></div>
            <!-- 분류키워드 list end -->
        </div>
        <!--// lnb -->

        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                <!-- 전체 공간 -->
                <div class="nav-tabs-header">전체 공간
                    <span class="pull-right section-category">
                        <ul id="renderTypeUI" class="nav nav-tabs">
                            <li value="title" data="defalut" class="active"><a id="spaceTitle" href="#">이름순</a></li>
                            <li value="updateDate"><a id="spaceUpdate" style="cursor: pointer">최신순</a></li>
                        </ul>
                    </span>
                </div>

                <div id="allSpaceArea">
                {{> space/template/_allSpaceList}}
                </div>

                <br>
                {{#if morePage }}
                <p class="lead text-right" id="morePageAlign"><button class="btn btn-default" id="getMorePages">더보기</button></p>
                {{/if}}
        </div>

        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
            <!-- 내 즐겨찾기 -->
            <div class="nav-tabs-header">내 즐겨찾기 공간</div>
            {{> space/template/_myfavoriteList}}
            <!--// 즐겨찾기 -->
            <!-- 최근 위키 -->
            <div class="top-buffer">&nbsp;</div>
            <div class="nav-tabs-header">최근 위키</div>

            <div id="recentWikiArea">
                <input type="hidden" id="currentSpaceWikiPage" value="{{wikiCurrentPage}}">
                <input type="hidden" id="spaceWikiPageSize" value="{{spaceWikiSize}}">
                {{> space/template/_recentWikiList}}
            </div>
            <!--// 최근 위키 -->
        </div>
    </div>
</div>
<!--// contents -->
{{/partial}}
{{#partial "script-page"}}
    {{embedded "common/_keywordList"}}
    {{embedded "space/template/_allSpaceList"}}
    {{embedded "space/template/_recentWikiList"}}
    <script src="/resource/app/js/keywordList/keywordList.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            Space.init();

            $('#spaceTitle').on('click', function () {
                renderSpaceList("title");
            });

            $('#spaceUpdate').on('click', function () {
                renderSpaceList("updateDate");
            });
            $('#getMorePages').on('click', function () {
                renderMorePage();
            });
            $('#wikiMorePage').on('click', function () {
                renderMoreWikis();
            });

        });

        var Space = {
            init : function(){
                KeywordList.renderKeywordList('SPACE');
                this.spaceCount();
                this.keywordCount();
                this.renderDayType($('#renderTypeUI'));
                this.bindDayTypeEvent();
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
            bindDayTypeEvent : function(){
                $('#renderTypeUI > li').click(function(){
                    Space.chaneSortType(this);
                });
            },
            chaneSortType : function(dayTypeObj){
                var ulObj = $(dayTypeObj).parent();
                var dayTypeValue = dayTypeObj.getAttribute('value');
                $("#tabName").val(dayTypeValue);
                ulObj.find('li').removeClass('active');
                ulObj.find('li[value="'+dayTypeValue+'"]').addClass('active');
            },
            renderDayType : function(targetObj){
                targetObj.find('li').removeClass('active');
                targetObj.find('li[data="defalut"]').addClass('active');
            }
        };

        function renderSpaceList(sort) {
            $.ajax({
                url: "/space/render",
                type: "GET",
                data: { sortType : sort},
                success : function(response){
                    console.log("## response = " + response.resultCode);
                    console.log("## response = " + response.data);
                    if(response.resultCode == 1) {

                        var source = $('#space-template-_allSpaceList-hbs').html();
                        var template = Handlebars.compile(source);

                        var html = template(response.data);
                        $('#allSpaceArea').html(html);
                        $("#morePageAlign").css("display","block");
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
        }

        function renderMorePage() {

            var sort = "";
            var currentPage = $("#currentPage").val();
            currentPage = Number(currentPage);

            var nextPage = currentPage+1;
            var pageSize = $("#pageSize").val();

            console.log("nextPage = " + nextPage);


            if ($("#tabName").val() == "") {
                sort = "title";
            } else {
                sort = $("#tabName").val();
            }

            $.ajax({
                url: "/space/more",
                type: "GET",
                data: { "sortType" : sort, "startNum" : nextPage, "pageSize" : pageSize},
                success : function(response){
                    console.log("## response = " + response.resultCode);
                    console.log("## response.current = " + response.data.currentPage);

                    if(response.resultCode == 1) {

                        var source = $('#space-template-_allSpaceList-hbs').html();
                        var template = Handlebars.compile(source);
                        var html = template(response.data);
                        $('#allSpaceArea').append(html);
                        $("#currentPage").val(response.data.currentPage);

                        if (response.data.currentPage == Number(response.data.totalPages - 1)) {
                            $("#getMorePages").css("display","none");
                        }
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
        }

        function renderMoreWikis() {
            var sort = "updateDate";        // 기본
            var currentPage = $("#currentSpaceWikiPage").val();
            currentPage = Number(currentPage);

            var nextPage = currentPage+1;
            var pageSize = $("#spaceWikiPageSize").val();

            console.log("nextPage = " + nextPage);

            $.ajax({
                url: "/space/morewiki",
                type: "GET",
                data: { "sortType" : sort, "startNum" : nextPage, "pageSize" : pageSize},
                success : function(response){
                    console.log("## response = " + response.resultCode);
                    console.log("## response = " + response.data);
                    if(response.resultCode == 1) {

                        var source = $('#space-template-_recentWikiList-hbs').html();
                        var template = Handlebars.compile(source);

                        var html = template(response.data);
                        $('#recentWikiArea').html(html);

                        $("#currentSpaceWikiPage").val(response.data.currentPage);

                        if (response.data.currentPage == Number(response.data.totalPages - 1)) {
                            $("#wikiMorePage").css("display","none");
                        }

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
        }

        KeywordList.bindKeywordListImplEvent = function () {
            alert("##");
        }

    </script>
{{/partial}}

{{> template/base}}
