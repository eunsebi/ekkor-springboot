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
    <link href="/resource/public/css/layout-default-latest.css" rel="stylesheet">
{{/partial}}

{{#partial "script-header"}}
    <script src="/resource/public/js/jquery/jquery.layout-latest.js"></script>
    <script src="/resource/public/js/jquery/jquery-ui-latest.js"></script>
    <script src="/resource/app/js/space/tree.js"></script>
{{/partial}}


{{#partial "title"}}Alpaka~{{/partial}}
{{# partial "content" }}
<div class="container-fluid">
    {{> space/template/_spaceTopMenu}}
</div>
<div class="container-fluid">
    <form name="spaceForm" id="spaceForm">

    <div class="row" style="padding-top:100px;height: 100%; display: table-row;">&nbsp;
    </div>
    <div class="row">
        <div class="col-md-3 vcenter" style="float: none;display: table-cell;background: #eeeeee; width: 25%;">
            <input type="hidden" name="spaceId" value="{{space.spaceId}}">
            <h4 style="border-bottom:1px solid #c3cce0;padding-bottom:10px;padding-top:10px">
                <div id="sidetreecontrol">
                    <span id="btn-expand-all" style="cursor: pointer">전체열기</span> | <span id="btn-collapse-all" style="cursor: pointer">전체닫기</span>
                </div>
            </h4>

            <div id="treeview" class=""></div>
        </div>
        <div class="col-md-9" style="float: none;display: table-cell;background: #ffffff;width: 75%;">
            <div class="col-sm-11">
                <h1 class="page-header" style="margin-top: 0px">{{space.title}}
                    <small class="pull-right" style="padding-top:10px">{{formatDate space.insertDate "yyyy-MM-dd hh:MM"}} </small>
                </h1>
            </div>

            <div class="author pull-right">
                <div class="user-profile-md">
                    <img alt="avatar" class="profile-image" src="/imageView?path={{spaceUser.userImage}}" onerror='this.src="/resource/images/avatar.png"' />
                </div>
            </div>

            <div class="col-sm-12">
                <div class="jumbotron">
                    <img src="/imageView?path={{space.titleImagePath}}/{{space.titleImage}}" width="250">
                    <p>{{{space.description}}}</p>
                </div>

                <h3 style="border-bottom:1px solid #eee;padding-bottom:15px">최근 수정된 위키 목록</h3>
                <blockquote class="pull-right">
                    {{> space/template/_updateWikiList}}
                </blockquote>


                <h3 style="border-bottom:1px solid #eee;padding-bottom:15px">최근 이 공간의 활동 내역 목록 </h3>
                <blockquote class="pull-right">
                    {{> space/template/_activityList}}
                </blockquote>
            </div>
        </div>
    </div>
    </form>
</div>
{{/partial}}


{{# partial "script-page" }}

    <link href="/resource/public/css/bootstrap-treeview.css" rel="stylesheet" />
    <script type="text/javascript" src="/resource/public/js/bootstrap-treeview.js"></script>

    <script type="text/javascript">
        // bind the on-change event

        $(document).ready(function() {

            $('#btn-expand-all').on('click', function (e) {
                var levels = 5;
                $('#treeview').treeview('expandAll', { levels: levels, silent: '' });
            });

            $('#btn-collapse-all').on('click', function (e) {
                $('#treeview').treeview('collapseAll', '');
            });


            var userFavorite = "{{userFavorite}}";
            // https://github.com/jonmiles/bootstrap-treeview 으로 변경할 예정
            $.ajax({
                url: "/space/tree",
                type: "POST",
                data: { spaceId : $('[name=spaceId]').val() },
                success : function(response){
                    console.log("# response = " + response);
                    //var r = convert(JSON.parse(response));
                    var defaultData = makeTree(JSON.parse(response) );

                    console.log("## defaultData = " + JSON.stringify(defaultData, null, " "));


                    $('#treeview').treeview({
                        color: "#428bca",
                        backColor : "#eeeeee",
                        onhoverColor: "#eeeeee",
                        showBorder: false,
                        showTags: true,
                        highlightSelected: false,
                        levels: 1,
                        enableLinks: true,
                        data: JSON.stringify(defaultData, null, " ")
                    });

                },
                error : function(req){
                    // Handle upload error
                    alert(' 에러코드 [' + req.status + ']');
                }
            });

            $('#deleteSpace').on('click', function () {
                $.confirm({
                    title: '확인',
                    content: '공간을 삭제하겠습니까?<BR>위키가 존재할 경우 관리자만 삭제할 수 있습니다.',
                    confirmButton: '확인',
                    cancelButton: '취소',
                    confirmButtonClass: 'btn-info',
                    confirm: function () {
                        $.post('/space/delete', { spaceId: "{{space.spaceId}}" })
                            .done(function (response) {
                                $.alert({
                                    title: '확인',
                                    content: response.comment,
                                    confirmButton: 'OK',
                                    confirmButtonClass: 'btn-primary',
                                    icon: 'fa fa-info',
                                    animation: 'zoom',
                                    confirm: function () {
                                        if (response.resultCode == 1) {
                                            location.href = '/space/main';
                                        }
                                    }
                                });
                            }).fail(function () {
                                $.alert({
                                    title: '확인',
                                    content: '공간 삭제중 에러가 발생하였습니다. 다시 시도하세요.',
                                    confirmButton: 'OK',
                                    confirmButtonClass: 'btn-primary',
                                    icon: 'fa fa-info',
                                    animation: 'zoom',
                                    confirm: function () {
                                    }
                                });
                            });
                    },
                    cancel: function(){
                        return true;
                    }
                });

            });
            console.log("## userFavorite = " + userFavorite);

            if (userFavorite == '') {
                $("#addFavorite").css("display","block");
            } else {
                $("#cancelFavorite").css("display","block");
            }

            $('#createWiki').on('click', function () {
                $('#spaceForm').attr({action:'/wiki/write', method:'post'}).submit();
            });
            $('#editSpace').on('click', function () {
                $('#spaceForm').attr({action:'/space/edit/{{space.spaceId}}', method:'get'}).submit();
            });

            $('#getMoreWiki').on('click', function () {
                alert('더 가져오기');
            });

            $('#addFavorite').on('click', function () {
                var spaceId = {{space.spaceId}};
                $.ajax({
                    url: "/space/addFavorite",
                    data: { spaceId : spaceId },
                    type: "GET",
                    success : function(data){
                        console.log("data = " + data);

                        if (data == 1) {
                            $.alert({
                                title: '확인',
                                content: '즐겨찾기 추가 완료',
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                }
                            });

                            $("#addFavorite").css("display","none");
                            $("#cancelFavorite").css("display","block");
                        } else if (data == 0) {
                            $.alert({
                                title: '확인',
                                content: '사용자 정보가 존재하지 않습니다. 로그인 후 다시 시도하세요.',
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                }
                            });
                        }
                    },
                    error : function(req){
                        $.alert({
                            title: '확인',
                            content: '즐겨찾기 추가가 되지 않았습니다. 다시 시도하세요.',
                            confirmButton: 'OK',
                            confirmButtonClass: 'btn-primary',
                            icon: 'fa fa-info',
                            animation: 'zoom',
                            confirm: function () {
                            }
                        });
                    }
                })
            });

            $('#cancelFavorite').on('click', function () {
                var spaceId = {{space.spaceId}};
                $.ajax({
                    url: "/space/cancelFavorite",
                    data: { spaceId : spaceId },
                    type: "GET",
                    success : function(data){
                        console.log("data = " + data);

                        if (data == 1) {
                            $.alert({
                                title: '확인',
                                content: '즐겨찾기 취소 완료',
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                }
                            });

                            $("#addFavorite").css("display","block");
                            $("#cancelFavorite").css("display","none");
                        } else if (data == 0) {
                            $.alert({
                                title: '확인',
                                content: '사용자 정보가 존재하지 않거나 만료 되었습니다. 다시 로그인 하세요.',
                                confirmButton: 'OK',
                                confirmButtonClass: 'btn-primary',
                                icon: 'fa fa-info',
                                animation: 'zoom',
                                confirm: function () {
                                }
                            });
                        }
                    },
                    error : function(req){
                        $.alert({
                            title: '확인',
                            content: '즐겨찾기 취소가 되지 않았습니다. 다시 시도하세요.',
                            confirmButton: 'OK',
                            confirmButtonClass: 'btn-primary',
                            icon: 'fa fa-info',
                            animation: 'zoom',
                            confirm: function () {
                            }
                        });
                    }
                })
            });
        });
    </script>
{{/partial}}

{{> template/base}}
