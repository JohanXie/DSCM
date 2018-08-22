using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["RoleGUID"] == null)
            {

                Util.ShowMessage("用户登录超时，请重新登录！", "/CM/Login.aspx");
            }
            else {
                string RoleGUID = Convert.ToString(Session["RoleGUID"]);
                UserName.Text = Session["UserName"].ToString();
                RoleName.Text = Session["RoleName"].ToString();
                if (RoleGUID == "60843daa-c3b8-4e38-b221-e7549bfea258")//为系统管理员
                {
                    AdminPlaceHolder1.Visible = true;
                    AdminPlaceHolder2.Visible = true;
                    AdminPlaceHolder3.Visible = true;
                }
                else if (RoleGUID == "f71786b4-1d45-4191-af29-04a6bb43bb58")//为老师
                {
                    AdminPlaceHolder2.Visible = true;
                }
                else if (RoleGUID == "4baf0678-0d12-4bef-bacd-ba949e06f388")//为级主任
                {
                    AdminPlaceHolder2.Visible = true;
                }
            }
            
        }
       
    }
}