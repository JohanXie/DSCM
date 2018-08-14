<%@ Page Title="" Language="C#" MasterPageFile="~/backend.master" AutoEventWireup="true" CodeFile="Role_List.aspx.cs" Inherits="Users_Role_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户管理 <span class="c-gray en">&gt;</span> 权限管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="page-container">
        	<div class="cl pd-5 bg-1 bk-gray"> 
                <span class="l"> 
                    <a href="javascript:;" @click="batchSelect" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> 
                    <a class="btn btn-primary radius" href="javascript:;" @click="addRole"  data-toggle="modal" data-target="#addRoleModal">
                        <i class="Hui-iconfont">&#xe600;</i> 添加角色
                    </a> 
                </span> 
                <span class="r">共有数据：<strong>{{totalCount}}</strong> 条</span> 
        	</div>

          <table class="table table-border table-bordered table-hover table-bg" id="tb">
		        <thead>
			        <tr>
				        <th scope="col" colspan="7">权限管理</th>
			        </tr>
			        <tr class="text-c">
				        <th width="25"><input type="checkbox" value="" name=""></th>
				        <th width="40">ID</th>
				        <th width="200">权限名</th>
                         <th class="text-center">权限标识</th>
				        <th width="300">描述</th>
                          <th class="text-center">有效性</th>
				        <th width="70">操作</th>
			        </tr>
		        </thead>

                <tbody>
                       <template v-for="(item,index) of items" v-model="items"  v-clock>
			        <tr class="text-c">
				        <td><input type="checkbox"  v-bind:value="item.ID"></td>
				        <td>{{index+1}}</td>
				        <td>{{item.RoleName}}</td>
				        <td>{{item.GUID}}</td>
                         <td>{{item.Description}}</td>
                         <td>{{item.Valid}}</td>
				        <td class="f-14">
                            <a title="编辑" href="javascript:;" data-toggle="modal" data-target="#addRoleModal" @click="showOverlay(index,item.ID)" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6df;</i>
                            </a> 
                            <a title="删除" href="#" data-toggle="modal" data-target="#delRoleModal" @click="nowIndex=item.GUID" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6e2;</i>
                            </a>
				        </td>
			        </tr>
                    </template>
                </tbody>
         </table>

          <model :list='selectedlist' :isactive="isActive" :mode="Mode" v-cloak @change="changeOverlay" @modify="modify"></model>

          <%--删除权限的Modal--%>
        <div class="modal fade bs-example-modal-sm" id="delRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog  modal-sm " role="document" >
                <div class="modal-content" style="margin-top: 15%;">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">操作</h4>
                    </div>
                    <div class="modal-body" style="padding: 25px 25px 0 25px;">
                        <div class="text-center">
                        <span ><strong>是否确认删除？</strong></span>
                            <p></p>
                       <input type="button" value="删除" @click="Delete(nowIndex)" class="btn btn-danger btn-sm" style="margin: 0 5px" data-dismiss="modal"/>
                        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
                 
                   </div>
    <div style="margin-top: 18px">
                        </div>
                    </div>
                      <div class="modal-footer">
               
                    </div>
                </div>
              
            </div>
        </div>
         <%--删除权限的Modal--%>

    </div>

    <script src="../assets/js/Users/roleList.js"></script>
</asp:Content>


