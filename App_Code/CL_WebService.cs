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
using System.IO;
using System.Data.OleDb;
using System.Web.Security;

/// <summary>
/// CL_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
 [System.Web.Script.Services.ScriptService]
public class CL_WebService : System.Web.Services.WebService
{

    public CL_WebService()
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
    public string addCourse(string CourseName, DateTime CourseFirstStartDate, string CourseWeekDate, string CourseSite, int CourseLimitNum, Boolean CourseStatus, string CourseType, string CourseTeachers, string CourseGender, string CourseNote) {
        string strGUID = Util.generateGUID();
        //string[] array = CourseTeachers.Split(',');
        //int len = array.Length;
        //DataTable dt = Util.GetTableSchema();
        int j;
     
        using (SqlConnection conn = new DB().GetConnection())
        {
            //SqlBulkCopy bulkCopy = new SqlBulkCopy(conn);
            //bulkCopy.DestinationTableName = "Course_Teachers";
            //bulkCopy.BatchSize = dt.Rows.Count;
            conn.Open();

            //for (int i = 0; i < len; i++)
            //{
            //    DataRow dr = dt.NewRow();
            //    dr[1] = Guid.NewGuid();
            //    dr[2] = strGUID;
            //    dr[3] = array[i];
            //    dt.Rows.Add(dr);
            //}
            //if (dt != null && dt.Rows.Count != 0)
            //{
            //    bulkCopy.WriteToServer(dt);
            //}

            StringBuilder sb = new StringBuilder("insert into Courses(GUID,CourseName,CourseFirstStartDate,CourseWeekDate,CourseSite, CourseLimitNum,CourseStatus,CourseType,CourseGender,CourseNote,CoursesTeachers) ");
            sb.Append("values (@GUID,@CourseName,@CourseFirstStartDate,@CourseWeekDate,@CourseSite,@CourseLimitNum,@CourseStatus,@CourseType,@CourseGender,@CourseNote,@CoursesTeachers)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", strGUID);
            cmd.Parameters.AddWithValue("@CourseName", CourseName);
            cmd.Parameters.AddWithValue("@CourseFirstStartDate", CourseFirstStartDate);
            cmd.Parameters.AddWithValue("@CourseWeekDate", CourseWeekDate);
            cmd.Parameters.AddWithValue("@CourseSite", CourseSite);
            cmd.Parameters.AddWithValue("@CourseLimitNum", CourseLimitNum);
            cmd.Parameters.AddWithValue("@CourseStatus", CourseStatus);
            cmd.Parameters.AddWithValue("@CourseType", CourseType);
            cmd.Parameters.AddWithValue("@CourseGender", CourseGender);
            cmd.Parameters.AddWithValue("@CourseNote", CourseNote);
            cmd.Parameters.AddWithValue("@CoursesTeachers", CourseTeachers);
            j = cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();

        }
         return "Success";
    }

    [WebMethod(EnableSession = true)]
    public string addStudentsIntoCourse(string CourseGUID, string StudentsGUID)
    {
        int i = 0;
        string[] array = StudentsGUID.Split(',');
        int len = array.Length;
       
            using (SqlConnection conn = new DB().GetConnection())
            {
                conn.Open();
                for (int j = 0; j < len; j++)
                {
                    StringBuilder sb = new StringBuilder("insert into Course_Students(GUID,CourseGUID,StudentsID) ");
                    sb.Append("values (@GUID,@CourseGUID,@StudentsID)");
                    SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
                    cmd.Parameters.AddWithValue("@GUID", Guid.NewGuid().ToString());
                    cmd.Parameters.AddWithValue("@CourseGUID", CourseGUID);
                    cmd.Parameters.AddWithValue("@StudentsID", array[j]);
                    i = cmd.ExecuteNonQuery();

                }

                StringBuilder sb2 = new StringBuilder("update Courses set ChoosedStudentsNum= ChoosedStudentsNum + @Users where GUID=@CourseGUID2");
                SqlCommand cmd2 = new SqlCommand(sb2.ToString(), conn);
                cmd2.Parameters.AddWithValue("@Users", len);
                cmd2.Parameters.AddWithValue("@CourseGUID2", CourseGUID);
                cmd2.ExecuteNonQuery();

                conn.Close();
            }
       
            return "Success";
    }


    //删
    [WebMethod(EnableSession = true)]
    public string DelCourseStudent(string GUID, string CourseGUID)
    {
      
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete from Course_Students where GUID = @GUID");
            conn.Open();
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", GUID);
            cmd.ExecuteNonQuery();
            cmd.Dispose();


            cmd.CommandText = "update Courses set ChoosedStudentsNum = ChoosedStudentsNum - 1 where GUID = @CourseGUID1";
            cmd.Parameters.AddWithValue("@CourseGUID1", CourseGUID);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
        return "Success";
      
    }

    [WebMethod(EnableSession = true)]
    public int datchDelStusInCourse(string ids,string CourseGUID,int StusLen)
    {
        int i = 0;
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder("delete from Course_Students  where StudentsID in (SELECT GUID FROM Students where ID in (" + ids + ")) and CourseGUID = @CourseGUID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@ids", ids);
            cmd.Parameters.AddWithValue("@CourseGUID", CourseGUID);
            conn.Open();
            i = cmd.ExecuteNonQuery();
            cmd.Dispose();


            cmd.CommandText = "update Courses set ChoosedStudentsNum = ChoosedStudentsNum - @Len where GUID = @CourseGUID1";
            cmd.Parameters.AddWithValue("@Len", StusLen);
            cmd.Parameters.AddWithValue("@CourseGUID1", CourseGUID);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }
        return i;
    }


    //查
    [WebMethod(EnableSession = true)]
    public string InitCourses()
    {
        string teacherGUID = "f71786b4-1d45-4191-af29-04a6bb43bb58";
        string gradeDirector = "4baf0678-0d12-4bef-bacd-ba949e06f388";
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select * from Courses ");
            if (Session["RoleGUID"].ToString() == teacherGUID) //老师
            {
                sb.Append("where CoursesTeachers = @TeacherName");
            } else if (Session["RoleGUID"].ToString() == gradeDirector)//级主任
            {
                sb.Append("where CourseGender like  '%'+ @Grade + '%'");
            }
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            if (Session["RoleGUID"].ToString() == teacherGUID) //老师
            {
                cmd.Parameters.AddWithValue("@TeacherName", Session["UserName"].ToString());
            }
            else if (Session["RoleGUID"].ToString() == gradeDirector)//级主任
            {
                cmd.Parameters.AddWithValue("@Grade", Session["Class"].ToString().Substring(0, 2));
            }
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod(EnableSession = true)]
    public string InitStudents()
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select * from Students");
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
    public string InitClass(string Grade)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select * from Class where Class like  '%'+ @grade + '%'");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@grade", Grade);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod(EnableSession = true)]
    public string InitCourseUsers(string CourseGUID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"SELECT a.*,b.GUID FROM Students  as a
 left join 
 Course_Students as b
 on a.GUID = b.StudentsID 
 where b.CourseGUID = @CourseGUID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CourseGUID", CourseGUID);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

   
     [WebMethod(EnableSession = true)]
    public string exportRegisterExcel(string CourseGUID)
    {
        DataSet ds = new DataSet();
        using (SqlConnection conn = new DB().GetConnection())
        {
            //定义查询的SQL语句
            StringBuilder sb = new StringBuilder(@"select a.*,c.CoursesTeachers,c.CourseName,c.CourseType,c.CourseWeekDate,c.CourseSite
from Students as a
left join
Course_Students as b
on a.GUID = b.StudentsID
join Courses as c
on b.CourseGUID = c.GUID
WHERE c.GUID = @CourseGUID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CourseGUID", CourseGUID);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            conn.Close();
        }
        return  Util.Dtb2Json(ds.Tables[0]);
    }

    [WebMethod(EnableSession = true)]
    public string exportClassStudentsExcel() {
        DataSet ds = new DataSet();
        using (SqlConnection conn = new DB().GetConnection())
        {
            //定义查询的SQL语句
            StringBuilder sb = new StringBuilder(@"select a.*,c.CoursesTeachers,c.CourseName,c.CourseType,c.CourseWeekDate,c.CourseSite
from Students as a
left join
Course_Students as b
on a.GUID = b.StudentsID
join Courses as c
on b.CourseGUID = c.GUID
WHERE  a.PoliticClass = @PoliticClass");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@PoliticClass", Session["Class"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }

    [WebMethod(EnableSession = true)]
    public string exportGradeStudentsExcel()
    {
        DataSet ds = new DataSet();
        using (SqlConnection conn = new DB().GetConnection())
        {
            //定义查询的SQL语句
            StringBuilder sb = new StringBuilder(@"select a.*,c.CoursesTeachers,c.CourseName,c.CourseType,c.CourseWeekDate,c.CourseSite
from Students as a
left join
Course_Students as b
on a.GUID = b.StudentsID
join Courses as c
on b.CourseGUID = c.GUID
WHERE  a.Grade = @Grade");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@Grade", Session["Class"].ToString().Substring(0, 2));
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            conn.Close();
        }
        return Util.Dtb2Json(ds.Tables[0]);
    }

}
