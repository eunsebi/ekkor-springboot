<div class="media qna-item">
    <ul class="nav nav-pills nav-stacked cat-keyword">
        <li class="active" value="" style="text-align: center;" data-keywordList-name=""><a href="#">전체</a></li>
        {{#each data}}
            <li data-keywordList-name="{{keywordName}}"><a href="{{keywordLink keywordType keywordName}}">{{keywordName}}({{keywordCount}})</a></li>
        {{/each}}
    </ul>
</div>
