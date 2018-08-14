<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="User_Add.aspx.cs" Inherits="Users_User_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="form form-horizontal">

        <div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>用户名：</label>
			        <div class="formControls col-xs-8 col-sm-9">
				        <input type="text" class="input-text" value="" placeholder="" id="userName">
			        </div>
		 </div>

          <div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>密码：</label>
			        <div class="formControls col-xs-8 col-sm-9">
				        <input type="password"  class="input-text" value="" placeholder="" id="password">
			        </div>
		 </div>

          <div  class="row cl">
                      <label class="form-label col-xs-4 col-sm-2"><span class ="text-primary">角色：</span></label>
              <div class="formControls col-xs-8 col-sm-9">
                      <label class ="radio-inline"  v-for="item in  roleList" >
                       <input  name="Roles"  v-bind:id="item.GUID" v-bind:value="item.GUID" type="radio" class="colored-blue">
                        <span>{{item.RoleName}}</span>
                     </label>
                </div>
          </div>

         <div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button class="btn btn-success radius" type="submit" @click="addUser"><i class="icon-ok"></i> 确定</button>
			</div>
		</div>

    </div>

    <script src="../assets/js/Users/userAdd.js"></script>

</asp:Content>

