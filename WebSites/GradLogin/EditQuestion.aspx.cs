using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.Security;

public partial class _EditQuestion : System.Web.UI.Page
{
        private string token = "ff0c267afe82cc51624b466b14483fea2c4422ec";
        private WebClient client = new WebClient();
        private string response = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["p"]))
                    Response.Redirect("Default.aspx");

                MapDataSource.SelectParameters.Clear(); //Select
                MapDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                DataSourceSelectArguments args = new DataSourceSelectArguments();
                DataView dv = (DataView)MapDataSource.Select(args);
                if (dv.Table.Rows[0]["Category"].ToString() != "Contest")
                    header.InnerHtml = "Edit Question: " + dv.Table.Rows[0]["Category"].ToString();
               
                var jss = new JavaScriptSerializer();
                string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] +"?access_token=" + token;
                response = client.DownloadString(url);
                var problemObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
                problem.InnerHtml = "<h3><strong>"+problemObj["name"]+"</strong></h3>" + problemObj["body"];
                foreach (var testcase in problemObj["testcases"])
                    problem.InnerHtml += "<br /><br /> active:" + testcase["active"] + "   number:" + testcase["number"];
            }
        }
}


