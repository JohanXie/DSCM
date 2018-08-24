<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="StudentScoreList.aspx.cs" Inherits="EM_StudentScoreList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="mt-20">
          	<table class="table table-border table-bordered table-bg table-hover table-sort">

                 <thead>
				     <tr class="text-c">
                         <th>序</th>
                         <th>课程</th>
                         <th>考核学段</th>
                         <th>生成人</th>
                         <th>成绩表单</th>
                    </tr>
                </thead>

                  <tbody>
                      <template v-for="(item,index) of items" v-model="items"  v-clock>
				            <tr class="text-c">
                                 <td>{{index+1}}</td>
                                 <td>{{item.CourseName}}</td>
                                 <td>{{item.BelongToYear}}</td>
                                  <td>{{item.GenerateUser}}</td>
                                  <td>
                                      <a :href="['CourseScore.aspx?ID='+item.GUID]" class="Hui-iconfont" style="color:#44708e;cursor:pointer;font-size:16px">
                                          &#xe695;
                                      </a>
                                  </td>
                             </tr>
                    </template>
                </tbody>
            </table>
      </div>

    <script src="../assets/js/EM/studentScoreList.js"></script>
</asp:Content>

