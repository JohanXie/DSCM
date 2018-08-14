var studentCourseEvaluationVue = new Vue({

    el: '.page-container',

    data:{
        items: [],
        studentsEvaluation: [],

        evaluateSelect: null,
    },

    created: function () {
        var that = this;
        if (GetQueryString("ID")) {
       
            $.ajax({
                type: "get",
                url: "EM_WebService.asmx/getCourseStudents",
                data: { CourseGUID: GetQueryString("ID") },
                success: function (str) {
                    var ss = [];
                    a = $(str).find("string").text();
                    var json = eval('(' + a + ')');
                    that.items = json;
                }
            })
          
        } else {

        }
    },

    watch: {
       
    },


    methods: {
        postEvaluation: function () {
            var evaluationData = JSON.stringify(this.studentsEvaluation);
         
            $.ajax({
                type: "post",
                url: "EM_WebService.asmx/addStudentsEvaluation",
                data: { EvaluationData: evaluationData },
                dataType: 'json',
                success: function (data) {
                   
                },
                error: function () {
                   
                }
            });

         
       
            layer.msg('成功提交课程评价!', { icon: 6, time: 2000 });
           
        },

        addData: function (event, GUID) {
            var arr = {};
            arr.GUID = GUID;
            arr.CourseGUID = GetQueryString("ID");
            arr.Evaluation = event.target.value;
            this.studentsEvaluation.push(arr);
           
        }

    }

})

function saveTable() {
    debugger;
    var saveData = [];//新建对象，用来存储所有数据

    var dcCode, sectionCode, sectionName, itemNo, itemName;
    $("#td tr").each(function (trindex, tritem) {//遍历每一行
        var tableData = {};
        $(tritem).find("td").each(function (tdindex, tditem) {
            //当天td的值，再根据tdindex设置属性
            var tdValue = $(tditem).text();
            if (tdIndex == 0) {//第0列是code
                tableData.dcCode = tdValue;
            }
            if (tdIndex == 1) {
                tableData.sectionCode = tdValue
            }
            if (tdIndex == 2) {
                tableData.sectionName = tdValue
            }
            if (tdIndex == 3) {
                tableData.itemNo = tdValue
            }
            if (tdIndex == 4) {
                tableData.itemName = tdValue
            }
        });
        saveData.push(tableData);//将每一行的数据存入
    });
}

//获取url参数
function GetQueryString(name) {

    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");

    var r = window.location.search.substr(1).match(reg);

    if (r != null) return unescape(r[2]); return null;

}