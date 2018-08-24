var studentScoreListVue = new Vue({
    el: '.mt-20',

    data: {
        items: [],
    },

    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "EM_WebService.asmx/getScoreReport",
            data: {  },
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.items = json;
            }
        })
    }
})