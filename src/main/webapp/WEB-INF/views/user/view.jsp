{{!--
Created by IntelliJ IDEA.
User: yion
Date: 2014. 12. 7.
Time: 16:20
To change this template use File | Settings | File Templates.
--}}
{{#partial "style"}}
{{!-- 여기에 사용자 css 정의 --}}
    <link href="/resource/app/js/DualEditor/css/DualEditor.css" rel="stylesheet">
{{/partial}}

{{#partial "plugin-style"}}
{{!-- 여기에 .css 파일 경로 --}}

{{/partial}}
{{#partial "script-header"}}

{{/partial}}

{{#partial "title"}}Alpaka~{{/partial}}

{{# partial "content" }}
    <!-- contents -->
    <div class="container">
        메일 {{loginUserInfo.userEmail}} <BR>
        롤 {{loginUserInfo.role}} <BR>
        ip {{loginUserInfo.userIp}} <BR>

    </div>

{{/partial}}


{{# partial "script-page" }}
    <script type="text/javascript">

    </script>
{{/partial}}

{{> template/base}}
