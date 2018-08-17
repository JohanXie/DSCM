using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Loging_Click(object sender, EventArgs e)
    {
        if (slide.Checked == false)//学生登录
        {
            int flag = 0;
            flag = IsStudentLogin();
            if (flag == 1)
            {
                // 判断是否是新用户
                // HttpUtility.UrlDecode(cookieUserName.Value),获得Cookie
                var cookieUserName = Request.Cookies["StudentGUID"];
                if (cookieUserName == null) // 如果是新用户，则跳转到新用户页面
                {
                    Response.Cookies.Add(new HttpCookie("StudentGUID", HttpUtility.UrlEncode(TeacherGUID.Text)));
                }
                System.Web.HttpContext.Current.Session["StudentGUID"] = TeacherGUID.Text;
                System.Web.HttpContext.Current.Session["UserName"] = TeacherName.Text;
                System.Web.HttpContext.Current.Session["RoleGUID"] = "ec94a42e-a354-42f6-a921-53036c18e6da";
                System.Web.HttpContext.Current.Session["RoleName"] = "学生";
                System.Web.HttpContext.Current.Session["Grade"] = Grade.Text;
                Response.Redirect(Server.HtmlEncode("Stu/ApplyCourse.aspx"));

            }
            else
            {
                ErrorLabel.Text = "登录号或密码错误！";
            }
        }
        else//教师登录
        {
            int flag = 0;
            flag = IsTeacherLogin();
            if (flag == 1)
            {
                // 判断是否是新用户
                // HttpUtility.UrlDecode(cookieUserName.Value),获得Cookie
                var cookieUserName = Request.Cookies["TeacherGUID"];
                if (cookieUserName == null) // 如果是新用户，则跳转到新用户页面
                {
                    Response.Cookies.Add(new HttpCookie("TeacherGUID", HttpUtility.UrlEncode(TeacherGUID.Text)));
                }
                System.Web.HttpContext.Current.Session["TeacherGUID"] = TeacherGUID.Text;
                System.Web.HttpContext.Current.Session["UserName"] = TeacherName.Text;
                System.Web.HttpContext.Current.Session["RoleGUID"] = RoleGUID.Text;
                System.Web.HttpContext.Current.Session["IsHeadTeacher"] = IsHeadTeacher.Text;
                if (RoleGUID.Text == "60843daa-c3b8-4e38-b221-e7549bfea258") {
                    System.Web.HttpContext.Current.Session["RoleName"] = "管理员";
                }
                if (RoleGUID.Text == "f71786b4-1d45-4191-af29-04a6bb43bb58")
                {
                    System.Web.HttpContext.Current.Session["RoleName"] = "老师";
                }
                if (IsHeadTeacher.Text == "True")
                {
                    System.Web.HttpContext.Current.Session["Class"] = Class.Text;
                }
                Response.Redirect(Server.HtmlEncode("Index.aspx"));

            }
            else
            {
                ErrorLabel.Text = "登录号或密码错误！";
            }
        }
          
    }

    private int IsTeacherLogin()
    {
        int flag = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from [Teachers] where [TeacherName] = @TeacherName and [Password] = @Password";
            cmd.Parameters.AddWithValue("@TeacherName", UserCart.Text);
            cmd.Parameters.AddWithValue("@Password", Util.GetHash(Password.Text.Trim()));
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                TeacherGUID.Text = rd["GUID"].ToString();
                TeacherName.Text = rd["TeacherName"].ToString();
                RoleGUID.Text = rd["RoleGUID"].ToString();
                IsHeadTeacher.Text = rd["IsHeadTeacher"].ToString();
                Class.Text = rd["NowTeachClass"].ToString();
                flag = 1;
            }
            cmd.Dispose();
            rd.Close();
        }
        return flag;
    }

    private int IsStudentLogin() {
        int flag = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select * from [Students] where [StudentName] = @TeacherName and [Password] = @Password";
            cmd.Parameters.AddWithValue("@TeacherName", UserCart.Text);
            cmd.Parameters.AddWithValue("@Password", Util.GetHash(Password.Text.Trim()));
            conn.Open();
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                TeacherGUID.Text = rd["GUID"].ToString();
                TeacherName.Text = rd["StudentName"].ToString();
                Grade.Text = rd["Grade"].ToString();
                flag = 1;
            }
            cmd.Dispose();
            rd.Close();
        }
        return flag;
    }

}