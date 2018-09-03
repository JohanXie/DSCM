<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="Password_Edit.aspx.cs" Inherits="Users_Password_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <nav class="breadcrumb">
         <i class="Hui-iconfont">&#xe67f;</i> 首页
         <span class="c-gray en">&gt;</span> 个人信息 
         <span class="c-gray en">&gt;</span> 密码修改 
         <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
             <i class="Hui-iconfont">&#xe68f;</i>
         </a>
     </nav>
     
      <article class="page-container">
           <div class="form form-horizontal" id="password-edit">

               <div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>初始密码：</label>
			        <div class="formControls col-xs-8 col-sm-9">
                        <asp:TextBox ID="Password1"  TextMode="Password" class="input-text"  required="required" runat="server" placeholder="初始密码">
                        </asp:TextBox>
			        </div>
		       </div>

                <div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>新密码：</label>
			        <div class="formControls col-xs-8 col-sm-9">
				         <asp:TextBox ID="Password2"  TextMode="Password" class="input-text" runat="server" required="required" placeholder="新密码"></asp:TextBox>
			        </div>
		       </div>

                 <div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>确认密码：</label>
			        <div class="formControls col-xs-8 col-sm-9">
				         <asp:TextBox ID="Password3"  TextMode="Password"  class="input-text" runat="server"  required="required" placeholder="确认新密码"></asp:TextBox>
			        </div>
		       </div>

               <br />
              <div class="row cl">
                  
			        <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                         <asp:Label ID="ErrorLabel" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                          <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="true"
                           Text="查看密码" Visible="true"   oncheckedchanged="CheckBox1_CheckedChanged"/>  
                          <asp:Button ID="Psd_Upd" runat="server" class="btn btn-primary radius" Text="确认修改" OnClick="Psd_Upd_Click" />
			        </div>
		     </div>

            </div>
     </article>

</asp:Content>

