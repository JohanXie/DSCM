var courseList = new Vue({
    el: '.page-container',

    data: {
        totalCount: 200,//课程选课总学生数

        datas: [],//总的数据
        items: [],//显示的数据
        classNums: ["1","2"],
        classStus: ["3", "4","5","6"],

        keepShow: true,
    },

    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "CL_WebService.asmx/InitCourses",
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                for (var i in json) {
                    if (json[i].CourseFirstStartDate) json[i].CourseFirstStartDate = formatDate(new Date(parseInt(json[i].CourseFirstStartDate.slice(6, 19))));
                    if (json[i].CourseType) {
                        //if (json[i].CourseType == "2") {
                        //    json[i].CourseType = 'CCA课程';
                        //}
                    };
                    if (parseInt(json[i].CourseLimitNum) == 0) {
                            json[i].CourseLimitNum = "不限";
                    }
                  
                }
                that.datas = json;
                that.items = json.slice(0, 50);
                that.totalCount = that.datas.length;
            }
        })
    },

    methods: {
        chooseExcel: function () {
            $("#ContentPlaceHolder1_FileUpload1").click();
            this.keepShow = false;
          
        },

        importStu: function () {
            $("#ContentPlaceHolder1_Button1").click();
        },

        exportRegisteration: function (guid) {
          
            $.ajax({
                type: "post",
                url: "Handler.ashx?courseguid="+guid,
                async:false,
                data:{
                    "courseguid": "123"
                },
                success: function (str) {
                    //console.log($(str).find("string").text());
                    window.location = "Handler.ashx";
                    //CL_WebService.asmx/exportRegisterExcel
                },
                error: function (msg) {

                    alert("出现错误，请稍后再试:" + msg.responseText);
                }
            })
           
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