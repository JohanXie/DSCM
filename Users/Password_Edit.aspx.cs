using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
        int j = 0;
        string userid = Convert.ToString(Session["TeacherGUID"]);
        string[] s = new string[3];
        s[0] = "密码更新失败，请与管理员联系！";
        s[1] = "修改成功";
        s[2] = "旧密码错误！";
        j = DoUpdate();
        ErrorLabel.Text = s[j];
    }

    protected int DoUpdate()
    {
        int i = 0;
        string oldPassword = "";
        using (SqlConnection conn = new DB().GetConnection())
        {
            string sql = "select Password from [Teachers] where GUID = @UserGUID";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@UserGUID", Session["TeacherGUID"].ToString());
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                oldPassword = rd["Password"].ToString();
            }
            rd.Close();

            if (oldPassword.Equals(Util.GetHash(Password1.Text.Trim())))
            {
                cmd.CommandText = "Update [Teachers] set Password = @Password where GUID = @UserGUID";
                cmd.Parameters.AddWithValue("@Password", Util.GetHash(Password2.Text.Trim()));
                i = cmd.ExecuteNonQuery();

            }
            else
            {
                i = 2;//第二种情况，旧密码错误。
            }
            conn.Close();
        }

        return i;
    }
}