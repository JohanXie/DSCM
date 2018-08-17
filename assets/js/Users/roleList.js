Vue.component('model', {
    props: ['list', 'isactive', 'mode'],
    template: `<div class="overlay" v-show="isactive">
                    <div class ="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class ="modal-dialog " role="document" style="width: 800px;">
                            <div class ="modal-content" style="margin-top: 15%;">

                                 <div class ="modal-header">
                                    <button type="button" class ="close" data-dismiss="modal" aria-label="Close" @click="changeActive"><span aria-hidden="true">&times; </span></button>
                                    <h4 class ="modal-title">{{title}}</h4>
                                 </div>

                                  <div class ="modal-body" style="padding: 25px 25px 0 25px;"  v-on: submit.prevent="addTag">
                                      <div class="form form-horizontal">

                                              <div class="row cl">
			                                            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>权限名：</label>
			                                            <div class="formControls col-xs-8 col-sm-9">
				                                            <input type="text" class="input-text" value="" placeholder="权限名不能为空" id="RoleName"  v-model="modifylist.RoleName" />
			                                            </div>
		                                     </div>

                                             <div class="row cl">
			                                    <label class="form-label col-xs-4 col-sm-3 col-lg-2">权限描述：</label>
			                                    <div class="formControls col-xs-8 col-sm-9 col-lg-9"> 
                                                    <textarea class="input-text" style="height:100px;width:300px;" id="RoleDescription"  v-model="modifylist.Description"></textarea>
                                                </div>
                                             </div>

                                        </div>
                                      </div>

                                       <div style="margin-bottom:60px"></div>

                                 </div>

                                  <div class ="modal-footer" >
                                       <input  type="submit" @click="modify" data-dismiss="modal"  style="margin: 0 5px" class ="btn btn-info"  value="保存">
                                       <button type="button" class ="btn btn-default"  data-dismiss="modal" @click="changeActive" >关闭</button>
                                 </div>

                            </div>
                       </div>
                  </div>
           </div>`,
    data() {
        return {
            title: '权限添加',
        }
    },
    computed: {
        modifylist() {
            if (this.mode === 2) {
                this.title = "权限编辑";
            }
            return this.list;


        },
        validation: function () {//验证输入表单是否符合条件
            return {
                RoleName: !!this.modifylist.RoleName,
            }
        },
        isValid: function () {
            var validation = this.validation
            return Object.keys(validation).every(function (key) {
                return validation[key]
            })
        },

    },
    methods: {
        changeActive() {
            this.$emit('change');
        },
        modify() {
            if (this.isValid) {
                this.$emit('modify', this.modifylist);
            }
        }
    }
});

var roleList = new Vue({
    el: '.page-container',
    data: {
        totalCount: 200,//总项目数

        batch: false,
        datas: [],//总的数据
        items: [],//显示的数据

        selected: -1,//选中模态框表格列的索引
        selectedlist: {},//打开模态框被选中表格列数据
        isActive: false,//模态框是否被激活
        Mode: '',//用于编辑状态或增加状态的判断
    },
    created: function () {
        var that = this;
        $.ajax({
            type: "get",
            url: "Users_WebService.asmx/InitRoles",
            async: false,
            success: function (str) {
                a = $(str).find("string").text();
                var json = eval('(' + a + ')');
                that.datas = json;
                that.items = json.slice(0, 50);
            }
        })

        this.totalCount = that.items.length;
      

    },
    methods: {
        addRole: function () {
            this.selectedlist = {
                RoleName: '',
                Description: ''
            };
            this.isActive = true;
            this.Mode = 1;//表示新增
        },

        changeOverlay() {
            this.isActive = !this.isActive;
        },

        // 修改数据
        showOverlay(index) {
            this.selected = index;
            this.selectedlist = JSON.parse(JSON.stringify(this.datas[index])); // 先转换为字符串，然后再转换,深度复制，防止值联动改变
            this.Mode = 2;//表示修改
            this.changeOverlay();

        },

        // 点击保存按钮
        modify(arr) {
            if (this.selected > -1) {//表示编辑状态
                $.ajax({
                    type: "post",
                    url: "Users_WebService.asmx/updateRoleInfo",
                    data:
                    {
                        GUID: arr.GUID,
                        RoleName: arr.RoleName,
                        Description: arr.Description,
                    },
                    success: function (str) {
                       
                    },
                    error: function (msg) {
                        console.log(msg);
                    }
                })
                Vue.set(this.items, this.selected, arr);
                this.changeOverlay();
            } else {//表示新增状态
                $.ajax({
                    type: "post",
                    url: "Users_WebService.asmx/addRole",
                    data:
                    {
                        RoleName: $("#RoleName").val(),
                        Description: $("#RoleDescription").val(),

                    },
                    success: function (str) {
                        alert("修改成功");
                        location.reload();//刷新页面
                    },
                    error: function (msg) {
                        console.log(msg);
                    }
                })
            }
        },

        //单个删除
        Delete: function (id) {
            //实际项目中参数操作肯定会涉及到id去后台删除，这里只是展示，先这么处理。
            for (var i = 0; i < this.items.length; i++) {
                if (this.items[i].GUID === id) {
                    this.items.splice(i, 1);
                    break;
                }
            }

            $.ajax({
                type: "post",
                data: {
                    GUID: id,
                },
                url: "Users_WebService.asmx/DelRole",
                success: function (str) { console.log(str); }
            });
        },

        //批量选中
        batchSelect: function () {
            var ids = [];
            $("#tb input[type=checkbox]").each(function () {
                if ($(this).val() !== 0) {
                    if ($(this).prop('checked')) {
                        ids.push($(this).val());
                    }
                }
            });

            $.ajax({
                type: "get",
                url: "Users_WebService.asmx/forbiddenRoles",
                data: { "ids": ids.toString() },
                success: function (str) {
                    //layer.msg('已删除权限!', { icon: 6, time: 1000 });
                    location.reload();
                }
            });
        }
    }
})