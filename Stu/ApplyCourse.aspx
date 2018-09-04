<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="ApplyCourse.aspx.cs" Inherits="Stu_ApplyCourse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <header class="navbar-wrapper">
        <div class="navbar navbar-fixed-top">
            <div class="container-fluid cl">
                <a class="logo navbar-logo f-l mr-10 hidden-xs" href="#">广东顺德德胜学校课程管理系统</a>
                <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="#">广东顺德德胜学校课程管理系统</a><!--在小屏幕尺寸显示-->
                <span class="logo navbar-slogan f-l mr-10 hidden-xs">v1.0</span>
                <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>

          
                <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                    <ul class="cl">
                        <li>
                            <asp:Label ID="RoleName" runat="server" Text="Label"></asp:Label>
                        </li>
                        <li class="dropDown dropDown_hover">
                            <a href="#" class="dropDown_A">
                                <asp:Label ID="UserName" runat="server" Text="Label"></asp:Label>
                                <i class="Hui-iconfont">&#xe6d5;</i>
                            </a>
                            <ul class="dropDown-menu menu radius box-shadow">
                                <li><a href="javascript:;" onClick="myselfinfo()">个人信息</a></li>
                                <li><a href="/CM/Login.aspx">切换账户</a></li>
                            </ul>
                        </li>
                        <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
                        <li id="Hui-skin" class="dropDown right dropDown_hover">
                            <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
                            <ul class="dropDown-menu menu radius box-shadow">
                                <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                                <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                                <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                                <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                                <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                                <li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

     <div class="page-container">

          <nav class="breadcrumb">
                  <span class="c-gray en">&gt;</span> 课程申请  
                 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
                     <i class="Hui-iconfont">&#xe68f;</i>
                 </a>
          </nav>

         <br />
          <div class="text-c" v-show="ifsign">
          <%--   <span class="select-box inline">
		        <select name="" class="select" v-model="courseSelected">
			        <option value="0">全部分类</option>
			        <option value="1">待选课程</option>
			        <option value="2">已选课程</option>
		        </select>
		    </span>--%>
		    <input type="text" class="input-text" style="width:250px" placeholder="输入课程名称、开课年级、指导老师" @input="searchCourse" list="words">
               <datalist id="words">
                                   <option v-for="item in searchlist" :value="item"></option>
               </datalist> 
		    <button type="submit" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe665;</i> 搜课程</button>
            <br />
            <br />
                <p style="color:red;font-size:18px;">
                     可以选择两门拓展课，两门拓展课上课时间不能冲突同时不能够和CCA课时间冲突
                 </p>
	   </div>

         <div class="mt-20">
		    <table class="table table-border table-bordered table-bg table-hover table-sort"  v-show="ifsign">
			        <thead>
				        <tr class="text-c">
					        <th width="80">课程名</th>
					        <th width="100">课程类型</th>
					        <th width="100">指导老师</th>
					        <th width="150">上课星期</th>
					        <th width="150">上课地点</th>
					        <th width="100">开班日期</th>
                            <th width="100">开设年级</th>
                            <th width="100">操作</th>
				        </tr>
			        </thead>
                    	<tbody>
                              <template v-for="(item,index) of items" v-model="items"  v-clock>
				                    <tr class="text-c">
                                        <td>{{item.CourseName}}</td>
                                        <td>{{item.CourseType}}</td>
					                    <td>{{item.CoursesTeachers}}</td>
                                        <td>{{item.CourseWeekDate}}</td>
					                    <td class="text-c">{{item.CourseSite}}</td>
                                        <td class="td-status">{{item.CourseFirstStartDate}}</td>
                                        <td>{{item.CourseGender}}</td>
                                        <td>
                                             <input class="btn btn-success radius" type="button" @click="applyCourse(item.GUID,item.CourseWeekDate)" value="立即报名"/>
                                          <%--   <span class="label label-success radius" v-show="!ifsign">已报名</span>--%>
                                        </td>
                                    </tr>
                              </template>
                        </tbody>
              </table>

             <br />  <br />  <br />

               <table class="table table-border table-bordered table-bg table-hover table-sort"  v-show="!ifsign">
			        <thead>
				        <tr class="text-c">
					        <th width="80">课程名</th>
					        <th width="100">课程类型</th>
					        <th width="100">指导老师</th>
					        <th width="150">上课星期</th>
					        <th width="150">上课地点</th>
					        <th width="100">开班日期</th>
                            <th width="100">开设年级</th>
                            <th width="100">操作</th>
				        </tr>
			        </thead>
                    	<tbody>
                              <template v-for="(item,index) of choosedCourse" v-model="choosedCourse"  v-clock>
				                    <tr class="text-c">
                                        <td>{{item.CourseName}}</td>
                                        <td>{{item.CourseType}}</td>
					                    <td>{{item.CoursesTeachers}}</td>
                                        <td>{{item.CourseWeekDate}}</td>
					                    <td class="text-c">{{item.CourseSite}}</td>
                                        <td class="td-status">{{item.CourseFirstStartDate}}</td>
                                        <td>{{item.CourseGender}}</td>
                                        <td>
                                           <span class="label label-success radius">已报名</span>
                                        </td>
                                    </tr>
                              </template>
                        </tbody>
              </table>
            </div>
    </div>

    <script src="../assets/js/Stu/applyCourse.js"></script>
</asp:Content>

