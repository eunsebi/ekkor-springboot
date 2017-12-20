<!--
<span class="label label-default">default</span>
<span class="label label-primary">primary</span>
<span class="label label-success">success</span>
<span class="label label-info">info</span>
<span class="label label-warning">warning</span>
<span class="label label-danger">danger</span>
<span class="label label-tag">Tag</span>
<span class="label label-focus">focus</span>
<span class="label label-alert">alert</span>
-->

{{#each keywords}}
    <script type="text/javascript">
        var keyLength = '{{length keywordName}}';

        switch (keyLength) {
            case '1': document.write("<span class=\"label label-primary\">" + "{{keywordName}}" +"</span>");
                break;
            case '2': document.write("<span class=\"label label-success\">" + "{{keywordName}}" +"</span>");
                break;
            case '3': document.write("<span class=\"label label-info\">" + "{{keywordName}}" +"</span>");
                break;
            case '4': document.write("<span class=\"label label-warning\">" + "{{keywordName}}" +"</span>");
                break;
            case '5': document.write("<span class=\"label label-danger\">" + "{{keywordName}}" +"</span>");
                break;
            case '6': document.write("<span class=\"label label-tag\">" + "{{keywordName}}" +"</span>");
                break;
            case '7': document.write("<span class=\"label label-focus\">" + "{{keywordName}}" +"</span>");
                break;
            case '8': document.write("<span class=\"label label-alert\">" + "{{keywordName}}" +"</span>");
                break;
            default:  document.write("<span class=\"label label-default\">" + "{{keywordName}}" +"</span>");
        }
    </script>
{{/each}}
