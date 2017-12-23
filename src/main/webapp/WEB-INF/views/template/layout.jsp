<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <meta property="og:type" content="website">
    <meta property="og:title" content="Social Q&A ekkor™">
    <meta property="og:image" content="http://www.ekkor.com/resource/images/symbol-dashboard.png">
    <meta property="og:description" content="ekkor 는 글라이더 오픈소스팀이 만든 소셜 기반의 Q&A 지식공유 Wiki 플랫폼입니다.">

    <title>{{#block "title"}}{{/block}}</title>

    {{!-- favicon
    <link rel="shortcut icon" href="/resource/images/favicon.ico" type="image/x-icon">
     --}}

    {{!--공통 스타일 영역--}}
    <link href="/resource/public/bootstrap-3.3.6-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/resource/public/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="/resource/public/bootstrap-theme/bootswatch/cerulean/bootstrap.min.css" rel="stylesheet" />
    <link href="/resource/app/css/common.css" rel="stylesheet" />
    <link href="/resource/public/css/login.css" rel="stylesheet" />
    <!-- 모달 -->
    <link href="/resource/public/css/jquery-confirm.min.css" type="text/css" rel="stylesheet" />

    <!-- page specific plugin styles -->
    {{#block "plugin-style"}}{{/block}}

    <!-- inline styles related to this page -->
    {{#block "style"}}{{/block}}

    {{!--공통 스크립트 영역--}}
    <script src="/resource/public/js/jquery/jquery-1.11.2.min.js"></script>
    <script src="/resource/public/bootstrap-3.3.6-dist/js/bootstrap.min.js"></script>
    <script src="/resource/public/js/jquery/jquery-confirm.min.js"></script>
    <script src="/resource/public/js/handlebars.min.js"></script>
    <script src="/resource/app/js/helpers/helper.js"></script>
    <script src="/resource/app/js/google/analytics.js"></script>

    <!--<script src="http://getbootstrap.com/assets/js/docs.min.js"></script>-->
    <!--[if lt IE 9]>
    <script src="http://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="http://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    {{#block "script-header"}}{{/block}}
</head>
<body>
<!-- header -->
{{#block "header"}}{{/block}}
<!--// header -->


{{#block "content"}}

{{/block}}

{{#block "footer"}}{{/block}}

{{#block "script-body"}}{{/block}}

{{#block "script-page"}}{{/block}}
<script type="text/javascript">
    $(document).ready(function() {
        $("*").click(function(){
            if( $(this).data("linktype") == "search" ){
                $("input").each(function(){
                    if( $(this).data("linkval") == "searchText" ){
                        location.href = "/wiki/search?text="+$(this).val();
                    }
                });
            }
        });
    });
</script>

</body>
</html>
