{{#each data}}
    <div class="fileDiv" style="padding: 5px;"> 
        <input name="fileIds" type="hidden" value="{{fileId}}">
        <input name="realNames" type="hidden" value="{{realName}}">
        <input name="savedNames" type="hidden" value="{{savedName}}">
        <input name="filePaths" type="hidden" value="{{filePath}}">
        <input name="fileSizes" type="hidden" value="{{fileSize}}">
        <input name="fileTypes" type="hidden" value="{{fileExtendType}}">
        <a href="/download?path={{filePath}}/{{savedName}}">{{realName}}</a>
        <a href="#fileDiv" onclick="Qa.deleteFile(this);">
            <span class="glyphicon glyphicon-remove" style="margin-left:15px;"></span> 
        </a>
    </div>
{{/each}}