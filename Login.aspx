<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />  <!-- 声明文档使用的字符编码 -->
    <meta name="renderer" content="webkit|ie-comp|ie-stand" /><!--内核控制标签-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><!-- 优先使用 IE 最新版本和 Chrome -->
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" /><!--初始化设置浏览器显示缩放值-->
    <meta http-equiv="Cache-Control" content="no-siteapp" />  <!-- 不让百度转码 -->
     <meta name="keywords" content="德胜，课程管理，广东顺德德胜学校" />
    <meta name="description" content="德胜，课程管理，广东顺德德胜学校" />
   
    <title>广东顺德德胜学校课程管理系统</title>
     <link href="assets/css/bootstrap.css" rel="stylesheet"  type="text/css" />
    <link href="assets/css/login.css" rel="stylesheet"  type="text/css" />
   

    <script src="assets/js/jquery-2.0.3.min.js"></script>
      <style type="text/css">

          .slide:after {
          content: '学生';
          color: #ffffff;
          position: absolute;
          right: 10px;
          z-index: 0;
          font: 12px/26px Arial, sans-serif;
          font-weight: bold;
          text-shadow: 1px 1px 0px rgba(255, 255, 255, 0.15);
        }
        .slide:before {
          content: '老师';
          color: #ffffff;
          position: absolute;
          left: 10px;
          z-index: 0;
          font: 12px/26px Arial, sans-serif;
          font-weight: bold;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
         <asp:Label ID="TeacherGUID" runat="server" Text="Label" Visible="false"></asp:Label>
        <asp:Label ID="RoleGUID" runat="server" Text="Label" Visible="false"></asp:Label>
         <asp:Label ID="TeacherName" runat="server" Text="Label" Visible="false"></asp:Label>
          <asp:Label ID="Grade" runat="server" Text="Label" Visible="false"></asp:Label>
         <asp:Label ID="IsHeadTeacher" runat="server" Text="Label" Visible="false"></asp:Label>

            <div class ="title">
            <div class="row">
                <div class="col-xs-12 col-md-12">
                    德胜课程管理系统>>用户登录
                </div>
            </div>
     </div>

    <div class="container content" style="height:100%">
            <div class="row">
                <div class="col-md-4 col-sm-1"></div>
                <div class="col-md-4 col-sm-10">
                    <br />
                    <br />
                    <br />
                    <div class="form-signin">
                        <p class="text-center"><span style="font-size:20px">欢迎来到德胜学校课程系统</span></p>
                        <br />
                        <br />
                        <label for="UserCart" class="sr-only">登录号</label>
                        <asp:TextBox ID="UserCart" type="text" class="form-control" placeholder="登录账号" required="required" autofocus="autofocus" runat="server" ></asp:TextBox>
                        <br />
                        <br />
                        <label for="Password" class="sr-only">密码</label>
                        <asp:TextBox ID="Password" type="password"  class="form-control" placeholder="密码" required="required" runat="server" ></asp:TextBox>
                        <br />
                        <br />
                        <asp:Button ID="Loging" runat="server" Text="登 录" class="btn btn-primary btn-block" type="submit" onclick="Loging_Click" />
                        <p class="text-center">
                            <asp:Label ID="ErrorLabel" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                        </p>
                        <br />
                        <div class="pull-left">
                            <div class="slide"> 
                                <input type="checkbox" value="None" id="slide" name="check" checked="checked" runat="server" />
                                <label for="slide"></label>
                            </div>
                        </div>
                        <div class="pull-right" id="Register">
                          
                            <br />
                            <br />
                        </div>
                        <br />
                        <br />
                    </div>
                </div>
                <div class="col-md-4 col-sm-1">
                  
                </div>
            </div>

                   <!-- Footer -->
        <footer id="footer">
            <!-- Lower Footer -->
            <div id="lower-footer">

                <div class="row">

                    <div class="col-lg-12 col-md-12 col-sm-12">
                        <div class="footer">
                            <p>版权所有<span style="font-size:14px; font-family:Verdana;">&copy;</span>2018 广东顺德德胜学校&nbsp;&nbsp;&nbsp;&nbsp;技术支持：信息技术系&nbsp;--&nbsp;谢家豪</p>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /Lower Footer -->
        </footer>
        <!-- /Footer -->
            </div>
       

    </form>
</body>
</html>
