/*课程-添加*/
function course_add(title, url) {
    var index = layer.open({
        type: 2,
        title: title,
        content: url
    });
    layer.full(index);
}

/*用户-添加*/
function user_add(title, url, w, h) {
    layer_show(title, url, w, h);
}

$('#editInfoModal').on('shown.bs.modal', function () {
    $.ajax({
        type: "get",
        url: "/CM/Users/Users_WebService.asmx/getUserInfo",
        success: function (str) {

            a = $(str).find("string").text();
            var json = eval('(' + a + ')');
            for (var i in json) {
                $("#TeacherName").val(json[i].TeacherName);
                $("#Class").val(json[i].NowTeachClass);
                if (json[i].IsHeadTeacher) {
                    $("input[name=HeadTeacher][value=" + 1 + "]").prop("checked", true); //设置当前性别选中项
                } else {
                    $("input[name=HeadTeacher][value=" + 0 + "]").prop("checked", true); //设置当前性别选中项
                }
               


            }
        }
    })
   
})




