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
/// Stu_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class Stu_WebService : System.Web.Services.WebService
{

    public Stu_WebService()
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
    public string chooseCourse(string CourseGUID) {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("insert into Course_Students(GUID,CourseGUID,StudentsID)");
            sb.Append("values (@GUID,@CourseGUID,@StudentsID)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", Guid.NewGuid());
            cmd.Parameters.AddWithValue("@CourseGUID", CourseGUID);
            cmd.Parameters.AddWithValue("@StudentsID", Session["StudentGUID"].ToString());
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            cmd.CommandText = "update Courses set ChoosedStudentsNum = ChoosedStudentsNum + 1 where GUID = @CourseGUID1";
            cmd.Parameters.AddWithValue("@CourseGUID1", CourseGUID);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
        return "Success";
    }

    //查
    [WebMethod(EnableSession = true)]
    public string InitStudentChoosingCourses()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select * from  Courses where 
(select count(1) as num from Course_Students where Courses.GUID = Course_Students.CourseGUID and  Course_Students.StudentsID = @StudentGUID) = 0 
and CourseGender like '%'+ @grade + '%'  and CourseLimitNum > ChoosedStudentsNum or CourseLimitNum = 0 ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@StudentGUID", Session["StudentGUID"].ToString());
            cmd.Parameters.AddWithValue("@grade", Session["Grade"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod(EnableSession = true)]
    public string InitStudentChoosedCourses()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select a.* from
 Courses as a
 left join
 Course_Students as b
 on a.GUID = b.CourseGUID
 where b.StudentsID = @StudentGUID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@StudentGUID", Session["StudentGUID"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

}
