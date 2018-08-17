var classStudentsInCourseVue = new Vue({
    el: ".page-container",

    data: {
        items: []
    },

    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "CL_WebService.asmx/exportClassStudentsExcel",
            success: function (str) {
                var ss = [];
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.items = json;
            }
        })
    },

})