var studentScoreListVue = new Vue({
    el: '.mt-20',

    created: function () {
        $.ajax({
            type: "get",
            url: "EM_WebService.asmx/getScoreReport",
            data: {  },
            success: function (str) {
                var ss = [];
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.items = json;
            }
        })
    }
})