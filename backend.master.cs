using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class backend : System.Web.UI.MasterPage
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
                if (Session["RoleGUID"].ToString() == "f71786b4-1d45-4191-af29-04a6bb43bb58")
                {
                    IsHeadTeacher.Text = Session["IsHeadTeacher"].ToString();
                }
            }

        
          
        }
    }
}
