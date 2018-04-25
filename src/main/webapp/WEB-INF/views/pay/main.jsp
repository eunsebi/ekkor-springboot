{{# partial "title" }}Pay{{/partial}}

{{# partial "content" }}

<center>
<iframe dth="1300" height="900" src="http://ekkor.ze.am/pay/home/main.do" name="test" id="test" frameborder="0" scrolling="auto" align="middle">
이 브라우저는 iframe을 지원하지 않습니다.</iframe>
</center>

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


