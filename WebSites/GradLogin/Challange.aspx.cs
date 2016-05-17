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

public partial class _Challange : System.Web.UI.Page
{
        private string token = "ff0c267afe82cc51624b466b14483fea2c4422ec";
        private WebClient client = new WebClient();
        private string response = "";
        public static List<string> languageId = new List<string>();
        public string testCases="";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            int postback = 1;
            if (!Page.IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["p"]))
                    Response.Redirect("Default.aspx");                

                DropDownLanguage.Attributes.Add("onchange", "fillSampleCode();");
                languageId.Clear(); 
                var jss = new JavaScriptSerializer();
                string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/compilers?access_token=" + token;
                response = client.DownloadString(url);
                var langObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
                for (int i = 0; i < langObj["items"].Count; i++)
                {
                    DropDownLanguage.Items.Add(langObj["items"][i]["name"] +" ("+ langObj["items"][i]["ver"]+")");
                    languageId.Add(langObj["items"][i]["id"].ToString());
                }

                url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] +"?access_token=" + token;
                response = client.DownloadString(url);
                var problemObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
                problem.InnerHtml = "<h3><strong>"+problemObj["name"]+"</strong></h3>" + problemObj["body"];

                SubmissionDataSource.SelectParameters.Clear(); //Select
                SubmissionDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                SubmissionDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                DataSourceSelectArguments args = new DataSourceSelectArguments();
                DataView dv = (DataView)SubmissionDataSource.Select(args);
                if (dv.Table.Rows.Count == 1)
                {
                    string submissionId = dv.Table.Rows[0]["SubmissionId"].ToString();
                    url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/submissions/" + submissionId + "?access_token=" + token;
                    response = client.DownloadString(url);
                    var oldSubmission = jss.Deserialize<Dictionary<string, dynamic>>(response);
                    TextBoxCode.Text = oldSubmission["source"];
                    DropDownLanguage.SelectedIndex = oldSubmission["language"] - 1;
                }
                else
                {
                    postback = 0;
                    DropDownLanguage.SelectedIndex = 10;
                }
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "init", "init(" + postback.ToString() + ")", true);
        }

        protected void ButtonCompile_Click(object sender, EventArgs e)
        {
            var jss = new JavaScriptSerializer();
            string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/submissions?access_token=" + token;
            string code = TextBoxCode.Text;
            var json = jss.Serialize(code);
            string jsonData = "{\"compilerId\":" + languageId[DropDownLanguage.SelectedIndex] + ",\"source\":" + json + ",\"problemCode\":\"" + Request.QueryString["p"] + "\"}";
            client.Headers.Add("Content-Type", "application/json");
            response = client.UploadString(url, "POST", jsonData);
            var idObj = jss.Deserialize<Dictionary<string, string>>(response);
            string id = idObj["id"];

            bool finished = false;
            while (!finished)
            {
                url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/submissions/"+id+"?access_token="+token;
                response = client.DownloadString(url);
                var resultObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
                if (resultObj["status"] > 10)
                {
                    finished = true;
                    testCases="";
                    for (int i = 0; i < resultObj["result_array"].Count; i++)
                    {
                        testCases += "<h5><a href=\"#\"><label><i class=\"fa fa-keyboard-o fa-fw\"></i> Testcase " + (i + 1).ToString() + "</label></a></h5><div class=\"no-padding\" style=\"border:0;\">";
                        testCases += "<table aria-describedby=\"dataTables-example_info\" role=\"grid\"" +
                                        "class=\"table table-responsive table-striped table-bordered table-hover dataTable no-footer dtr-inline\""+
                                        "width=\"100%\"><tbody>";
                        if (i==0 && resultObj["result_stdout"].Contains("DATASET NUMBER: 0"))
                            testCases += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Output</label></td><td>" + resultObj["result_stdout"].Split('\n')[2] + "</td></tr>";
                        testCases += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Time</label></td><td>" + resultObj["result_array"][i]["time"] + "</td></tr>";
                        testCases += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Memory</label></td><td>" + resultObj["result_array"][i]["memory"] + "</td></tr>";
                        testCases += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Status</label></td><td>" + resultObj["result_array"][i]["statusDescription"] + "</td></tr>";
                        testCases += "</tbody></table></div>";
                    }


                    compInfo.InnerHtml = "<table aria-describedby=\"dataTables-example_info\" role=\"grid\""+
                                        "class=\"table table-responsive table-striped table-bordered table-hover dataTable no-footer dtr-inline\""+
                                        "width=\"100%\"><tbody>";
                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Score</label></td><td>" + resultObj["result_score"] + "</td></tr>";
                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>LangName</label></td><td>" + resultObj["compiler"]["name"] + "</td></tr>";
                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Time</label></td><td>" + resultObj["result_time"] + "</td></tr>";
                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Memory</label></td><td>" + resultObj["result_memory"] + "</td></tr>";
                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Signal</label></td><td>" + resultObj["result_signal"] + "</td></tr>";

                    if (resultObj["result_cmperr"] != "")
                        compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Compile Error</label></td><td>" + resultObj["result_cmperr"] + "</td></td>";

                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Status</label></td><td>" + resultObj["statusDescription"] + "</td></tr>";

                    compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>Result</label></td><td>";
                    if (resultObj["status"] == 11)
                        compInfo.InnerHtml += "Compilation Error";
                    if (resultObj["status"] == 12)
                        compInfo.InnerHtml += "Runtime Error";
                    if (resultObj["status"] == 13)
                        compInfo.InnerHtml += "Time Limit Exceeded";
                    if (resultObj["status"] == 14)
                        compInfo.InnerHtml += "Wrong Answer";
                    if (resultObj["status"] == 15)
                        compInfo.InnerHtml += "Success";
                    if (resultObj["status"] == 17)
                        compInfo.InnerHtml += "Memory Limit Exceeded";
                    if (resultObj["status"] == 19)
                        compInfo.InnerHtml += "Illegal System Call";
                    if (resultObj["status"] == 20 || resultObj["status"] == 21)
                        compInfo.InnerHtml += "Internal Error";

                    compInfo.InnerHtml += "</td></tr></tbody></table>";

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "init", "g1.refresh(" + resultObj["result_score"] + ")", true);

                    SubmissionDataSource.SelectParameters.Clear(); //Select
                    SubmissionDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                    SubmissionDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                    DataSourceSelectArguments args = new DataSourceSelectArguments();
                    DataView dv = (DataView)SubmissionDataSource.Select(args);
                    if (dv.Table.Rows.Count == 1) //Update if exist
                    {
                        SubmissionDataSource.UpdateParameters.Clear();
                        SubmissionDataSource.UpdateParameters.Add("Score", Convert.ToInt32(resultObj["result_score"]).ToString());
                        SubmissionDataSource.UpdateParameters.Add("SubmissionId", id);
                        SubmissionDataSource.UpdateParameters.Add("Question", Request.QueryString["p"]);
                        SubmissionDataSource.UpdateParameters.Add("Username", Membership.GetUser().UserName);
                        SubmissionDataSource.UpdateParameters.Add("Date", DateTime.Now.ToString("MM/dd/yyyy"));
                        SubmissionDataSource.UpdateParameters.Add("Language", DropDownLanguage.Items[resultObj["language"] - 1].Text);
                        SubmissionDataSource.Update();
                    }
                    else //Insert
                    {
                        SubmissionDataSource.InsertParameters.Clear();
                        SubmissionDataSource.InsertParameters.Add("Score", Convert.ToInt32(resultObj["result_score"]).ToString());
                        SubmissionDataSource.InsertParameters.Add("SubmissionId", id);
                        SubmissionDataSource.InsertParameters.Add("Question", Request.QueryString["p"]);
                        SubmissionDataSource.InsertParameters.Add("Username", Membership.GetUser().UserName);
                        SubmissionDataSource.InsertParameters.Add("Date", DateTime.Now.ToString("MM/dd/yyyy"));
                        SubmissionDataSource.InsertParameters.Add("Language", DropDownLanguage.Items[resultObj["language"] - 1].Text);
                        SubmissionDataSource.Insert();
                    }
                }
            }
        }
}


