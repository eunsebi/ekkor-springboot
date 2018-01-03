



<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Iljin Photo Team Inform Page v0.1</title>
    <link href="css/sb-admin/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin/metisMenu.min.css" rel="stylesheet">
    <link href="css/sb-admin/sb-admin-2.css" rel="stylesheet">
    <link href="css/sb-admin/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>

        .col-gu{
            float: left;
            width: 14%;
            padding: 1px;
            height: 200px;
        }

        @media screen and (max-width: 1024px) {
            .col-gu{
                width: 33%;
            }
        }

        @media screen and (max-width: 450px) {
            .col-gu{
                width: 50%;
            }
        }

    </style>
    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
    <script>
        function fn_moveDate(date){
            $.ajax({
                url: "moveDate.do",
                type:"post",
                data : {date: date},
                success: function(result){
                    $("#calenDiv").html(result);
                }
            })
        }
    </script>

</head>

<body>

<div id="wrapper">





    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-brand" href="/www/index.do">Iljin Photo Team Inform Page v0.1</a>
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <ul class="nav navbar-top-links navbar-right">
                <!-- /.dropdown -->

                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="/www/memberForm.do"><i class="fa fa-user fa-fw"></i> 심은섭</a></li>
                        <li><a href="/www/searchMember.do"><i class="fa fa-users fa-fw"></i> 사용자조회</a></li>
                        <li class="divider"></li>
                        <li><a href="/www/memberLogout.do"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->
        </div>
        <!-- /.navbar-header -->

        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="sidebar-search">
                        <form id="searchForm" name="searchForm"  method="post" action="boardList.do">
                            <input type="hidden" name="searchType" value="brdtitle,brdmemo">
                            <div class="input-group custom-search-form">
                                <input class="form-control" type="text" name="globalKeyword" id="globalKeyword" placeholder="Search...">
                                <span class="input-group-btn">
	                                    <button class="btn btn-default" type="button" onclick="fn_search()">
	                                        <i class="fa fa-search"></i>
	                                    </button>
	                                </span>
                            </div>
                        </form>
                        <script>
                            function fn_search(){
                                if ($("#globalKeyword").val()!=="") {
                                    $("#searchForm").submit();
                                }
                            }
                        </script>                            <!-- /input-group -->
                    </li>
                    <li>
                        <a href="/www/boardList.do"><i class="fa fa-files-o fa-fw"></i> 게시판</a>
                    </li>
                    <li>
                        <a href="/www/projectList.do"><i class="fa fa-tasks fa-fw"></i> Schedule Management </a>
                    </li>

                    <li>
                        <a href="#"><i class="fa fa-music fa-fw"></i>  게시판<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/www/boardList.do?bgno=2">공지사항</a>
                            </li>
                            <li>
                                <a href="/www/boardList.do?bgno=3">일반게시판</a>
                            </li>
                            <li>
                                <a href="/www/boardList.do?bgno=8">자유게시판</a>
                            </li>
                            <li>
                                <a href="/www/boardList.do?bgno=13">건의사항</a>
                            </li>
                            <li>
                                <a href="/www/boardList.do?bgno=9">자료실</a>
                            </li>
                        </ul>
                    </li>

                    <!-- T1 Maint Inform Board -->
                    <li>
                        <a href="#"><i class="fa fa-music fa-fw"></i>T1 Maint Inform<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/www/boardList.do?bgno=6">T1 Maint Inform</a>
                            </li>
                            <li>
                                <a href="/www/boardList.do?bgno=12">T1 설비 특이사항</a>
                            </li>
                        </ul>
                    </li>

                    <!-- T2 Maint Inform Board -->
                    <li>
                        <a href="#"><i class="fa fa-music fa-fw"></i>T2 Maint Inform<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/www/boardList.do?bgno=7">T2 Maint Inform</a>
                            </li>
                            <li>
                                <a href="/www/boardList.do?bgno=10">T2 설비 특이사항</a>
                            </li>
                        </ul>
                    </li>

                    <!-- 급여계산 -->
                    <li>
                        <a href="/www/sal/SalaryManageList.do"><i class="fa fa-music fa-fw"></i> 급여 계산 </a>
                        <!-- <ul class="nav nav-second-level">
                            <li>
                                <a href="/www/sal/SalaryManageList.do">급여계산</a>
                            </li>
                        </ul> -->
                    </li>

                    <li>
                        <a href="#"><i class="fa fa-music fa-fw"></i> 샘플<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/www/sample1.do">샘플 1: 조직도/사용자</a>
                            </li>
                            <li>
                                <a href="/www/sample2.do">샘플 2: 날짜 선택 </a>
                            </li>
                            <li>
                                <a href="/www/sample3.do">샘플 3: 챠트</a>
                            </li>
                            <li>
                                <a href="/www/sample4.do">샘플 4: List & Excel</a>
                            </li>
                            <li>
                                <a href="/www/inform/informList.do?bgno=1">DES 인폼</a>
                            </li>
                        </ul>
                    </li>

                    <li>
                        <a href="#"><i class="fa fa-gear fa-fw"></i> 관리자</a>
                    </li>
                    <li>
                        <a href="/www/adBoardGroupList.do"><i class="fa fa-files-o fa-fw"></i> 게시판관리</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-sitemap fa-fw"></i> 조직 관리<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/www/adDepartment.do">부서관리</a>
                            </li>
                            <li>
                                <a href="/www/adUser.do">사용자관리</a>
                            </li>
                        </ul>
                    </li>

                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- /.navbar-static-side -->
    </nav>



    <div id="page-wrapper">
        <div id="calenDiv" class="row">





            <div class="col-lg-12">
                <h1 class="page-header">
                    <a href="javascript: fn_moveDate('2017-04-22')"><i class="fa fa-angle-left fa-fw"></i></a>

                    4월 5째주
                    <a href="javascript: fn_moveDate('2017-04-30')"><i class="fa fa-angle-right fa-fw"></i></a>
                </h1>
            </div>

            <div class="col-lg-12">

                <div class="col-gu">
                    <div class="panel  panel-default height100">
                        <div class="panel-heading">4월 23일 (일)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

                <div class="col-gu">
                    <div class="panel  panel-default height100">
                        <div class="panel-heading">4월 24일 (월)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

                <div class="col-gu">
                    <div class="panel panel-red  height100">
                        <div class="panel-heading">4월 25일 (화)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

                <div class="col-gu">
                    <div class="panel  panel-default height100">
                        <div class="panel-heading">4월 26일 (수)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

                <div class="col-gu">
                    <div class="panel  panel-default height100">
                        <div class="panel-heading">4월 27일 (목)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

                <div class="col-gu">
                    <div class="panel  panel-default height100">
                        <div class="panel-heading">4월 28일 (금)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

                <div class="col-gu">
                    <div class="panel  panel-default height100">
                        <div class="panel-heading">4월 29일 (토)</div>
                        <div class="panel-body">


                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="row">
            <div class="col-lg-12">
                &nbsp;
            </div>
        </div>

        <!-- /.row -->
        <div class="row">
            <div class="col-lg-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-send fa-fw"></i> Recent News
                        <div class="pull-right"><a href="boardList.do">more</a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="col-lg-12">
                            <div class="listHead">
                                <div class="listHiddenField pull-right field100">위치</div>
                                <div class="listHiddenField pull-right field100">등록일</div>
                                <div class="listHiddenField pull-right field100">등록자</div>
                                <div class="listTitle">제목</div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-24</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-24일 B조 주간">
                                    <a href="boardRead.do?brdno=339">2017-04-24일 B조 주간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-24
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-21</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-21일 A조 야간">
                                    <a href="boardRead.do?brdno=338">2017-04-21일 A조 야간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-21
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-21</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-21일 B조 주간">
                                    <a href="boardRead.do?brdno=337">2017-04-21일 B조 주간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-21
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-21</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-21일 A조 야간">
                                    <a href="boardRead.do?brdno=336">2017-04-21일 A조 야간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-21
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-20</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-20일 B조 주간">
                                    <a href="boardRead.do?brdno=335">2017-04-20일 B조 주간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-20
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-19</div>
                                <div class="listHiddenField pull-right field100">최동철</div>
                                <div class="listTitle" title="2017-04-19일 A조 야간">
                                    <a href="boardRead.do?brdno=334">2017-04-19일 A조 야간</a>

                                </div>
                                <div class="showField text-muted small">
                                    최동철 2017-04-19
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-19</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-19일 B조 주간">
                                    <a href="boardRead.do?brdno=333">2017-04-19일 B조 주간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-19
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-18</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-18일 A조 야간">
                                    <a href="boardRead.do?brdno=332">2017-04-18일 A조 야간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-18
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-18</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-18일 B조 주간">
                                    <a href="boardRead.do?brdno=331">2017-04-18일 B조 주간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-18
                                </div>
                            </div>


                            <div class="listBody">
                                <div class="listHiddenField pull-right field100">T2 Inform</div>
                                <div class="listHiddenField pull-right field100">2017-04-17</div>
                                <div class="listHiddenField pull-right field100">T2_메인트1</div>
                                <div class="listTitle" title="2017-04-17일 A조 야간">
                                    <a href="boardRead.do?brdno=330">2017-04-17일 A조 야간</a>

                                </div>
                                <div class="showField text-muted small">
                                    T2_메인트1 2017-04-17
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-volume-up fa-fw"></i> 공지사항
                    </div>
                    <div class="panel-body maxHeight400">


                        <a href="boardRead.do?brdno=251">
                            <div class="listBody listTitle">
                                스케쥴 만들어 놓았다~~~~~~~~
                            </div>
                        </a>


                        <a href="boardRead.do?brdno=54">
                            <div class="listBody listTitle">
                                급여계산기 버그 수정 완료
                            </div>
                        </a>


                        <a href="boardRead.do?brdno=38">
                            <div class="listBody listTitle">
                                급여계산기 Open
                            </div>
                        </a>


                        <a href="boardRead.do?brdno=1">
                            <div class="listBody listTitle">
                                New Inform Page Open
                            </div>
                        </a>

                    </div>
                </div>

                <!-- Time Line -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-clock-o fa-fw"></i> Time Line
                    </div>
                    <div class="panel-body maxHeight400">
                        <ul class="chat">



                            <li class="left clearfix">



                                <img src="fileDownload.do?downname=2016101311181380861" title="심은섭" class="chat-img pull-left img-circle"/>


                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">심은섭</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 2달전
                                        </small>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=245">게시물[2017-02-23]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>







                            <li class="right clearfix">



                                <img src="fileDownload.do?downname=2016101311181380861" title="심은섭" class="chat-img pull-right img-circle"/>


                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 2달전</small>
                                        <strong class="pull-right primary-font">심은섭</strong>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=242">게시물[2017-02-21]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>





                            <li class="left clearfix">



                                <img src="fileDownload.do?downname=2016101311181380861" title="심은섭" class="chat-img pull-left img-circle"/>


                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">심은섭</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 3달전
                                        </small>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=159">게시물[2017-01-05]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>







                            <li class="right clearfix">



                                <img src="fileDownload.do?downname=2016101311181380861" title="심은섭" class="chat-img pull-right img-circle"/>


                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 4달전</small>
                                        <strong class="pull-right primary-font">심은섭</strong>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=110">게시물[2016-11-25]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>





                            <li class="left clearfix">


                                                        <span class="chat-img pull-left img-circle">
                                                            <i class="glyphicon glyphicon-user noPhoto"></i>
                                                        </span>



                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">T2_메인트1</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 4달전
                                        </small>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=110">게시물[2016-11-25]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>







                            <li class="right clearfix">



                                <img src="fileDownload.do?downname=2016101311181380861" title="심은섭" class="chat-img pull-right img-circle"/>


                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 4달전</small>
                                        <strong class="pull-right primary-font">심은섭</strong>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=110">게시물[2016-11-25]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>





                            <li class="left clearfix">


                                                        <span class="chat-img pull-left img-circle">
                                                            <i class="glyphicon glyphicon-user noPhoto"></i>
                                                        </span>



                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">최동철</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 5달전
                                        </small>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=101">게시물[2016-11-21]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>







                            <li class="right clearfix">


                                                    <span class="chat-img pull-right img-circle">
                                                        <i class="glyphicon glyphicon-user noPhoto"></i>
                                                    </span>



                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 5달전</small>
                                        <strong class="pull-right primary-font">최동철</strong>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=101">게시물[2016-11-21]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>





                            <li class="left clearfix">


                                                        <span class="chat-img pull-left img-circle">
                                                            <i class="glyphicon glyphicon-user noPhoto"></i>
                                                        </span>



                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <strong class="primary-font">최동철</strong>
                                        <small class="pull-right text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 5달전
                                        </small>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=93">게시물[2016-11-15]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>







                            <li class="right clearfix">



                                <img src="fileDownload.do?downname=2016101311181380861" title="심은섭" class="chat-img pull-right img-circle"/>


                                <div class="chat-body clearfix">
                                    <div class="header">
                                        <small class=" text-muted">
                                            <i class="fa fa-clock-o fa-fw"></i> 5달전</small>
                                        <strong class="pull-right primary-font">심은섭</strong>
                                    </div>
                                    <p>
                                        <a href="boardRead.do?brdno=92">게시물[2016-11-15]에 댓글이 추가되었습니다.</a>
                                    </p>
                                </div>
                            </li>



                        </ul>
                    </div>
                </div>
                <!-- Time Line -->

            </div>
            <!-- col-lg-4 -->
        </div>
    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->
</body>

</html>