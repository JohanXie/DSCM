var courseAdd = new Vue({
    el: ".page-container",

    data: {
        originalUser: [],
        teacherList: [],
        chooseTeachers: [],
        chooseGrades: {},
        cT: true,
        cG: true,
        grade: { a: '初一', b: '初二', c: '初三', d: '高一', e:'高二', f:'高三'},

        usershow: 5,//展示的用户数
        ellipsis: true,
        searchlist: [],//查询提示词
    },
    
    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "/CM/Users/Users_WebService.asmx/InitTeachers",
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.originalUser = json;
                that.teacherList = json;
            }
        })

    },

    methods: {

        addCourse: function () {
            //var index = layer.open({
            //    type: 2,
            //    title: '123',
            //    content: '/CL/Course_List.aspx'
            //});
            //layer.full(index);
            //window.location.href = "/CL/Course_List.aspx";
            //window.parent.location.reload();
            //var index = parent.layer.getFrameIndex(window.name);
            //parent.layer.close(index);
         
          
            console.log(this.chooseTeachers);
            console.log(this.chooseGrades);
            console.log(Boolean(parseInt($("#courseStatus").find("option:selected").val())));
            var teachersName = [];
            for (var i in this.chooseTeachers) {
                if (this.chooseTeachers[i].GUID) {
                    //teachersGUID.push(this.chooseTeachers[i].GUID);
                    teachersName.push(this.chooseTeachers[i].TeacherName);
                }
            }
   
            $.ajax({
                type: "post",
                url: "CL_WebService.asmx/addCourse",
                async: false,
                data:
                {
                    CourseName: $("#courseName").val(),
                    CourseFirstStartDate: $("#courseFirstStartDate").val(),
                    CourseWeekDate: $("#courseWeekDate").val(),
                    CourseSite: $("#courseSite").val(),
                    CourseLimitNum: parseInt($("#courseLimitNum").val()),
                    CourseStatus: Boolean(parseInt($("#courseStatus").find("option:selected").val())),//真假数据类型转换
                    CourseType: $("#courseType").find("option:selected").text(),
                    CourseTeachers: teachersName.toString(),
                    CourseGender: this.chooseGrades.toString(),
                    CourseNote: $("#courseNote").val(),
                },
                success: function (str) {
                    layer.msg('已添加课程!', { icon: 6, time: 1000 });

                },
                error: function (msg) {
                    console.log(msg);

                }
            })
           
        },

        changeUsers() {
            this.usershow = this.teacherList.length;
            this.ellipsis = false;
        },

        selectedTeachers: function () {
            var ids = [];
            var ss = [];
            $("#tb2 input[type=checkbox]").each(function () {
                if ($(this).val() != 0) {
                    if ($(this).prop('checked')) {
                        ids.push($(this).val());
                    }
                }
            });

            this.teacherList.forEach(function (item) {
                for (var i = 0; i <= ids.length; i++) {
                    if (item.ID == ids[i]) {
                        ss.push(item)
                    }
                }

            })
            this.chooseTeachers = ss;
            this.cT = false;
        },

        selectedGrade: function () {
            var ids = [];
            $("#tb3 input[type=checkbox]").each(function () {
                if ($(this).val() != 0) {
                    if ($(this).prop('checked')) {
                        ids.push($(this).val());
                    }
                }
            });
            this.chooseGrades = ids;
            this.cG = false;
        },

        // 搜索用户
        searchUser(e) {
            var v = e.target.value,
                self = this;
            self.searchlist = [];

            if (v) {
                var ss = [];

                // 过滤需要的数据
                this.teacherList.forEach(function (item) {
                    if (item.TeacherName.indexOf(v) > -1) {
                        if (self.searchlist.indexOf(item.TeacherName) == -1) {
                            self.searchlist.push(item.TeacherName);
                        }
                        ss.push(item);

                    }
                })
                this.setUserList(ss); // 将过滤后的数据给了slist

            } else {
                // 没有搜索内容，则展示全部数据
                this.setUserList(this.originalUser);
            }
        },

        setUserList(arr) {
            this.teacherList = JSON.parse(JSON.stringify(arr));
        },
    }
})