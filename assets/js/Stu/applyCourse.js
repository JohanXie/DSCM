var applyCourse = new Vue({
    el: '.page-container',

    data: {
        items: [],
        datas: [],
        choosedCourse: [],
        searchlist: [],//查询提示词

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
                if (json.length == 0 || json.length == 1) {
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
                that.items = json;
            }
        })
    },

    methods: {

        applyCourse: function (guid,weekdate) {
            var that = this;
            var a;
            ajax1 = $.ajax({
                type: "post",
                url: "Stu_WebService.asmx/checkCourseDate",
                async: false,  //同步，既做完才往下
                success: function (str) {
                    b = $(str).find("string").text();
                    var json = eval('(' + b + ')');
                 
                    if (json.length == 1) {
                      
                        for (var i in json) {
                         
                            if (json[0].CourseWeekDate == weekdate) {
                                    a = 1;
                                }
                        
                        }
                    }
                }
            })

            $.when(ajax1).done(function () {
                //所做操作
                if (a == 1) {
                    alert("课程时间冲突");
                    return;
                } else {
                    $.ajax({
                        type: "post",
                        data: {
                            CourseGUID: guid,
                        },
                        url: "Stu_WebService.asmx/chooseCourse",
                        success: function (str) {
                            alert("选课成功");
                            location.reload();//刷新页面
                            //for (var i = 0; i < that.items.length; i++) {
                            //    if (that.items[i].GUID == guid) {
                            //        that.items.splice(i, 1);
                            //        break;
                            //    }
                            //}
                        }
                    });
                }
            })

           
        },

        // 获取需要渲染到页面中的数据
        setSlist(arr) {
            this.items = JSON.parse(JSON.stringify(arr));
        },

        // 搜索用户
        searchCourse(e) {
            var v = e.target.value,
                self = this;
            self.searchlist = [];
            if (v) {
                var ss = [];

                // 过滤需要的数据
                this.items.forEach(function (item) {
                    if (item.CourseName.indexOf(v) > -1) {
                        if (self.searchlist.indexOf(item.CourseName) == -1) {
                            self.searchlist.push(item.CourseName);
                        }
                        ss.push(item);

                    } else if (item.CoursesTeachers) {
                        if (item.CoursesTeachers.indexOf(v) > -1) {
                            if (self.searchlist.indexOf(item.CoursesTeachers) == -1) {
                                self.searchlist.push(item.CoursesTeachers);
                            }
                            ss.push(item);
                        }

                    }
                })
                this.setSlist(ss); // 将过滤后的数据给了slist
            } else {
                // 没有搜索内容，则展示全部数据
                this.setSlist(this.datas);
            }
        }
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