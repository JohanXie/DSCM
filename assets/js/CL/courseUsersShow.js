var courseUsersShow = new Vue({
    el: '.page-container',
    data: {
        totalCount: 200,//课程选课总学生数

        datas: [],//总的数据
        items: [],//显示的数据
        classList: {},//课程班级
        classItems: {},
        studentsList: [],//学生列表
        copystudentsList: [],

        courseName: '',
        classSelected: '-1',
        searchlist: [],//查询提示词
        gradeSelected: '-1',
        classSelected2: '-1',
        has: false,//判断是否显示sub
        chosedata: [],//选中的
    },

    created: function () {
        //alert(GetQueryString("ID"));
        var that = this;
        this.courseName = GetQueryString("CourseName");
     
        $.ajax({
            type: "get",
            url: "CL_WebService.asmx/InitCourseUsers",
            data: { CourseGUID: GetQueryString("ID")},
            success: function (str) {
                var ss = [];
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                for (var i in json) {
                    if (i == 0) {
                        ss.push(json[i].PoliticClass);
                    } else {
                    
                            if (json[i-1].PoliticClass != json[i].PoliticClass) {
                                ss.push(json[i].PoliticClass);
                            }
                       
                    }
                        
                }
              
                that.classList = ss;
                that.datas = json;
                that.items = json.slice(0, 50);
                that.totalCount = that.items.length;
            }
        })

        $.ajax({
            type: "get",
            url: "CL_WebService.asmx/InitStudents",
            success: function (str) {
                var ss = [];
                students = $(str).find("string").text();
                var json2 = eval('(' + students + ')');
                that.studentsList = json2;
                that.copystudentsList = json2;
            }
        });


      
    },

    watch: {
        classSelected: function () {

            if (this.classSelected != "-1") {
                var that = this;
                var ss = [];
                this.datas.forEach(function (item) {
                    if (item.PoliticClass == that.classSelected) {
                        ss.push(item);

                    }
                })
                this.setSlist(ss);
            }
            else {
                this.setSlist(this.datas);
            }
        },

        gradeSelected: function () {
            var that = this;
            if (this.gradeSelected != "-1") {
                this.has = true;
                $.ajax({
                    type: "get",
                    url: "CL_WebService.asmx/InitClass",
                    data: { Grade: this.gradeSelected },
                    success: function (str) {
                        var s = $(str).find("string").text();
                        that.classItems = eval('(' + s + ')');
                    }
                });
            }
        },

        classSelected2: function () {
            var that = this;
            if (this.classSelected2!= "-1") {
                var ss = [];
                this.studentsList.forEach(function (item) {

                    if ($.trim(item.PoliticClass) == $.trim(that.classSelected2)) {
                        ss.push(item);
                      
                    }
                })
                this.setStudentsList(ss);
            }
        }
    },

    methods: {
        // 获取需要渲染到页面中的数据
        setSlist(arr) {
            this.items = JSON.parse(JSON.stringify(arr));
        },

        setStudentsList(arr) {
            this.studentsList = JSON.parse(JSON.stringify(arr));
        },

        Delete: function (guid) {
            $.ajax({
                type: "post",
                data: {
                    GUID: guid,
                    CourseGUID: GetQueryString("ID")
                },
                url: "CL_WebService.asmx/DelCourseStudent",
                success: function (str) {
                    location.reload();//刷新页面
                }
            });
        },

        batchDel: function () {
            var ids = [];
            var ss = [];
            this.chosedata = [];
            $(".cl  input[type=checkbox]").each(function () {
                if ($(this).val() != 0) {
                    if ($(this).prop('checked')) {
                        ids.push($(this).val());
                    }
                }
            });

            this.items.forEach(function (item) {
                for (var i = 0; i <= ids.length; i++) {
                    if (item.ID == ids[i]) {
                        ss.push(item)
                    }
                }

            })
            this.chosedata = ss;

            var userids = "";
            var stusLen = this.chosedata.length;
            for (var i in this.chosedata) {
                if (this.chosedata[i]) userids += this.chosedata[i].ID + ",";
            }
            if (userids.lastIndexOf(",") == userids.length - 1) userids = userids.substring(0, userids.length - 1);
            if (userids != "") {
                $.ajax({
                    type: "get",
                    url: "CL_WebService.asmx/datchDelStusInCourse",
                    data: {
                        "ids": userids,
                        "CourseGUID": GetQueryString("ID"),
                        "StusLen": parseInt(stusLen)
                    },
                    success: function (str) {
                        layer.msg('成功删除用户!', { icon: 6, time: 10 });
                        location.reload();//刷新页面
                    }
                });
            }           
        },

        // 搜索用户
        searchStudent(e) {
            var v = e.target.value,
                self = this;
            self.searchlist = [];
            if (v) {
                var ss = [];
                // 过滤需要的数据
                this.copystudentsList.forEach(function (item) {

                    if (item.StudentName.indexOf(v) > -1) {
                        if (self.searchlist.indexOf(item.StudentName) == -1) {

                            self.searchlist.push(item.StudentName);

                        }
                        ss.push(item);
                    }
                });
                this.setStudentsList(ss); // 将过滤后的数据给了slist
            } else {
                this.setStudentsList(this.copystudentsList);
            }
        },

        addStudentIntoCourse: function(selected){
            var chk_value = [];
            $('input[name="studentsList"]:checked').each(function () {
                chk_value.push($(this).val());
            });
            var ids = chk_value.toString();
            var len = chk_value.length;
            $.ajax({
                type: "post",
                data:
                    {
                        CourseGUID: GetQueryString("ID"),
                        StudentsGUID: ids
                    },
                async: false,
                url: "CL_WebService.asmx/addStudentsIntoCourse",
                success: function (str) {
                    location.reload();//刷新页面

                }
            })
        }
    }
})



//获取url参数
function GetQueryString(name) {

    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");

    var r = window.location.search.substr(1).match(reg);

    if (r != null) return decodeURI(r[2]); return null;//js解决url中文传值乱码

}