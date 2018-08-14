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
/*用户-添加*/
function user_add(title, url, w, h) {
    layer_show(title, url, w, h);
}
