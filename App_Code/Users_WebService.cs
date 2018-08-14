using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections;
using System.Text;

/// <summary>
/// Users_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
 [System.Web.Script.Services.ScriptService]
public class Users_WebService : System.Web.Services.WebService
{

    public Users_WebService()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    //增
    [WebMethod(EnableSession = true)]
    public string addRole(string RoleName, string Description)
    {
        string strGUID = Util.generateGUID();
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("Insert into Roles(GUID,RoleName,Description,Valid)");
            sb.Append("Values (@GUID,@RoleName,@Description,@Valid)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", strGUID);
            cmd.Parameters.AddWithValue("@RoleName", RoleName);
            cmd.Parameters.AddWithValue("@Description", Description);
            cmd.Parameters.AddWithValue("@Valid", 1);
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

        return "Success";
    }

    [WebMethod(EnableSession = true)]
    public string addUser(string TeacherName, string Password, string RoleGUID)
    {
        string strGUID = Util.generateGUID();
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("Insert into Teachers(GUID,TeacherName,Password,RoleGUID)");
            sb.Append("Values (@GUID,@TeacherName,@Password,@RoleGUID)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", strGUID);
            cmd.Parameters.AddWithValue("@TeacherName", TeacherName);
            cmd.Parameters.AddWithValue("@Password", Util.GetHash(Password.Trim()));
            cmd.Parameters.AddWithValue("@RoleGUID", RoleGUID);
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
        return "Success";
    }

    //改
    [WebMethod(EnableSession = true)]
    public string updateRoleInfo(String GUID, String RoleName, String Description)
    {

        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("update Roles set RoleName=@RoleName,Description=@Description where GUID=@GUID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@RoleName", RoleName);
            cmd.Parameters.AddWithValue("@Description", Description);
            cmd.Parameters.AddWithValue("@GUID", GUID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return "Success";

    }

    [WebMethod(EnableSession = true)]
    public string DelRole(string GUID)
    {
        int i;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("update Roles set Valid = @Valid where GUID = @GUID");
            conn.Open();
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@Valid", 0);
            cmd.Parameters.AddWithValue("@GUID", GUID);
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return "Success";
    }

    [WebMethod(EnableSession = true)]
    public int forbiddenRoles(string ids)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("update Roles set Valid=0 where ID in (" + ids + ")");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            conn.Close();
        }
        return i;
    }

    //查
    [WebMethod(EnableSession = true)]
    public string InitRoles()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select * from Roles");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod(EnableSession = true)]
    public string InitTeachers()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select a.*,b.RoleName
from[dbo].[Teachers] as a
left join
[dbo].[Roles] as b
on a.RoleGUID = b.GUID order by ID ASC");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }



    //检查用户是否唯一
    [WebMethod(EnableSession = true)]
    public int checkUser(string UserName)
    {
        Boolean check = Util.AreadyExist("Teachers", "TeacherName", UserName);
        if (check)
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }


}
