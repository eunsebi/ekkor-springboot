{{# partial "title" }}Pay{{/partial}}

{{# partial "content" }}
<div class="container">
    <form id="payLoginForm" name="loginForm" method="post" class="form-horizontal">
        <div class="row" style="height: 40px">
            <div class="col-xs-4 text-left">
                <span style="color: #428bca;"><a href="#">Forgot password?</a></span>
            </div>
        </div>
        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-user"></i></span>
            <input type="text" class="form-control" name="email" id="email" placeholder="email address" value="">
        </div>
        <span class="help-block"></span>

        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
            <input type="password" class="form-control" name="passwd" id="passwd" placeholder="Password" value="">
        </div>

        <span class="help-block" style="color: red; display: none" id="loginInfo">로그인 정보가 올바르지 않습니다. 아이디/비밀번호를 확인하세요.</span>

        <div style="padding-top:10px;border-top: 1px solid #e5e5e5">
            <div class="col-xs-4">
                <label class="checkbox">
                    <input type="checkbox" id="remember-me" name="remember-me" value="Y">Save ID
                </label>
            </div>
            <div class="col-xs-4" >
                <button type="button" class="btn btn-primary" id="payLoginBtn">Log in</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            </div>

        </div>

    </form>
</div>

{{/partial}}

{{# partial "style" }}

{{/partial}}

{{# partial "script-page" }}
<script src="/resource/public/ekko-lightbox/ekko-lightbox.min.js"></script>
<script type="text/javascript" src="/resource/app/js/feed/app.js"></script>
<script type="text/javascript" src="/resource/app/js/pay/pay.js"></script>
<script type="text/javascript">
    $(function(){
        Feed.init();
        FeedPager.init(FeedList.getSize(), Feed.moreList);
    });
</script>
{{/partial}}

{{> template/base}}


