<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="CourseScore.aspx.cs" Inherits="EM_CourseScore" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <nav class="breadcrumb">
           <i class="Hui-iconfont">&#xe67f;</i> 首页 
           <span class="c-gray en">&gt;</span>  课程成绩 
           <span class="c-gray en">&gt;</span> 导出成绩表 
           <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
               <i class="Hui-iconfont">&#xe68f;</i>
           </a>
       </nav>

     <div class="page-container">

           <div class="cl pd-5 bg-1 bk-gray mt-20"> 
                    <span class="l">
                         <a href="javascript:;" class="btn btn-secondary radius">
                              <i class="Hui-iconfont">&#xe644;</i><span>&nbsp;导出学生成绩表</span> 
                         </a> 
                    </span>
             </div>

         <div class="mt-20">
                  <table class="table table-border table-bordered table-bg table-hover table-sort" data-name="cool-table">
                      <thead>
				        <tr class="text-c">
					        <th width="80">班别</th>
					        <th width="100">姓名</th>
					        <th width="80">校内学号</th>
					        <th width="150">课程名称</th>
					        <th width="150">成绩</th>
				        </tr>
			        </thead>

            	        <tbody>
                          <template v-for="(item,index) of items" v-model="items"  v-clock>
				                <tr class="text-c">
					                <td> {{item.PoliticClass}}</td>
					                <td> {{item.StudentName}}</td>
					                <td> {{item.SchoolNum}}</td>
					                <td>{{item.CourseName}}</td>
					                <td class="text-c">{{item.Grade}}</td>
				                </tr>
                          </template>
			        </tbody>

                  </table>
              </div>

     </div>

    <script src="../assets/js/EM/courseScore.js"></script>
      <script src="../assets/js/excel/xlsx.core.min.js"></script>
         <script src="../assets/js/excel/blob.js"></script>
        <script src="../assets/js/excel/FileSaver.min.js"></script>
       <script src="../assets/js/excel/tableexport.js"></script>
    <script type="text/javascript">
        $(function () {

            $("table").tableExport({
                headings: true, 
                formats: ["xlsx"],
                fileName: "课程成绩表",
                bootstrap: true,
                position: "bottom",
            });

            $(".xlsx").css("opacity", "0");

            $(".btn-secondary").click(function () {
                $(".xlsx").click();
            })
		})
	</script>
</asp:Content>

