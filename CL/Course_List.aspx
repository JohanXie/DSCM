<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="Course_List.aspx.cs" Inherits="CL_Course_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 课程管理 <span class="c-gray en">&gt;</span> 课程列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="page-container">

         <div class="text-c"> 
		    <input type="text" name="" id="" placeholder=" 输入课程名称、开课年级、指导老师" style="width:250px" class="input-text">
		    <button name="" id="" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜课程</button>
	    </div>

        <div class="cl pd-5 bg-1 bk-gray mt-20"> 
            <span class="l">
                <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
                <a class="btn btn-primary radius" id="headTeacherReport" :href="['ClassStudentsInCourse.aspx']">
                    <i class="Hui-iconfont">&#xe644;</i> 导出班级选课表
                </a>
                  <a class="btn btn-success radius" id="gradeDirectorReport" :href="['GradeStudentsInCourse.aspx']">
                    <i class="Hui-iconfont">&#xe644;</i> 导出年级选课表
                </a>
                 <a href="javascript:;" class="btn btn-secondary radius">
                     <i class="Hui-iconfont">&#xe645;</i><span v-show="keepShow" @click="chooseExcel()">&nbsp;选择Excel</span> 
                     <span v-show="!keepShow" @click="importStu()">&nbsp;导入课程</span>
                 </a> 
                <asp:FileUpload ID="FileUpload1" runat="server" Width="305px" style="display:none"/>
                    &nbsp; &nbsp;
                 <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="导入SQL" style="display:none"/>
            </span> 
            <span class="r">共有数据：<strong>{{totalCount}}</strong> 条</span> 
        </div>

        <div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="40"><input name="" type="checkbox" value=""></th>
					<th width="80">名称</th>
					<th width="100">课程类型</th>
					<th>指导老师</th>
					<th width="150">上课时间</th>
					<th width="150">上课地点</th>
					<th width="60">开班年级</th>
					<th width="100">开班日期</th>
                    <th width="100">全校报名情况</th>
                    <th width="100">备注</th>
                    <th width="100">操作</th>
				</tr>
			</thead>
			<tbody>
                  <template v-for="(item,index) of items" v-model="items"  v-clock>
				        <tr class="text-c">
					        <td><input name="" type="checkbox" value=""></td>
					        <td>{{item.CourseName}}</td>
					        <td>{{item.CourseType}}</td>
					        <td>{{item.CoursesTeachers}}</td>
					        <td>{{item.CourseWeekDate}}</td>
					        <td class="text-c">{{item.CourseSite}}</td>
					        <td>{{item.CourseGender}}</td>
					        <td class="td-status">{{item.CourseFirstStartDate}}</td>
					        <td class="td-manage">
                                {{item.ChoosedStudentsNum}}/{{item.CourseLimitNum}}
                                <a :href="['CourseUsersShow.aspx?ID='+item.GUID+'&CourseName='+item.CourseName]">
                                  <i class="Hui-iconfont" style="color:#44708e;cursor:pointer;font-size:16px">&#xe695;</i>
                               </a>
					        </td>
                            <td>{{item.CourseNote}}</td>
                            <td class="td-manage">
                               <a style="text-decoration:none" :href="['/CM/EM/StudentCourseEvaluation.aspx?ID='+item.GUID]"  title="课程评价">
                                  <i class="Hui-iconfont">&#xe692;</i>
                              </a>

                               <a style="text-decoration:none" :href="['StudentsInCourse.aspx?ID='+item.GUID]"  title="导出选课表">
                                  <i class="Hui-iconfont">&#xe644;</i>
                              </a>

                               <a style="text-decoration:none" :href="['AttendanceReport.aspx?ID='+item.GUID]"  title="导出考勤表">
                                  <i class="Hui-iconfont">&#xe618;</i>
                              </a>
                            </td>
				        </tr>
                  </template>
			</tbody>
		</table>
	</div>


          <%--展现课程用户的Modal--%>
        <div class="modal fade" id="showCourseUsers" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">

                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">报名结果</h4>
                    </div>

                    <div class="modal-body" style="padding: 25px 25px 0 25px;">

                      
                    </div>

                    <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>

                </div>
            </div>
        </div>
          <%--展现课程用户的Modal--%>

    </div>

     <script type="text/javascript" src="../lib/My97DatePicker/4.8/WdatePicker.js"></script>
    <script src="../assets/js/CL/courseList.js"></script>
</asp:Content>

