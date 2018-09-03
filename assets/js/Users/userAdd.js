var userAdd = new Vue({
    el: '.form-horizontal',
    data: {
        roleList: [],//权限数据
        userInfo: [],
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
            url: "Users_WebService.asmx/InitRoles",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.roleList = json;
                if (GetQueryString("ID")) {
                    $.ajax({
                        type: "get",
                        url: "Users_WebService.asmx/getUserInfo",
                        data: { GUID: GetQueryString("ID") },
                        async: false,
                        success: function (str) {
                            b = $(str).find("string").text();
                            var json2 = eval('(' + b + ')');
                            for (var i in json2) {
                                that.gradeSelected = json2[i].NowTeacherGrade;
                                that.className = json2[i].NowTeachClass;
                                if (json2[i].IsHeadTeacher) {
                                    json2[i].IsHeadTeacher = "1";
                                } else {
                                    json2[i].IsHeadTeacher = "0";
                                }

                            }
                            that.userInfo = json2;

                        }
                    })
                }
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
                    url: "../CL/CL_WebService.asmx/InitClass",
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
            if (GetQueryString("ID")) {
                alert($('#gradeSelected option:selected').text());
                $.ajax({
                    type: "get",
                    url: "Users_WebService.asmx/updateUserInfo",
                    data: {
                        GUID: GetQueryString("ID"),
                        Grade: 123,
                        Class: 123,
                    },
                    success: function (str) {
                        layer.msg('成功修改信息!', { icon: 6, time: 1000 });
                    }
                });
            } else {
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
                                NowTeachClass: that.classSelected,
                                IsHeadTeacher: $("input[name='HeadTeacher']:checked").val(),
                                RoleGUID: $("input[name='Roles']:checked").val(),//*同一组的radio选中的value值

                            },
                            success: function (str) {

                            },
                            error: function (msg) {
                                console.log(msg);

                            }
                        })
                    }
                    //刷新页面
                    parent.window.location.href = 'User_Man.aspx';
                    //获取窗口索引
                    var index = parent.layer.getFrameIndex(window.name);
                    //关闭弹出层
                    parent.layer.close(index);


                })


            }
      
       }
    }
})

//获取url参数
function GetQueryString(name) {

    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");

    var r = window.location.search.substr(1).match(reg);

    if (r != null) return decodeURI(r[2]); return null;//js解决url中文传值乱码

}