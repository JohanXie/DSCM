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
							    <li><a href="javascript:;" onclick="user_add('添加用户','Users/User_Add.aspx','','310')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
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
			    <dt><i class="Hui-iconfont">&#xe60d;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			    <dd>
				    <ul>
                       <li><a data-href="Users/Role_List.aspx" data-title="权限管理" href="javascript:void(0)">权限管理</a></li>
                       <li><a data-href="Users/User_Man.aspx" data-title="用户列表" href="javascript:void(0)">用户列表</a></li>
                    </ul>
                 </dd>
           </dl>
          </asp:PlaceHolder>

             <dl id="menu-courseevaluation">
                 <dt><i class="Hui-iconfont">&#xe692;</i> 评价管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                 <dd>
                     <ul>
                          <li><a data-href="EM/StudentCourseEvaluation.aspx" data-title="学生课程评价" href="javascript:void(0)">学生课程评价</a></li>
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

        <!--请在下方写此页面业务相关的脚本-->
    <script type="text/javascript" src="lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
    <script src="assets/js/index.js"></script>

</asp:Content>

