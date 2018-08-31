using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Password_Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox1.Checked)
        {
            Password1.TextMode = TextBoxMode.SingleLine;
            Password2.TextMode = TextBoxMode.SingleLine;
            Password3.TextMode = TextBoxMode.SingleLine;
        }
        else
        {
            Password1.TextMode = TextBoxMode.Password;
            Password2.TextMode = TextBoxMode.Password;
            Password3.TextMode = TextBoxMode.Password;
        }
    }

    protected void Psd_Upd_Click(object sender, EventArgs e)
    {

    }
 }