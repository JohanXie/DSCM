<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="Course_Add.aspx.cs" Inherits="CL_Course_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
<%--    <link href="../assets/css/bootstrap.css" rel="stylesheet" />--%>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
      <style type="text/css">
           .img-circle {
            width:80px;
            height:80px;
            margin:0 auto;
            border-radius: 50%;
            background-color:#5bc1ef;
        }
            .img-circle p {
			 font-weight:bold;
			 font-size:15px;
			 color:white;
			  margin:0 auto;
			  text-align:center;
			  line-height:5;
			   
            }
        p {
           
            padding: 0; 
			font-family: Helvetica Neue, Microsoft Yahei, Hiragino Sans GB, WenQuanYi Micro Hei, sans-serif; 
			text-align: center; 
			word-break: normal; 
			font-weight: normal; 
			margin: 20px auto; 
			font-size: 25px; 
			color: #383838;
        }
          input[type=radio] {
            opacity: 1;
            position: absolute;
            left: -9999px;
            z-index: 12;
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
    </style>


    <article class="page-container">

        <div class="form form-horizontal" id="course-add">
            	<div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>课程名：</label>
			        <div class="formControls col-xs-8 col-sm-9">
				        <input type="text" class="input-text" value="" placeholder="" id="courseName" name="courseName">
			        </div>
		       </div>

        

           <div class="row cl">
			    <label class="form-label col-xs-4 col-sm-2">开班日期：</label>
			    <div class="formControls col-xs-8 col-sm-9">
				    <input type="text" onfocus="WdatePicker({ dateFmt:'yyyy-MM-dd HH:mm:ss' })" id="courseFirstStartDate" class="input-text Wdate" style="width:180px;">
			    </div>
		    </div>
   

            	<div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2 col-lg-2"><span class="c-red">*</span>上课时间：</label>
			        <div class="formControls col-xs-8 col-sm-9 col-lg-9">
				        <input type="text" class="input-text" value="" id="courseWeekDate" placeholder="一，三"  >
			        </div>
		       </div>



            	<div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2 col-lg-2"><span class="c-red">*</span>上课地点：</label>
			        <div class="formControls col-xs-8 col-sm-9 col-lg-9">
				        <input type="text" class="input-text" value="" placeholder=""  id="courseSite">
			        </div>
		       </div>



            	<div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2 col-lg-2"><span class="c-red">*</span>限制人数：</label>
			        <div class="formControls col-xs-8 col-sm-9 col-lg-9">
				        <input type="text" class="input-text" value="" placeholder="(0表示没有限制)"  id="courseLimitNum">
			        </div>
		       </div>



     	<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2 col-lg-2">状态：</label>
			<div class="formControls col-xs-8 col-sm-9 col-lg-9"> <span class="select-box">
                <select  class="select" id="courseStatus">
					<option value="" selected>选择开班状态</option>
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
				</span> </div>
		</div>
		


 
        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-2 col-lg-2">类型：</label>
			<div class="formControls col-xs-8 col-sm-9 col-lg-9"> <span class="select-box">
				<select class="select" id="courseType">
					<option value="" selected>请选择课程类型</option>
					<option value="1">拓展课程</option>
					<option value="2">CCA课程</option>
					<option value="3">竞赛、辅导课程</option>
				</select>
				</span> </div>
		</div>


        <div class="row cl">
			<label class="form-label col-xs-4 col-sm-2 col-lg-2">任课教师：</label>
            <div class="formControls col-xs-8 col-sm-9 col-lg-9">
                   <div class="img-circle" style="display:inline-block;margin-left:16px;"  v-show="cT">
                             <p>
                                 <span style="font-size:30px;color:white;position:relative;top:-40px"  data-toggle="modal" data-target="#otherUserModal">......</span>
                             </p>                              
                   </div>

                    <template v-for="(item,index) of  chooseTeachers" v-model="chooseTeachers" v-show="!cT">
                          <div class="img-circle" style="display:inline-block;margin-left:16px;">
                                   <p>
                                      <span style="font-size:30px;color:white;position:relative;top:-40px">{{item.TeacherName}}</span>
                                 </p> 
                         </div>
                    </template>
            </div>
       </div>

       <div class="row cl">
			<label class="form-label col-xs-4 col-sm-2 col-lg-2">开班年级：</label>
			<div class="formControls col-xs-8 col-sm-9 col-lg-9"> 
				 <div class="img-circle" style="display:inline-block;margin-left:16px;"  v-show="cG">
                             <p style="">
                                 <span style="font-size:30px;color:white;position:relative;top:-40px"  data-toggle="modal" data-target="#gradeModal">......</span>
                             </p> 
                                                 
                   </div>

                    <template v-for="(item,index) of  chooseGrades" v-model="chooseGrades" v-show="!cG">
                          <div class="img-circle" style="display:inline-block;margin-left:16px;">
                                   <p>
                                      <span style="font-size:30px;color:white;position:relative;top:-40px">{{item}}</span>
                                 </p> 
                         </div>
                    </template>
			</div>
		</div>

         
         <div class="row cl">
			<label class="form-label col-xs-4 col-sm-2 col-lg-2">备注：</label>
			<div class="formControls col-xs-8 col-sm-9 col-lg-9"> 
                <textarea class="input-text" name="user-info" id="courseNote" style="height:100px;width:300px;"></textarea>
            </div>
         </div>

        <div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button @click="addCourse()" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 提交课程</button>
			
			</div>
		</div>


     </div>

          <%--选择任课教师的Modal--%>
             <div class="modal fade" id="otherUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
                  <div class="modal-dialog " role="document" style="width: 800px;">
                         <div class="modal-content" style="margin-top: 15%;">

                              <div class="modal-header">
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">选择任课教师</h4>
                             </div>

                              <div class="modal-body"  style="max-height: 350px; overflow-y: scroll; padding-left:5%; padding-top:10px;">

                                  <div class="row">
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                              <input type="text" class="form-control" placeholder="Search for..." @input="searchUser" list="words"/>
                                              <span class="input-group-btn">
                                                <button class="btn btn-default" type="button">Go!</button>
                                              </span>
                                                  <input id="Checkbox2" value="0" type="checkbox" style="margin-left:5px;margin-top:-5px;"/>
                                                   <label>全选</label>
                                                 <datalist id="words">
                                                   <option v-for="item in searchlist" :value="item"></option>
                                                   </datalist>
                                            </div>
                                         </div>
                                  </div>

                                  <br />

                                    <div class="row">
                                          <ul id="tb2">
                                             <template v-for="(item,index) of  teacherList" v-model="teacherList">
                                              <li style="padding-left:16px;display:inline-block"  v-if="index<usershow">
                                                   <%-- :src="item.Avatar" --%>
                                                 <div class="img-circle">
                                                   <p style="font-family: 'Impact Normal', 'Impact';">{{item.TeacherName}}</p> 
                                                    <input type="checkbox" :value="item.ID"   name="webUsers"/>
                                                 </div>
                                              </li>
                                           </template>

                                               <li class="img-circle" style="display:inline-block;margin-left:16px;" v-show="ellipsis">
                                                   <p style="">
                                                         <span style="font-size:30px;color:white;position:relative;top:-40px" @click="changeUsers">......</span>
                                                   </p> 
                                                 
                                             </li>
                                         </ul>
                                    </div>

                              </div>

                        <div class="modal-footer">
                             <button type="button" class="btn btn-info" data-dismiss="modal" @click="selectedTeachers()"/ >确认教师</button>
                             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </div>
                </div>
            </div>
         </div>
                        <%--选择任课教师的Modal--%>

        <%--选择年级的Modal--%>
         <div class="modal fade" id="gradeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
                  <div class="modal-dialog " role="document" style="width: 800px;">
                         <div class="modal-content" style="margin-top: 15%;">

                               <div class="modal-header">
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">选择年级</h4>
                             </div>

                             
                              <div class="modal-body"  style="max-height: 350px; overflow-y: scroll; padding-left:5%; padding-top:10px;">
                                   <div class="row">
                                          <ul id="tb3">
                                             <template v-for="(item,index) of grade" v-model="grade">
                                              <li style="padding-left:16px;display:inline-block">
                                                   <%-- :src="item.Avatar" --%>
                                                 <div class="img-circle">
                                                   <p style="font-family: 'Impact Normal', 'Impact';">{{item}}</p> 
                                                    <input type="checkbox" :value="item"   name="webUsers"/>
                                                 </div>
                                              </li>
                                           </template>
                                         </ul>
                                    </div>
                             </div>

                               <div class="modal-footer">
                                 <button type="button" class="btn btn-info" data-dismiss="modal" @click="selectedGrade()"/ >确认年级</button>
                                 <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                             </div>

                         </div>
                    </div>
            </div>

        <%--选择年级的Modal--%>

    </article>
    
             
   
    
    <script type="text/javascript" src="../lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
    <script type="text/javascript" src="../lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="../lib/My97DatePicker/4.8/WdatePicker.js"></script>
     <script src="../assets/js/CL/courseAdd.js"></script>
   

</asp:Content>

