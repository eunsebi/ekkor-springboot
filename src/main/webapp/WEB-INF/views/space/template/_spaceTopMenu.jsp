<form name="space" id="space">
    <input type="hidden" name="spaceId" id="spaceId" value="{{space.spaceId}}">
</form>
<div style="padding-bottom: 45px;">
    <div class="btn-group" data-toggle="buttons" style="float: right">
        <a class="btn btn-primary" id="cancelFavorite" style="display: none;"><i class="fa fa-heart-o"></i> 즐겨찾기 취소</a>
        <a class="btn btn-primary" id="addFavorite" style="display: none;"><i class="fa fa-heart"></i> 즐겨찾기 추가</a>
        <a class="btn btn-primary" id="createWiki"><i class="fa fa-pencil"></i> 위키 생성</a>
        <a class="btn btn-primary" id="fileList"><i class="fa fa-file-text"></i> 첨부파일 목록</a>
        <a class="btn btn-primary" id="editSpace"><i class="fa fa-pencil-square-o"></i>  공간수정</a>
        {{#if canDeleted}}
        <a class="btn btn-primary" id="deleteSpace"><i class="fa fa-trash"></i> 공간삭제</a>
        {{/if}}
    </div>
</div>

