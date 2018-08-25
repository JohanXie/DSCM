<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="StudentCourseEvaluation.aspx.cs" Inherits="EM_StudentCourseEvaluation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="page-container">

           <nav class="breadcrumb">
                <i class="Hui-iconfont">&#xe67f;</i> 首页 
                <span class="c-gray en">&gt;</span> 课程评价
                <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
                    <i class="Hui-iconfont">&#xe68f;</i>
                </a>
           </nav>

          	<table class="table table-border table-bordered table-bg table-hover table-sort">
                  <tbody>
                      <tr>
                          <td colspan="2">所属学期</td>
                          <td colspan="10">
                              <select v-model="yearSelected">
                                  <option value="-1">选择学年</option>
                                   <option value="2018学年">2018学年</option>
                              </select>
                               <select v-model="termSelected">
                                  <option value="-1">选择学期</option>
                                  <option value="上学期">上学期</option>
                                  <option value="下学期">下学期</option>
                              </select>
                          </td>
                      </tr>
                      <tr>
                          <td colspan="2">课程名</td>
                          <td colspan="10">
                               <select id="course">
                                  <option value="-1">选择课程</option>
                                  <option v-for="(item,index) of courseItems" :value="item.GUID">
                                      {{item.CourseName}}
                                  </option>
                              </select>
                          </td>
                      </tr>
                      <tr>
                            <td colspan="2"></td>
                            <td colspan="10">
                               <table class="table table-border table-bordered table-bg table-hover table-sort">
                                   <thead>
                                       <tr class="text-c">
                                           <th>班级</th>
                                            <th>姓名</th>
                                            <th>评价</th>
                                        </tr>
                                   </thead>

                                   <tbody id="td">
                                      <template v-for="(item,index) of  courseStudents" v-model="courseStudents"  v-clock>
				                            <tr class="text-c">
                                                <td>{{item.PoliticClass}}</td>
                                                 <td>{{item.StudentName}}</td>
                                                 <td>
                                                     <select :id="item.GUID" @change="addData($event,item.GUID)">
                                                         <option value="-1">选择评价</option>
                                                          <option>优秀</option>
                                                          <option>良好</option>
                                                          <option>及格</option>
                                                          <option>不及格</option>
                                                     </select>
                                                 </td>
                                            </tr>
                                       </template>
                                    </tbody>

                               </table>
                            </td>
                      </tr>
                  </tbody>

            </table>

          <br />
          <div class="text-c"> 
              <input type="button" class="btn btn-secondary radius va-m" value="提交评价" @click="postEvaluation()"/>
          </div>
          
     </div>

    <script src="../assets/js/EM/studentCourseEvaluation.js"></script>

</asp:Content>

