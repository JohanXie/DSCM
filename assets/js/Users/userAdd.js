var userAdd = new Vue({
    el: '.form-horizontal',
    data: {
        roleList: [],//权限数据
    },

    created: function () {

        var that = this;
        $.ajax({
            type: "get",
            url: "Users_WebService.asmx/InitRoles",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.roleList = json;
            }
        })
    },

    methods: {

        addUser: function () {

            var a;
            ajax1 = $.ajax({
                type: "post",
                url: "Users_WebService.asmx/checkUser",
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
                        url: "Users_WebService.asmx/addUser",
                        data:
                        {
                            TeacherName: $("#userName").val(),
                            Password: $("#password").val(),
                            RoleGUID: $("input[name='Roles']:checked").val(),//*同一组的radio选中的value值
           
                        },
                        success: function (str) {
                       
                       
                        },
                        error: function (msg) {
                            console.log(msg);

                        }
                    })
                }
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);

            })
        }
    }
})