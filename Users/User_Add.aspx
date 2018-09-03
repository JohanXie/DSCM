<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="User_Add.aspx.cs" Inherits="Users_User_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="form form-horizontal">
          <template v-for="(item,index) of userInfo" v-model="userInfo"  v-clock>
        <div class="row cl">
			        <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>用户名：</label>
			        <div class="formControls col-xs-8 col-sm-9">
				        <input type="text" class="input-text" id="userName" v-model="item.TeacherName">
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
                    
                       <input  name="HeadTeacher"   v-bind:value="1" type="radio" v-model="item.IsHeadTeacher"  class="colored-blue">
                        <span>是</span>

                        <input  name="HeadTeacher"   v-bind:value="0" type="radio" v-model="item.IsHeadTeacher" class="colored-blue">
                        <span>否</span>
                 
                </div>
        </div>

          <div  class="row cl">
                      <label class="form-label col-xs-4 col-sm-2"><span class ="text-primary">角色：</span></label>
              <div class="formControls col-xs-8 col-sm-9">
                      <label class ="radio-inline"  v-for="item2 in  roleList" >
                       <input  name="Roles"  v-bind:id="item2.GUID" v-bind:value="item2.GUID"  v-model="item.RoleGUID" type="radio" class="colored-blue">
                        <span>{{item2.RoleName}}</span>
                     </label>
                </div>
          </div>

         <div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button class="btn btn-success radius" type="submit" @click="addUser">
                    <i class="icon-ok"></i> 确定
				</button>
			</div>
		</div>
      </template>
    </div>

    <script src="../assets/js/Users/userAdd.js"></script>

</asp:Content>

