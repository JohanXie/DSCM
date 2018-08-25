var courseScoreVue = new Vue({
    el: ".page-container",

    data: {
        items: []
    },

    created: function () {
     
        var that = this;
        $.ajax({
            type: "get",
            url: "EM_WebService.asmx/exportCourseScoreExcel",
            data: { ScoreReportGUID: GetQueryString("ID") },
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.items = json;
            }
        })
    },

})

//获取url参数
function GetQueryString(name) {

    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");

    var r = window.location.search.substr(1).match(reg);

    if (r != null) return decodeURI(r[2]); return null;//js解决url中文传值乱码

}