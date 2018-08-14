<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

public class Handler : IHttpHandler,IReadOnlySessionState, IRequiresSessionState{

    public void ProcessRequest (HttpContext context) {
        try
        {
            string s = context.Request.Form["courseguid"];
            //string key = context.Request["key"];
            HttpResponse Response = System.Web.HttpContext.Current.Response;
            //Util.ShowMessage(context.Request["courseguid"],"");
            Response.Write("<script>alert(" + context.Request["courseguid"]  + ");</script>");
            test2(context);

        }
        catch (Exception ex)
        {
        }
    }



    private void test2(HttpContext context) {
        //string courseguid = context.Request["courseguid"];

        //调用GetStrDataSet方法查询成绩并将查询结果放到DataSet数据集中
        DataSet ds = GetStrDataSet();
        //创建一个内存表
        DataTable DT = ds.Tables[0];
        //生成将要存放结果的Excel文件的名称
        string NewFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx";
        //转换为物理路径
        NewFileName = context.Server.MapPath("Temp/" + NewFileName);
        //根据模板正式生成该Excel文件
        File.Copy(context.Server.MapPath("Registration.xlsx"), NewFileName, true);
        //建立指向该Excel文件的数据库连接
        string strConn = "Provider=Microsoft.Ace.OleDb.12.0;Data Source=" + NewFileName + ";Extended Properties='Excel 12.0;'";
        OleDbConnection Conn = new OleDbConnection(strConn);
        //打开连接，为操作该文件做准备
        Conn.Open();
        OleDbCommand Cmd = new OleDbCommand("", Conn);
        //依次添加数据
        foreach (DataRow DR in DT.Rows)
        {
            string XSqlString = "insert into [Sheet1$]";
            XSqlString += "([班别],[姓名],[校内学号],[课程名称],[课程类型],[上课时间],[上课地点],[指导老师]) values(";
            XSqlString += "'" + DR["PoliticClass"] + "',";
            XSqlString += "'" + DR["StudentName"] + "',";
            XSqlString += "'" + DR["SchoolNum"] + "',";
            XSqlString += "'" + DR["CourseName"] + "',";
            XSqlString += "'" + DR["CourseType"] + "',";
            XSqlString += "'" + DR["CourseWeekDate"] + "',";
            XSqlString += "'" + DR["CourseSite"] + "',";
            XSqlString += "'" + DR["CoursesTeachers"] + "')";
            Cmd.CommandText = XSqlString;
            Cmd.ExecuteNonQuery();
        }
        //操作结束，关闭连接
        Conn.Close();
        //打开要下载的文件，并把该文件存放在FileStream中
        System.IO.FileStream Reader = System.IO.File.OpenRead(NewFileName);
        //文件传送的剩余字节数：初始值为文件的总大小
        long Length = Reader.Length;
        HttpResponse Response = System.Web.HttpContext.Current.Response;
        Response.Buffer = false;
        Response.AddHeader("Connection", "Keep-Alive");
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + context.Server.UrlEncode("学生成绩.xls"));
        Response.AddHeader("Content-Length", Length.ToString());
        //存放欲发送数据的缓冲区
        byte[] Buffer = new Byte[10000];
        //每次实际读取的字节数
        int ByteToRead;
        while (Length > 0)
        {
            //剩余字节数不为零，继续传送
            if (Response.IsClientConnected)
            {
                //客户端浏览器还打开着，继续传送
                //往缓冲区读入数据
                ByteToRead = Reader.Read(Buffer, 0, 10000);
                //把缓冲区的数据写入客户端浏览器
                Response.OutputStream.Write(Buffer, 0, ByteToRead);
                //立即写入客户端
                Response.Flush();
                //剩余字节数减少
                Length -= ByteToRead;
            }
            else
            {
                //客户端浏览器已经断开，阻止继续循环
                Length = -1;
            }
        }
        //关闭该文件
        Reader.Close();
        //删除该Excel文件
        File.Delete(NewFileName);

    }

    private DataSet GetStrDataSet()
    {

        DataSet ds = new DataSet();
        //定义查询的SQL语句
        string strsql = @"select a.*,c.CoursesTeachers,c.CourseName,c.CourseType,c.CourseWeekDate,c.CourseSite
from Students as a
left join
Course_Students as b
on a.GUID = b.StudentsID
join Courses as c
on b.CourseGUID = c.GUID";
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = new SqlCommand(strsql, conn);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            conn.Close();
        }
        return ds;
    }


    private void test1(HttpContext context)
    {
        HttpResponse resp = System.Web.HttpContext.Current.Response;
        resp.Charset = "utf-8";
        resp.Clear();
        string filename = "统计贴标报表_" + DateTime.Now.ToString("yyyyMMddHHmmss");
        resp.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");
        resp.ContentEncoding = System.Text.Encoding.UTF8;

        resp.ContentType = "application/ms-excel";
        string style = "<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=utf-8\"/>" + "<style> .table{ font: 9pt Tahoma, Verdana; color: #000000; text-align:center;  background-color:#8ECBE8;  }.table td{text-align:center;height:21px;background-color:#EFF6FF;}.table th{ font: 9pt Tahoma, Verdana; color: #000000; font-weight: bold; background-color: #8ECBEA; height:25px;  text-align:center; padding-left:10px;}</style>";
        resp.Write(style);

        resp.Write("<table class='table'><tr><th>姓名</th><th>出生年月</th><th>籍贯</th><th>毕业时间</th></tr>");

        System.Data.DataTable dtSource = new System.Data.DataTable();
        dtSource.TableName = "statistic";
        dtSource.Columns.Add("第一列");
        dtSource.Columns.Add("第二列");
        dtSource.Columns.Add("第三列");
        dtSource.Columns.Add("第四列");


        System.Data.DataRow row = null;
        row = dtSource.NewRow();
        row[0] = "李四";
        row[1] = "1987-09-02";
        row[2] = "湖北武汉";
        row[3] = "2009年毕业";
        dtSource.Rows.Add(row);

        row = dtSource.NewRow();
        row[0] = "王五";
        row[1] = "1987-09-01";
        row[2] = "湖南湘潭";
        row[3] = "2013年毕业";
        dtSource.Rows.Add(row);

        foreach (DataRow tmpRow in dtSource.Rows)
        {
            resp.Write("<tr><td>" + tmpRow[0] + "</td>");
            resp.Write("<td>" + tmpRow[1] + "</td>");
            resp.Write("<td>" + tmpRow[2] + "</td>");
            resp.Write("<td>" + tmpRow[3] + "</td>");
            resp.Write("</tr>");
        }
        resp.Write("<table>");

        resp.Flush();
        resp.End();
    }






    public bool IsReusable {
        get {
            return false;
        }
    }

}