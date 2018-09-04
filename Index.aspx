<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

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

            <asp:PlaceHolder ID="AdminPlaceHolder1" runat="server" Visible="false">
                <nav class="nav navbar-nav">
				    <ul class="cl">
					    <li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>
						    <ul class="dropDown-menu menu radius box-shadow">
							    <li><a href="javascript:;" onclick="course_add('添加课程','CL/Course_add.aspx')"><i class="Hui-iconfont">&#xe616;</i> 课程</a></li>
							    <li><a href="javascript:;" data-toggle="modal" data-target="#addInfoModal"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
					    </ul>
				    </li>
			      </ul>
		       </nav>
          </asp:PlaceHolder>

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
                                <li><a href="javascript:;" data-toggle="modal" data-target="#editInfoModal">个人信息</a></li>
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

     <aside class="Hui-aside">
        <div class="menu_dropdown bk_2">

          <asp:PlaceHolder ID="AdminPlaceHolder2" runat="server" Visible="false">
            <dl id="menu-article">
                <dt><i class="Hui-iconfont">&#xe616;</i> 课程管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                         <li><a data-href="CL/Course_Add.aspx" data-title="新增课程" href="javascript:void(0)">新增课程</a></li>
                        <li><a data-href="CL/Course_List.aspx" data-title="课程列表" href="javascript:void(0)">课程列表</a></li>
                    </ul>
                </dd>
            </dl>
         </asp:PlaceHolder>

          <asp:PlaceHolder ID="AdminPlaceHolder3" runat="server" Visible="false">
            <dl id="menu-member">
			    <dt><i class="Hui-iconfont">&#xe62b;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			    <dd>
				    <ul>
                       <li><a data-href="Users/Role_List.aspx" data-title="权限管理" href="javascript:void(0)">权限管理</a></li>
                       <li><a data-href="Users/User_Man.aspx" data-title="用户列表" href="javascript:void(0)">用户列表</a></li>
                         <li><a data-href="Users/User_Add.aspx" data-title="新增用户" href="javascript:void(0)">新增用户</a></li>
                    </ul>
                 </dd>
           </dl>
          </asp:PlaceHolder>

            <dl id="menu-user">
			    <dt><i class="Hui-iconfont">&#xe62c;</i> 个人信息<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			    <dd>
				    <ul>
                       <li><a data-href="Users/Password_Edit.aspx" data-title="密码修改" href="javascript:void(0)">密码修改</a></li>
                    </ul>
                 </dd>
           </dl>

             <dl id="menu-courseevaluation">
                 <dt><i class="Hui-iconfont">&#xe692;</i> 评价管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                 <dd>
                     <ul>
                          <li>
                              <a data-href="EM/StudentCourseEvaluation.aspx" data-title="学生课程评价" href="javascript:void(0)">
                                  学生课程评价
                              </a>
                          </li>

                         <li>
                              <a data-href="EM/StudentScoreList.aspx" data-title="学生成绩表" href="javascript:void(0)">
                                  学生成绩表
                              </a>
                          </li>
                     </ul>
                 </dd>
            </dl>

        </div>
    </aside>

     <div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>

     <section class="Hui-article-box">
        <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
            <div class="Hui-tabNav-wp">
                <ul id="min_title_list" class="acrossTab cl">
                    <li class="active">
                        <span title="我的桌面" data-href="Main.aspx">我的桌面</span>
                        <em></em>
                    </li>
                </ul>
            </div>
        </div>
        <div id="iframe_box" class="Hui-article">
            <div class="show_iframe">
                <div style="display:none" class="loading"></div>
                <iframe scrolling="yes" frameborder="0" src="Main.aspx"></iframe>
            </div>
        </div>
    </section>

    
    <div class="contextMenu" id="Huiadminmenu">
        <ul>
            <li id="closethis">关闭当前 </li>
            <li id="closeall">关闭全部 </li>
        </ul>
    </div>

      <%--添加用户信息的Modal--%>
      <div class="modal fade" id="addInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
           <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">

                     <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">添加用户</h4>
                    </div>

                     <div class="modal-body" style="padding: 25px 25px 0 25px;">
                       <div class="form form-horizontal">

                             <div class="row cl">
			                    <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>用户名：</label>
			                    <div class="formControls col-xs-8 col-sm-9">
				                    <input type="text" class="input-text" id="userName">
			                    </div>
		                     </div>

                           
                              <div class="row cl">
			                            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>密码：</label>
			                            <div class="formControls col-xs-8 col-sm-9">
				                            <input type="password" class="input-text" id="password">
			                            </div>
		                     </div>


                            <div class="row cl">
                                 <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>所属班级：</label>

                                 <div class="formControls col-xs-8 col-sm-9">
                                       <select  v-model="gradeSelected" id="gradeSelected" >
                                                <option value="-1">年级</option>
                                                <option value="初一">初一</option>
                                                <option value="初二">初二</option>
                                               <option value="初二">初三</option>
                                        </select>

                                       <select id="sub" v-model="classSelected" class="form-control" v-if="has">
                                                   <option value="-1">班级</option>
                                                   <option v-for="item in classItems" v-bind:value="item.Class">{{item.Class}}</option>
                                        </select>
                                 </div>

                        </div>

                        
                            <div class="row cl">
                                 <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>是否班主任：</label>
                                   <div class="formControls col-xs-8 col-sm-9">
                    
                                           <input  name="HeadTeacher"   v-bind:value="1" type="radio"   class="colored-blue">
                                            <span>是</span>

                                            <input  name="HeadTeacher"   v-bind:value="0" type="radio"  class="colored-blue">
                                            <span>否</span>
                 
                                    </div>
                            </div>

                             <div  class="row cl">
                                      <label class="form-label col-xs-4 col-sm-2"><span class ="text-primary">角色：</span></label>
                              <div class="formControls col-xs-8 col-sm-9">
                                      <label class ="radio-inline"  v-for="item2 in  roleList" >
                                       <input  name="Roles"  v-bind:id="item2.GUID" v-bind:value="item2.GUID"  type="radio" class="colored-blue">
                                        <span>{{item2.RoleName}}</span>
                                     </label>
                                </div>
                        </div>

                               <br />

                    </div>
                </div>

                      <div class="modal-footer">
                          <input  type="button"   style="margin: 0 5px" class ="btn btn-info"  value="保存" @click="addUser">
                          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>


            </div>
      </div>
          </div>

       <%--添加用户信息的Modal--%>


    <%--展现用户信息的Modal--%>
        <div class="modal fade" id="editInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog " role="document" style="width: 800px;">
                <div class="modal-content" style="margin-top: 15%;">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">个人信息</h4>
                    </div>

                    <div class="modal-body" style="padding: 25px 25px 0 25px;">
                           <div class="form form-horizontal">

                                 <div class="row cl">
			                          <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>用户名：</label>
			                           <div class="formControls col-xs-8 col-sm-9">
				                               <input type="text" class="input-text" value=""  id="TeacherName" />
			                            </div>
		                          </div>

                                  <div class="row cl">
			                             <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>所属班级：</label>
                                         <div class="formControls col-xs-8 col-sm-9 gradeClass">
                                                <input type="text" class="input-text" value=""  id="Class" />
                                         </div>
		                         </div>

                               
                                <div class="row cl">
                                     <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>是否班主任：</label>
                                       <div class="formControls col-xs-8 col-sm-9">
                    
                                               <input  name="HeadTeacher"   value="1" type="radio" class="colored-blue">
                                                <span>是</span>

                                                <input  name="HeadTeacher"   value="0" type="radio" class="colored-blue">
                                                <span>否</span>
                 
                                        </div>
                                </div>
                                  

                                  <div style="margin-bottom:60px"></div>
                            </div>
                  </div>

                    <div class="modal-footer">
                          <input  type="submit" data-dismiss="modal"  style="margin: 0 5px" class ="btn btn-info"  value="保存">
                          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>

                </div>
            </div>
        </div>

    <%--展现用户信息的Modal--%>

        <!--请在下方写此页面业务相关的脚本-->
    <script type="text/javascript" src="lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
    <script src="assets/js/index.js"></script>

</asp:Content>

