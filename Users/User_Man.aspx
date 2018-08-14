<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="User_Man.aspx.cs" Inherits="Users_User_Man" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <nav class="breadcrumb">
        <i class="Hui-iconfont">&#xe67f;</i> 首页 
        <span class="c-gray en">&gt;</span> 用户中心 
        <span class="c-gray en">&gt;</span> 用户列表 
        <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
            <i class="Hui-iconfont">&#xe68f;</i>
        </a>
    </nav>

    <div class="page-container">

       <div class="cl pd-5 bg-1 bk-gray mt-20"> 
           <span class="l">
               <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius">
                   <i class="Hui-iconfont">&#xe6e2;</i> 批量删除
               </a>
               <a href="javascript:;"  onclick="user_add('添加用户','User_Add.aspx','','380')" class="btn btn-primary radius">
                   <i class="Hui-iconfont">&#xe600;</i> 添加用户
               </a>
                 <a href="javascript:;" class="btn btn-secondary radius">
                     <i class="Hui-iconfont">&#xe645;</i><span v-show="keepShow" @click="chooseExcel()">选择Excel</span> 
                     <span v-show="!keepShow" @click="importStu()">导入学生</span>
                 </a> 
                <asp:FileUpload ID="FileUpload1" runat="server" Width="305px" style="display:none"/>
                    &nbsp; &nbsp;
                 <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="导入SQL" style="display:none"/>
           </span> 
           <span class="r">共有数据：<strong>88</strong> 条</span> 
       </div>

        <div class="mt-20">
         <table class="table table-border table-bordered table-hover table-bg table-sort">
             <thead>
			    <tr class="text-c">
				    <th width="25"><input type="checkbox" name="" value=""></th>
				    <th width="80">ID</th>
				    <th width="100">用户名</th>
				    <th width="40">性别</th>
				    <th width="90">权限</th>
				    <th width="150">联系方式</th>
				    <th width="">任教班级</th>
				    <th width="70">状态</th>
				    <th width="100">操作</th>
			    </tr>
		   </thead>
            <tbody>
                <template v-for="(item,index) of teachers" v-model="teachers"  v-clock>
			        <tr class="text-c">
				        <td><input type="checkbox"  v-bind:value="item.ID"></td>
				        <td>{{index+1}}</td>
				        <td>
                            <u style="cursor:pointer" class="text-primary" onclick="member_show('张三','member-show.html','10001','360','400')">
                                {{item.TeacherName}}
                            </u>
				        </td>
				        <td>{{item.Gender}}</td>
				        <td>{{item.RoleName}}</td>
				        <td></td>
				        <td class="text-l">{{item.Class}}</td>
				        <td class="td-status"><span class="label label-success radius">已启用</span></td>
				        <td class="td-manage">
                            <a style="text-decoration:none" onClick="member_stop(this,'10001')" href="javascript:;" title="停用">
                                <i class="Hui-iconfont">&#xe631;</i>
                            </a>
                            <a title="编辑" href="javascript:;" onclick="member_edit('编辑','member-add.html','4','','510')" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6df;</i>
                            </a> 
                            <a style="text-decoration:none" class="ml-5" onClick="change_password('修改密码','change-password.html','10001','600','270')" href="javascript:;" title="修改密码">
                                <i class="Hui-iconfont">&#xe63f;</i>
                            </a> 
                            <a title="删除" href="javascript:;" @click="Delete(item.GUID)" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6e2;</i>
                            </a>
				        </td>
			        </tr>
                </template>
		</tbody>
         </table>
    </div>


     </div>

     

   <script type="text/javascript" src="../lib/My97DatePicker/4.8/WdatePicker.js"></script> 
   <script type="text/javascript" src="../lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
   <script type="text/javascript" src="../lib/laypage/1.2/laypage.js"></script>
    <script src="../assets/js/Users/userMan.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.table-sort').dataTable({
                "aaSorting": [[1, "desc"]],//默认第几个排序
                "bStateSave": true,//状态保存
                "aoColumnDefs": [
                    //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                    //{ "orderable": false, "aTargets": [0, 8, 9] }// 制定列不参与排序
                ]
            });

        });
    </script>
</asp:Content>

