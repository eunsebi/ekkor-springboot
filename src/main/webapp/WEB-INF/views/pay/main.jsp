{{# partial "title" }}Pay{{/partial}}

{{# partial "content" }}

<div id='calendar'></div>

{{/partial}}

{{# partial "style" }}
<link rel="stylesheet" href="/resource/public/ekko-lightbox/ekko-lightbox.min.css">
<link rel="stylesheet" href="/resource/public/ekko-lightbox/dark-theme.css">

<!-- Calendar stylesheet start -->
<link href='/resource/public/calendar/css/fullcalendar.css' rel='stylesheet' />

<style type='text/css'>

    body {
        margin-top: 40px;
        text-align: center;
        font-size: 14px;
        font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    }

    #calendar {
        width: 900px;
        margin: 0 auto;
    }

</style>
<!-- Calendar stylesheet end -->

{{/partial}}

{{# partial "script-page" }}
<script src="/resource/public/ekko-lightbox/ekko-lightbox.min.js"></script>
<script type="text/javascript" src="/resource/app/js/feed/app.js"></script>
<script type="text/javascript">
    $(function(){
        Feed.init();
        FeedPager.init(FeedList.getSize(), Feed.moreList);
    });
</script>

<!-- Calendar script start -->
<script src='/resource/public/calendar/jquery/jquery-ui-custom.js'></script>
<script src='/resource/public/calendar/fullcalendar.min.js'></script>

<script type='text/javascript'>

    $(document).ready(function() {

        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();

        $('#calendar').fullCalendar({
            editable: true,
            events: [
                {
                    title: 'All Day Event',
                    start: new Date(y, m, 1)
                },
                {
                    title: 'Long Event',
                    start: new Date(y, m, d-5),
                    end: new Date(y, m, d-2)
                },
                {
                    id: 999,
                    title: 'Repeating Event',
                    start: new Date(y, m, d-3, 16, 0),
                    allDay: false
                },
                {
                    id: 999,
                    title: 'Repeating Event',
                    start: new Date(y, m, d+4, 16, 0),
                    allDay: false
                },
                {
                    title: 'Meeting',
                    start: new Date(y, m, d, 10, 30),
                    allDay: false
                },
                {
                    title: 'Lunch',
                    start: new Date(y, m, d, 12, 0),
                    end: new Date(y, m, d, 14, 0),
                    allDay: false
                },
                {
                    title: 'Birthday Party',
                    start: new Date(y, m, d+1, 19, 0),
                    end: new Date(y, m, d+1, 22, 30),
                    allDay: false
                },
                {
                    title: 'Click for Google',
                    start: new Date(y, m, 28),
                    end: new Date(y, m, 29),
                    url: 'http://google.com/'
                }
            ]
        });

    });

</script>
<!-- Calendar script end -->
{{/partial}}

{{> template/base}}


