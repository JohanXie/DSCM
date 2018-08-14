using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CL_AttendanceReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
       ;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        //定义查询的SQL语句
        string strsql = @"select a.*,c.CoursesTeachers,c.CourseName,c.CourseType,c.CourseWeekDate,c.CourseSite
from Students as a
left join
Course_Students as b
on a.GUID = b.StudentsID
join Courses as c
on b.CourseGUID = c.GUID
where c.GUID = @CourseGUID";
        using (SqlConnection conn = new DB().GetConnection())
        {
            SqlCommand cmd = new SqlCommand(strsql, conn);
            cmd.Parameters.AddWithValue("@CourseGUID", Request.QueryString["ID"].ToString());
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
            conn.Close();
        }
        //创建一个内存表
        DataTable DT = ds.Tables[0];
        //生成将要存放结果的Excel文件的名称
        string NewFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx";
        //转换为物理路径
        NewFileName = Server.MapPath("Temp/" + NewFileName);
        //根据模板正式生成该Excel文件
        File.Copy(Server.MapPath("Attendance.xlsx"), NewFileName, true);
        //建立指向该Excel文件的数据库连接
        string strConn = "Provider=Microsoft.Ace.OleDb.12.0;Data Source=" + NewFileName + ";Extended Properties='Excel 12.0;'";
        OleDbConnection Conn = new OleDbConnection(strConn);
        //打开连接，为操作该文件做准备
        Conn.Open();
        OleDbCommand Cmd = new OleDbCommand("", Conn);
        int i = 0;
        //依次添加数据
        foreach (DataRow DR in DT.Rows)
        {
            i = i + 1;
            string XSqlString = "insert into [Sheet1$]";
            XSqlString += "([序号],[班别],[姓名]) values(";
            XSqlString += "'" + i.ToString() + "',";
            XSqlString += "'" + DR["PoliticClass"] + "',";
            XSqlString += "'" + DR["StudentName"] + "')";
            Cmd.CommandText = XSqlString;
            Cmd.ExecuteNonQuery();
        }
        //操作结束，关闭连接
        Conn.Close();
        //打开要下载的文件，并把该文件存放在FileStream中
        System.IO.FileStream Reader = System.IO.File.OpenRead(NewFileName);
        //文件传送的剩余字节数：初始值为文件的总大小
        long Length = Reader.Length;
        Response.Buffer = false;
        Response.AddHeader("Connection", "Keep-Alive");
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + Server.UrlEncode("学生出勤表.xls"));
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
}