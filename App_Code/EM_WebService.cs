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

        using (SqlConnection conn = new DB().GetConnection()) {
            StringBuilder sb = new StringBuilder("Insert into ScoreReport(GUID,GenerateUser,GenerateDate)");
            sb.Append(" values (@GUID,@GenerateUser,@GenerateDate)");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@GUID", reportGUID);
            cmd.Parameters.AddWithValue("@GenerateUser", Session["UserName"].ToString());
            cmd.Parameters.AddWithValue("@GenerateDate", DateTime.Now);
            conn.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            conn.Close();
        }

            for (int i = 0; i < dr.Length; i++)
       {
            string GUID = Guid.NewGuid().ToString();
            string StudentGUID = dr[i]["GUID"].ToString();
            string CourseGUID = dr[i]["CourseGUID"].ToString();
            string Grade = dr[i]["Evaluation"].ToString();
            string BelongToYear = "2018学年";
            string BelongToTerm = "上学期";
            using (SqlConnection conn = new DB().GetConnection())
            {
                string insertData = "insert into StudentCourseEvaluation (GUID,CourseGUID,StudentGUID,Grade,BelongToYear,BelongToTerm,ScoreReportGUID) values('" + GUID + "','" + CourseGUID + "','" + StudentGUID + "','" + Grade + "','" + BelongToYear + "','" + BelongToTerm + "','" + reportGUID + "')";
                SqlCommand cmd = new SqlCommand(insertData, conn);
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                catch (MembershipCreateUserException ex)       //捕捉异常
                {
                    HttpResponse Response = System.Web.HttpContext.Current.Response;
                    Response.Write("<script>alert('导入内容:" + ex.Message + "')</script>");
                }
            }

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
        return "Success";
    }

 }
