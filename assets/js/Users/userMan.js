var userMan = new Vue({
    el: '.page-container',

    data: {
        totalCount: 200,//课程选课总学生数

        teachers: [],
        items: [],//显示的数据

        keepTeacherShow: true,
        keepShow: true,
        userValid: true,
    },

    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "Users_WebService.asmx/InitTeachers",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.teachers = json;
                that.items = json;
                that.totalCount = that.items.length;
            }
        })
    },

    methods: {

        chooseTeacherExcel: function () {
            $("#ContentPlaceHolder1_FileUpload2").click();
            this.keepTeacherShow = false;

        },

        chooseExcel: function () {
            $("#ContentPlaceHolder1_FileUpload1").click();
            this.keepShow = false;

        },

        importStu: function () {
            $("#ContentPlaceHolder1_Button1").click();
        },

        importTeacher: function () {
            $("#ContentPlaceHolder1_Button2").click();
        },

        Delete: function (guid) {
            $.ajax({
                type: "post",
                data: {
                    GUID: guid
                },
                url: "Users_WebService.asmx/DelUser",
                success: function (str) {
                    location.reload();//刷新页面
                }
            });
        },

        admin_stop: function (obj, guid) {
            var el = obj.currentTarget; //获取点击对象的标签信息
            var that = this;
            layer.confirm('确认要停用吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                $.ajax({
                    type: "post",
                    data: {
                        GUID: guid
                    },
                    url: "Users_WebService.asmx/forbiddenUser",
                    success: function (str) {
                        layer.msg('已停用!', { icon: 5, time: 1000 });
                        location.reload();
                    }
                });
             
            });
               
        },

        admin_start: function (obj, guid) {
            var el = obj.currentTarget;
        
            layer.confirm('确认要启用吗？', function (index) {
                $.ajax({
                    type: "post",
                    data: {
                        GUID: guid
                    },
                    url: "Users_WebService.asmx/ensureUser",
                    success: function (str) {
                        layer.msg('已启用!', { icon: 6, time: 1000 });
                        location.reload();
                    }
                });
               
            });
        }

    }
})


/*用户-添加*/
function user_add(title, url, w, h) {
    layer_show(title, url, w, h);
}