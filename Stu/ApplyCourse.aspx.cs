using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Stu_ApplyCourse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["RoleGUID"] == null)
            {

                Util.ShowMessage("用户登录超时，请重新登录！", "/CM/Login.aspx");
            }
            else
            {
                UserName.Text = Session["UserName"].ToString();
                RoleName.Text = Session["RoleName"].ToString();
            }
        }
    }
}