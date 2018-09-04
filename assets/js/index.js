var index = new Vue({
    el: '#addInfoModal',

    data: {
        roleList: [],//权限数据
        classItems: {},

        gradeSelected: '-1',
        classSelected: '-1',
        className: '',
        has: false,//判断是否显示sub
    },

    mounted: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "/CM/Users/Users_WebService.asmx/InitRoles",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.roleList = json;
            }
        })
    },

    watch: {
        gradeSelected: function () {
            var that = this;
            if (this.gradeSelected != "-1") {
                this.has = true;
                $.ajax({
                    type: "post",
                    url: "/CM/CL/CL_WebService.asmx/InitClass",
                    data: {
                        Grade: this.gradeSelected
                    },
                    success: function (str) {
                        var s = $(str).find("string").text();
                        that.classItems = eval('(' + s + ')');
                    }
                });

            }
        },
    },

    methods: {
        addUser: function () {
            var a;
            var that = this;
            ajax1 = $.ajax({
                type: "post",
                url: "/CM/Users/Users_WebService.asmx/checkUser",
                async: false,  //同步，既做完才往下
                data: { UserName: $("#userName").val() },
                success: function (str) {
                    a = $(str).find("int").text();
                }
            })

            $.when(ajax1).done(function () {
                //所做操作
                if (a == 1) {
                    alert("用户名已存在");
                    return;
                }
                else if (typeof ($("input[name='Roles']:checked").val()) == "undefined") {
                    alert("请设置权限");
                    return;
                }
                else {
                    $.ajax({
                        type: "post",
                        url: "/CM/Users/Users_WebService.asmx/addUser",
                        data:
                        {
                            TeacherName: $("#userName").val(),
                            Password: $("#password").val(),
                            NowTeachClass: that.classSelected,
                            IsHeadTeacher: $("input[name='HeadTeacher']:checked").val(),
                            RoleGUID: $("input[name='Roles']:checked").val(),//*同一组的radio选中的value值

                        },
                        success: function (str) {
                            $('#addInfoModal').modal('hide');
                            layer.msg('成功添加用户!', { icon: 6, time: 1000 });
                           
                         
                        },
                        error: function (msg) {
                            console.log(msg);

                        }
                    })
                }
                //////刷新页面
                //parent.window.location.href = '/CM/Users/User_Man.aspx';
                //////获取窗口索引
                //var index = parent.layer.getFrameIndex(window.name);
                //////关闭弹出层
                //parent.layer.close(index);


            })
        }
    },

})



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




