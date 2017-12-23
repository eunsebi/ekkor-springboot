{{!--
Created by IntelliJ IDEA.
User: yion
Date: 2014. 12. 7.
Time: 16:20
To change this template use File | Settings | File Templates.
--}}
{{#partial "style"}}
    {{!-- 여기에 사용자 css 정의 --}}
{{/partial}}

{{#partial "plugin-style"}}
    {{!-- 여기에 .css 파일 경로 --}}
{{/partial}}

{{#partial "title"}}ekkor~{{/partial}}

{{# partial "content" }}

<form id="upload-file-form">
    <label for="upload-file-input">Upload your file:</label>
    <input id="upload-file-input" type="file" name="uploadfile" accept="*" />
    <input type="hidden" name="viewType" value="Image" />
</form>

<div id="imgArea"></div>

{{/partial}}


{{#partial "script-page"}}
<script>
// bind the on-change event
$(document).ready(function() {
    $("#upload-file-input").on("change", uploadFile);
});

/**
 * Upload the file sending it via Ajax at the Spring Boot server.
 */
function uploadFile() {
    var field = $("#upload-file-input").val();
    if (field != '') {
        $.ajax({
            url: "/common/uploadFile",
            type: "POST",
            data: new FormData($("#upload-file-form")[0]),
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            cache: false,
            success: function (req) {
                alert(req.resultCode);
                if(req.resultCode == 1) {
                    alert(req.comment);
                }
                if (req.data.uploadType === 'image') {
                    $("#imgArea").html("<img src='" + req.data.filePath +"/"+ req.data.savedName + "' id=\"uploadPreviewImg\" width=\"200\">");
                }
            },
            error: function (req) {
                // Handle upload error
                alert('req : ' + req);
                console.log('req : ' + req.status);
                console.log('req : ' + req.readyState);

                if (req.status == 500) {
                    alert('업로드 중 에러가 발생했습니다. 파일 용량이 허용범위를 초과 했거나 올바르지 않은 파일 입니다.');
                } else {
                    alert('에러가 발생하였습니다. 에러코드 [' + req.status + ']');
                }

            }
        });
    }
} // function uploadFile
</script>
{{/partial}}

{{> template/base}}
