using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CL_Course_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile == false)//HasFile用来检查FileUpload是否有指定文件
        {
            Response.Write("<script>alert('请您选择Excel文件')</script> ");
            return;//当无文件时,返回
        }
        string IsXls = System.IO.Path.GetExtension(FileUpload1.FileName).ToString().ToLower();//System.IO.Path.GetExtension获得文件的扩展名
        if (IsXls != ".xls")
        {
            Response.Write("<script>alert('只可以选择Excel文件')</script>");
            return;//当选择的不是Excel文件时,返回
        }
        string filename = DateTime.Now.ToString("yyyymmddhhMMss") + FileUpload1.FileName;              //获取Execle文件名  DateTime日期函数
        string savePath = Server.MapPath(("~\\upfiles\\") + filename);//Server.MapPath 获得虚拟服务器相对路径
        FileUpload1.SaveAs(savePath);                        //SaveAs 将上传的文件内容保存在服务器上
        DataSet ds = Util.ExecleDs(savePath, filename);           //调用自定义方法
        DataRow[] dr = ds.Tables[0].Select();            //定义一个DataRow数组
        int rowsnum = ds.Tables[0].Rows.Count;
        if (rowsnum == 0)
        {
            Response.Write("<script>alert('Excel表为空表,无数据!')</script>");   //当Excel表为空时,对用户进行提示
        }
        else
        {
            for (int i = 0; i < dr.Length; i++)
            {
                Boolean status;
                string GUID =  Guid.NewGuid().ToString();
                string CourseName = dr[i]["课程名"].ToString();//日期 excel列名【名称不能变,否则就会出错】
                DateTime CourseFirstStartDate = Convert.ToDateTime(dr[i]["开班日期"]);//编号 列名 以下类似
                string CourseWeekDate = dr[i]["上课时间"].ToString();
                string CourseSite = dr[i]["上课地点"].ToString();
                int CourseLimitNum = Convert.ToInt32(dr[i]["限制人数"].ToString());
                if (dr[i]["开班状态"].ToString() == "是") { status = true; }
                else { status = false; }
                Boolean CourseStatus = status;
                string CourseType = dr[i]["类型"].ToString();
                string CoursesTeachers = dr[i]["任课教师"].ToString();
                string CourseGender = dr[i]["开班年级"].ToString();
                string CourseNote = dr[i]["备注"].ToString();
               
                using (SqlConnection conn = new DB().GetConnection())
                {
                    string sqlcheck = "select count(*) from Courses where CourseName='" + CourseName +  "'";  //检查用户是否存在
                    SqlCommand cmd = new SqlCommand(sqlcheck, conn);
                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
               
                   
                        cmd.CommandText = "insert into Courses (GUID,CourseName,CourseFirstStartDate,CourseWeekDate,CourseSite,CourseLimitNum,CourseStatus,CourseType,CoursesTeachers,CourseGender,CourseNote) values('" + GUID + "','"+ CourseName + "','" + CourseFirstStartDate + "','" + CourseWeekDate + "','" + CourseSite + "','" + CourseLimitNum + "','" + CourseStatus + "','" + CourseType + "','" + CoursesTeachers + "','" + CourseGender + "','" + CourseNote + "')";
                        try
                        {
                            cmd.ExecuteNonQuery();
                        }
                        catch (MembershipCreateUserException ex)       //捕捉异常
                        {
                            Response.Write("<script>alert('导入内容:" + ex.Message + "')</script>");
                        }
                  
                }
               
             
            }
            Response.Write("<script>alert('Excle表导入成功!');location='Course_List.aspx'</script>");
        }
     }


   

}