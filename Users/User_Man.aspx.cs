using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_User_Man : System.Web.UI.Page
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
        if (IsXls != ".xls" && IsXls != ".xlsx")
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
        DataTable dt = Util.GetTableSchema();
        if (rowsnum == 0)
        {
            Response.Write("<script>alert('Excel表为空表,无数据!')</script>");   //当Excel表为空时,对用户进行提示
        }
        else
        {
            using (SqlConnection conn = new DB().GetConnection())
            {
                SqlBulkCopy bulkCopy = new SqlBulkCopy(conn);
                bulkCopy.DestinationTableName = "Students";
                bulkCopy.BatchSize = dr.Length;
                conn.Open();
                for (int i = 0; i < dr.Length; i++)
                {
                    string psd = "";

                    foreach (string str in dr[i]["出生日期"].ToString().Split(' ')[0].ToString().Split('/'))
                    {
                        string time = str;
                        if (int.Parse(time) < 10)
                        {
                            time = "0" + Convert.ToString(time);
                        }

                        psd += time;
                    }
                    DataRow dr1 = dt.NewRow();
                    dr1[1] = Guid.NewGuid();
                    dr1[3] = dr[i]["年级"].ToString();
                    dr1[4] = dr[i]["年级"].ToString() + dr[i]["班级"].ToString();
                    dr1[6] = dr[i]["校内学号"].ToString();
                    dr1[7] = dr[i]["学生姓名"].ToString();
                    dr1[8] = dr[i]["性别"].ToString();
                    dr1[14] = Util.GetHash(psd);
                    dr1[15] = Convert.ToDateTime(dr[i]["出生日期"].ToString());
                    dt.Rows.Add(dr1);
                }
                if (dt != null && dt.Rows.Count != 0)
                {
                    bulkCopy.WriteToServer(dt);
                    Response.Write("<script>alert('成功导入数据');location='User_Man.aspx'</script></script> ");

                }
            }
        }

    }

}