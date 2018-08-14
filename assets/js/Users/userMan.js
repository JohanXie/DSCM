﻿var userMan = new Vue({
    el: '.page-container',
    data: {
        totalCount: 200,//课程选课总学生数

        teachers: [],
        items: [],//显示的数据

        keepShow: true,
    },
    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "Users_WebService.asmx/InitTeachers",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.teachers = json;
                that.items = json;
                that.totalCount = that.items.length;
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
        }
    }
})