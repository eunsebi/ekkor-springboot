$("#payLoginBtn").click(function() {
    payLogin();
});

function payLogin() {
    alert("payLogin Function");
    $.post("http://ekkor.ze.am/pay/user/login.do", {email:$('#email').val(),passwd:$('#email').val()});
    /*$.ajax({
        url : "http://ekkor.ze.am/pay/user/login.do",
        data : {email:$('#email').val(),passwd:$('#passwd').val()},
        type : 'POST',
        success:function(response){
            var result = JSON.parse(response);
            alert(result.msg);
            /!*if(result.isLogin){
                location.href = '<c:url value="/home/main.do"/>';
            }else{
                alert(result.msg);
            }*!/
        },
        error:function(response){
            alert(response.msg);
            console.log(response);
        }
    });*/
}