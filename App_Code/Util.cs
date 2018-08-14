using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Configuration;
using System.Management;
using System.Web.Script.Serialization;
using System.Data.OleDb;

/// <summary>
/// Util 的摘要说明
/// </summary>
public class Util
{
    public Util()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }


    public static void ShowMessage(string words, string location)
    {
        System.Web.HttpContext.Current.Response.Write("<script>alert('" + words + "');</script>");
        System.Web.HttpContext.Current.Response.Write("<script>location.href='" + location + "';</script>");

    }


    public static string generateGUID()
    {
        string strGUID = System.Guid.NewGuid().ToString();
        return strGUID;
    }

    //用于登录密码哈希加密
    public static string GetHash(string password)
    {
        byte[] b = System.Text.ASCIIEncoding.ASCII.GetBytes(password);
        byte[] b2 = new SHA1Managed().ComputeHash(b);
        return Convert.ToBase64String(b2, 0, b2.Length);
    }

    //检查数据库信息是否重复
    public static bool AreadyExist(string table, string column, string value)
    {
        bool result = false;
        using (IDbConnection conn = new DB().GetConnection())
        {
            IDbCommand cmd = conn.CreateCommand();
            cmd.CommandText = "select count(*) from " + table + " where " + column + " = '" + value + "'";
            conn.Open();
            if ((int)cmd.ExecuteScalar() > 0)
            {
                result = true;
            }
        }
        return result;
    }

    /*用于DataSet转化为Json字符串返回*/
    public static string Dtb2Json(DataTable dtb)
    {
        JavaScriptSerializer jss = new JavaScriptSerializer();
        System.Collections.ArrayList dic = new System.Collections.ArrayList();
        foreach (DataRow dr in dtb.Rows)
        {
            System.Collections.Generic.Dictionary<string, object> drow = new System.Collections.Generic.Dictionary<string, object>();
            foreach (DataColumn dc in dtb.Columns)
            {
                drow.Add(dc.ColumnName, dr[dc.ColumnName]);
            }
            dic.Add(drow);
        }
        return jss.Serialize(dic);
    }

    public static DataTable JsonToDataSet(string Json)
    {
        DataTable dataTable = new DataTable();  //实例化
        DataTable result;
       
            JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
            javaScriptSerializer.MaxJsonLength = Int32.MaxValue; //取得最大数值
            ArrayList arrayList = javaScriptSerializer.Deserialize<ArrayList>(Json);
            if (arrayList.Count > 0)
            {
                foreach (Dictionary<string, object> dictionary in arrayList)
                {
                    if (dictionary.Keys.Count<string>() == 0)
                    {
                        result = dataTable;
                        return result;
                    }
                    if (dataTable.Columns.Count == 0)
                    {
                        foreach (string current in dictionary.Keys)
                        {
                            dataTable.Columns.Add(current, dictionary[current].GetType());
                        }
                    }
                    DataRow dataRow = dataTable.NewRow();
                    foreach (string current in dictionary.Keys)
                    {
                        dataRow[current] = dictionary[current];
                    }

                    dataTable.Rows.Add(dataRow); //循环添加行到DataTable中
                }
            }
       
        result = dataTable;
        return result;
    }


    public static DataTable GetTableSchema() {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[] {
        new DataColumn("ID",typeof(int)),
        new DataColumn("GUID",typeof(string)),
        new DataColumn("Class",typeof(string)),
        new DataColumn("Grade",typeof(string)),
        new DataColumn("PoliticClass",typeof(string)),
        new DataColumn("HierarchicalClass",typeof(string)),
        new DataColumn("SchoolNum", typeof(string)),
        new DataColumn("StudentName",typeof(string)),
        new DataColumn("Gender",typeof(string)),
        new DataColumn("PerformaneSysClass",typeof(string)),
        new DataColumn("HeadTeacher",typeof(string)),
        new DataColumn("NationalStudentNum",typeof(string)),
        new DataColumn("IDCard", typeof(string)),
        new DataColumn("SchoolRegisterClass", typeof(string)),
        new DataColumn("Password", typeof(string)),
        new DataColumn("Birthdate",typeof(DateTime)),
    });
      
        return dt;
    }

    public static DataSet ExecleDs(string filenameurl, string table)
    {
        string strConn = "Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + filenameurl + ";Extended Properties='Excel 12.0; HDR=YES; IMEX=1'";
        OleDbConnection conn = new OleDbConnection(strConn);
        conn.Open();
        DataSet ds = new DataSet();
        OleDbDataAdapter odda = new OleDbDataAdapter("select * from [Sheet1$]", conn);
        odda.Fill(ds, table);
        return ds;
    }


    public static DataSet GetStrDataSet(string CourseGUID)
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
WHERE c.GUID = @CourseGUID ");
            SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
            cmd.Parameters.AddWithValue("@CourseGUID", CourseGUID);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            conn.Close();
           
        }
        return ds;

    }

    
       

}