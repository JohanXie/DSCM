var applyCourse = new Vue({
    el: '.page-container',

    data: {
        items: [],
        datas: [],
        choosedCourse: [],

        /*   courseSelected: '0',*///权限是否被选中
        ifsign: false,
    },

    watch: {
        //courseSelected: function () {
        //    if (this.courseSelected == "2") {
        //        this.setSlist(this.choosedCourse); 
        //        this.ifsign = false;
        //    } else {
        //        this.setSlist(this.datas); 
        //    }

        //}
    },

    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "Stu_WebService.asmx/InitStudentChoosedCourses",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                if (json.length == 0) {
                    that.ifsign = true;
                }
                for (var i in json) {
                    if (json[i].CourseFirstStartDate) json[i].CourseFirstStartDate = formatDate(new Date(parseInt(json[i].CourseFirstStartDate.slice(6, 19))));
                    if (json[i].CourseType) {
                        if (json[i].CourseType == "2") {
                            json[i].CourseType = 'CCA课程';
                        }
                    }
                }
                that.choosedCourse = json;

            }
        })

    },

    mounted: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "Stu_WebService.asmx/InitStudentChoosingCourses",
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                for (var i in json) {
                    if (json[i].CourseFirstStartDate) json[i].CourseFirstStartDate = formatDate(new Date(parseInt(json[i].CourseFirstStartDate.slice(6, 19))));
                    if (json[i].CourseType) {
                        if (json[i].CourseType == "2") {
                            json[i].CourseType = 'CCA课程';
                        }
                    }
                }
                that.datas = json;
                that.items = json.slice(0, 50);
            }
        })
    },

    methods: {

        applyCourse: function (guid) {
            var that = this;
            $.ajax({
                type: "post",
                data: {
                    CourseGUID: guid,
                },
                url: "Stu_WebService.asmx/chooseCourse",
                success: function (str) {
                    location.reload();//刷新页面
                    //for (var i = 0; i < that.items.length; i++) {
                    //    if (that.items[i].GUID == guid) {
                    //        that.items.splice(i, 1);
                    //        break;
                    //    }
                    //}
                }
            });
        },

        // 获取需要渲染到页面中的数据
        setSlist(arr) {
            this.items = JSON.parse(JSON.stringify(arr));
        },
    }
})

function formatDate(dt) {
    var year = dt.getFullYear();
    var month = dt.getMonth() + 1;
    var date = dt.getDate();
    var hour = dt.getHours();
    var minute = dt.getMinutes();
    var second = dt.getSeconds();
    return year + "-" + month + "-" + date;
}