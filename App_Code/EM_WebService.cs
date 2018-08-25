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
using System.Web.Security;

/// <summary>
/// EM_WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
 [System.Web.Script.Services.ScriptService]
public class EM_WebService : System.Web.Services.WebService
{

    public EM_WebService()
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
    public string addStudentsEvaluation(string evaluationData) {
       DataTable ds = Util.JsonToDataSet(evaluationData);
       DataRow[] dr = ds.Select();   //定义一个DataRow数组
       string reportGUID = Guid.NewGuid().ToString();
        string BelongToYear = "2018学年";
        string BelongToTerm = "上学期";
        string courseGUID = "";
        DataTable dt = Util.GetEvaluationTableSchema();

        using (SqlConnection conn = new DB().GetConnection()) {
            SqlBulkCopy bulkCopy = new SqlBulkCopy(conn);
            bulkCopy.DestinationTableName = "StudentCourseEvaluation";
            bulkCopy.BatchSize = dr.Length;
            conn.Open();
            for (int i = 0; i < dr.Length; i++)
            {
                DataRow dr1 = dt.NewRow();
                dr1[1] = Guid.NewGuid();
                dr1[2] = dr[i]["CourseGUID"].ToString();
                dr1[3] = dr[i]["GUID"].ToString();
                dr1[4] = dr[i]["Evaluation"].ToString();
                dr1[5] = reportGUID;
                dt.Rows.Add(dr1);
                if (i == dr.Length - 1) {
                    courseGUID = dr[i]["CourseGUID"].ToString();
                }
            }
            if (dt != null && dt.Rows.Count != 0)
            {
                bulkCopy.WriteToServer(dt);
            }


            StringBuilder sb = new StringBuilder("Insert into ScoreReport(GUID,GenerateUser,GenerateDate,CourseGUID,BelongToTerm,BelongToYear)");
            sb.Append(" values (@GUID,@GenerateUser,@GenerateDate,@CourseGUID,@BelongToTerm,@BelongToYear)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", reportGUID);
            cmd.Parameters.AddWithValue("@GenerateUser", Session["UserName"].ToString());
            cmd.Parameters.AddWithValue("@GenerateDate", DateTime.Now);
            cmd.Parameters.AddWithValue("@CourseGUID", courseGUID);
            cmd.Parameters.AddWithValue("@BelongToTerm", BelongToTerm);
            cmd.Parameters.AddWithValue("@BelongToYear", BelongToYear);
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }


            return "Success";
    }

    //查
    [WebMethod(EnableSession = true)]
    public string getCourseStudents(string CourseGUID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@" select a.GUID,a.PoliticClass,a.StudentName
from Students as a
left join 
Course_Students as b
on a.GUID = b.StudentsID
where b.CourseGUID =  @CourseGUID");
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
    public string getScoreReport( ) {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@" select a.*,b.CourseName from
ScoreReport  as a
left join Courses as b
on a.CourseGUID = b.GUID");
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
    public string exportCourseScoreExcel(string ScoreReportGUID)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@" select a.Grade,
b.PoliticClass,b.StudentName,b.SchoolNum,
c.CourseName
from StudentCourseEvaluation as a
left join
Students as b
on a.StudentGUID = b.GUID
left join
Courses as c
on a.CourseGUID = c.GUID
where a.ScoreReportGUID = @ScoreReportGUID");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@ScoreReportGUID", ScoreReportGUID);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);
        }
    }

    [WebMethod(EnableSession = true)]
    public string getCourseByYear(string BelongToYear)
    {
        using (SqlConnection conn = new DB().GetConnection())
        {
            StringBuilder sb = new StringBuilder(@"select GUID,CourseName,BelongtoYear,BelongtoTerm from Courses where BelongToYear = @BelongToYear");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@BelongToYear", BelongToYear);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            return Util.Dtb2Json(ds.Tables[0]);

        }
    }
    

}
