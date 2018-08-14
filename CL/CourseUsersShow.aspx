<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="CourseUsersShow.aspx.cs" Inherits="CL_CourseUsersShow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="../lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css" >

    <div class="page-container">
         <nav class="breadcrumb">
            <i class="Hui-iconfont">&#xe67f;</i> 首页 
            <span class="c-gray en">&gt;</span> {{courseName}}
            <span class="c-gray en">&gt;</span> 选课学生
            <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
                <i class="Hui-iconfont">&#xe68f;</i>
            </a>
       </nav>

        <div class="cl pd-5 bg-1 bk-gray mt-20"> 
            <span class="l">
                <a href="javascript:;" class="btn btn-danger radius" @click="batchDel()">
                    <i class="Hui-iconfont">&#xe6e2;</i> 批量删除
                </a> 

                &nbsp;
               <a href="javascript:;" data-toggle="modal" data-target="#AddStudentIntoCourseModal" class="btn btn-primary radius">
                   <i class="Hui-iconfont">&#xe600;</i> 添加选课学生
               </a>
               
                 
            </span> 
             &nbsp; &nbsp;
           <span  class="l select-box inline">
               &nbsp; &nbsp;
             <select  class="select"  v-model="classSelected">
			         <option value="-1">班级</option>
                     <option  v-for="(item,index) of classList">{{item}}</option>
		      </select>
            </span>

            <span class="r">
                共有数据：
                <strong>{{totalCount}}</strong> 条
            </span> 
        </div>

        <div class="portfolio-content">
            	<ul class="cl portfolio-area" >
                   <template v-for="(item,index) of  items" v-model="items">
                        <li class="item">
				            <div class="portfoliobox">
					            <input class="checkbox"  type="checkbox" v-bind:value="item.ID">
					            <div class="picbox">
                                    <span>                         
                                       {{item.StudentName}}
                                    </span> 
					            </div>
					            <a href="#" style="cursor:pointer" class="delUser" @click="Delete(item.GUID1)">
                                     <i class="Hui-iconfont" >&#xe6e2;</i>
					            </a>
				            </div>
			            </li>
                    </template>
                </ul>
       </div>


         <%--增加课程用户的Modal--%>
                <div class="modal fade" id="AddStudentIntoCourseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
                    <div class="modal-dialog " role="document" style="width: 800px;">
                        <div class="modal-content" style="margin-top: 15%;">

                             <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">学生用户</h4>
                            </div>

                            <div class="modal-body"  style="max-height: 550px; overflow-y: scroll; padding-left:5%; padding-top:10px;">

                                    <div class="row"> 
                                       <div class="col-lg-6">
                                            <div class="input-group">
                                              <input type="text" style="width:250px;height:30px;" placeholder="Search for..." @input="searchStudent" list="words"/>
                                              <span class="input-group-btn">
                                                <button class="btn btn-default" type="button">Go!</button>
                                              </span>
                                               <datalist id="words">
                                                   <option v-for="item in searchlist" :value="item"></option>
                                                </datalist>

                                                 <select  v-model="gradeSelected" id="gradeSelected" >
                                                    <option value="-1">年级</option>
                                                    <option value="初一">初一</option>
                                                    <option value="初二">初二</option>
                                                    <option value="初二">初三</option>
                                                </select>

                                                 <select id="sub" v-model="classSelected2" class="form-control" v-if="has">
                                                    <option value="-1">班级</option>
                                                    <option v-for="item in classItems" v-bind:value="item.Class">{{item.Class}}</option>
                                                </select>

                                            </div>
                                      </div>
                                </div>

                                 <br />

                                   <div class="row">
                                        <ul>
                   <template v-for="(item,index) of  studentsList" v-model="studentsList">
                                                 <li style="padding-left:16px;display:inline-block"  >
                                                      <span class="text-center" style="margin-left:6px">{{item.StudentName}}</span>
                                                     <input type="checkbox" :value="item.GUID"  name="studentsList"/>
                                                  </li>
                    </template>
             </ul>
                                     
                                </div>

                            </div>

                            <div class="modal-footer">
                                 <button type="button" class="btn btn-info" data-toggle="modal" data-target="#AddStudentIntoCourseModal" @click="addStudentIntoCourse(selected)"/ >增加</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            </div>

                        </div>
                    </div>
                </div>
         <%--增加课程用户的Modal--%>

    </div>
    <!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="../lib/lightbox2/2.8.1/js/lightbox.min.js"></script> 
<script type="text/javascript">
$(function(){
	$(".portfolio-area li").Huihover();
});
</script>
    <script src="../assets/js/CL/courseUsersShow.js"></script>
</asp:Content>

