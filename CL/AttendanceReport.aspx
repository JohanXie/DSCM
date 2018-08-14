<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="AttendanceReport.aspx.cs" Inherits="CL_AttendanceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 课程管理 <span class="c-gray en">&gt;</span> 导出考勤表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>

      <div class="page-container">

            <div class="cl pd-5 bg-1 bk-gray mt-20"> 
                    <span class="l">
                         <a href="javascript:;" class="btn btn-secondary radius">
                              <i class="Hui-iconfont">&#xe6cf;</i><span>&nbsp;导出考勤表</span> 
                         </a> 
                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="导入SQL" style="display:none"/>
                    </span>
             </div>

             <div class="mt-20">
                  <table class="table table-border table-bordered table-bg table-hover table-sort" data-name="cool-table">
                      <thead>
                           <tr class="text-c">
                               <th rowspan="2">序号</th>
                               <th rowspan="2">班别</th>
                               <th rowspan="2">姓名</th>
                               <th rowspan="1" colspan="15">（出席“√”，请假“○”，缺席“△”）</th>
                            </tr>
                            <tr class="text-c">
                                <th rowspan="1" colspan="1">1</th>
                                <th rowspan="1" colspan="1">2</th>
                                <th rowspan="1" colspan="1">3</th>
                                <th rowspan="1" colspan="1">4</th>
                                <th rowspan="1" colspan="1">5</th>
                                <th rowspan="1" colspan="1">6</th>
                                <th rowspan="1" colspan="1">7</th>
                                <th rowspan="1" colspan="1">8</th>
                                <th rowspan="1" colspan="1">9</th>
                                <th rowspan="1" colspan="1">10</th>
                                <th rowspan="1" colspan="1">11</th>
                                <th rowspan="1" colspan="1">12</th>
                                <th rowspan="1" colspan="1">13</th>
                                <th rowspan="1" colspan="1">14</th>
                                <th rowspan="1" colspan="1">15</th>
                            </tr>
                     </thead>

                      <tbody>
                          <template v-for="(item,index) of items" v-model="items"  v-clock>
                              <tr class="text-c">
                                  <td>{{index+1}}</td>
                                  <td>{{item.PoliticClass}}</td>
                                  <td>{{item.StudentName}}</td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                                  <td></td>
                              </tr>
                          </template>
                      </tbody>
                  </table>
            </div>

      </div>
    <script src="../assets/js/CL/attendanceReport.js"></script>
     <script src="../assets/js/excel/xlsx.core.min.js"></script>
         <script src="../assets/js/excel/blob.js"></script>
        <script src="../assets/js/excel/FileSaver.min.js"></script>
       <script src="../assets/js/excel/tableexport.js"></script>
    <script type="text/javascript">
        $(function () {

            $("table").tableExport({
                headings: true, 
                formats: ["xlsx"],
                fileName: "考勤表",
                bootstrap: true,
                position: "bottom",
            });

            $(".xlsx").css("opacity", "0");

            $(".btn-secondary").click(function () {
                  $("#ContentPlaceHolder1_Button1").click();
                //var courseguid = "1e7af029-f292-475e-a078-ac3500c21a9c";
                //$(".xlsx").click();
                // $.ajax({
                //     url: "Handler.ashx?" + courseguid,
                //     secureuri: false,
                //     async:false,
                //     data: {
                //         "courseguid": "1e7af029-f292-475e-a078-ac3500c21a9c"
                //     },
                //    success: function (str) {
                //           window.location = "Handler.ashx?"+courseguid;
                //    }
                //})
            })
		})
	</script>
</asp:Content>

