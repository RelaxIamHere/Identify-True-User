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
        public static List<string> languageId;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            int postback = 1;
            if (!Page.IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["p"]))
                    Response.Redirect("Default.aspx");

                MapDataSource.SelectParameters.Clear(); //Select
                MapDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                DataSourceSelectArguments args = new DataSourceSelectArguments();
                DataView dv = (DataView)MapDataSource.Select(args);
                if (dv.Table.Rows[0]["Category"].ToString() != "Contest")
                    header.InnerHtml = "Category: " + dv.Table.Rows[0]["Category"].ToString();
                

                DropDownLanguage.Attributes.Add("onchange", "fillSampleCode();");
                languageId = new List<string>();
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
                args = new DataSourceSelectArguments();
                dv = (DataView)SubmissionDataSource.Select(args);
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
                    TextBoxCompiler.Text = "";
                    TextBoxOutput.Text = "";
                    if (resultObj["result_stdout"].Contains("DATASET NUMBER: 0"))
                        TextBoxOutput.Text = resultObj["result_stdout"].Split('\n')[2];
                            
                    TextBoxScore.Text = "SCORE: " +resultObj["result_score"];

                    for (int i = 0; i < resultObj["result_array"].Count; i++)
                    {
                        TextBoxScore.Text += "\n\nTEST CASE: "+(i+1).ToString();
                        TextBoxScore.Text += "\ntime: " + resultObj["result_array"][i]["time"];
                        TextBoxScore.Text += "\nmemory: " + resultObj["result_array"][i]["memory"];
                        TextBoxScore.Text += "\nstatus: " + resultObj["result_array"][i]["statusDescription"];
                    }

                    TextBoxCompiler.Text = "";
                    TextBoxCompiler.Text += "langName: " + resultObj["compiler"]["name"];
                    TextBoxCompiler.Text += "\ntime: " + resultObj["result_time"];
                    TextBoxCompiler.Text += "\nmemory: " + resultObj["result_memory"];
                    TextBoxCompiler.Text += "\nsignal: " + resultObj["result_signal"];

                    if (resultObj["result_cmperr"] != "")
                        TextBoxCompiler.Text += "\ncmperr: " + resultObj["result_cmperr"];

                    TextBoxCompiler.Text += "\nstatus: " + resultObj["statusDescription"];

                    TextBoxCompiler.Text += "\nresult: ";
                    if (resultObj["status"] == 11)
                        TextBoxCompiler.Text += "Compilation Error\n";
                    if (resultObj["status"] == 12)
                        TextBoxCompiler.Text += "Runtime Error\n";
                    if (resultObj["status"] == 13)
                        TextBoxCompiler.Text += "Time Limit Exceeded\n";
                    if (resultObj["status"] == 14)
                        TextBoxCompiler.Text += "Wrong Answer\n";
                    if (resultObj["status"] == 15)
                        TextBoxCompiler.Text += "Success\n";
                    if (resultObj["status"] == 17)
                        TextBoxCompiler.Text += "Memory Limit Exceeded\n";
                    if (resultObj["status"] == 19)
                        TextBoxCompiler.Text += "Illegal System Call\n";
                    if (resultObj["status"] == 20 || resultObj["status"] == 21)
                        TextBoxCompiler.Text += "Internal Error\n";

                    Page.ClientScript.RegisterStartupScript(this.GetType(),"init", "g1.refresh("+resultObj["result_score"]+")", true);

                    SubmissionDataSource.SelectParameters.Clear(); //Select
                    SubmissionDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                    SubmissionDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                    DataSourceSelectArguments args = new DataSourceSelectArguments();
                    DataView dv = (DataView)SubmissionDataSource.Select(args);
                    if (dv.Table.Rows.Count == 1) //Update if exist
                    {
                        SubmissionDataSource.UpdateParameters.Clear();
                        SubmissionDataSource.UpdateParameters.Add("Score", resultObj["result_score"].ToString());
                        SubmissionDataSource.UpdateParameters.Add("SubmissionId", id);
                        SubmissionDataSource.UpdateParameters.Add("Question", Request.QueryString["p"]);
                        SubmissionDataSource.UpdateParameters.Add("Username", Membership.GetUser().UserName);
                        SubmissionDataSource.UpdateParameters.Add("Date", DateTime.Now.ToString());
                        SubmissionDataSource.Update();
                    }
                    else //Insert
                    {
                        SubmissionDataSource.InsertParameters.Clear();
                        SubmissionDataSource.InsertParameters.Add("Score", resultObj["result_score"].ToString());
                        SubmissionDataSource.InsertParameters.Add("SubmissionId", id);
                        SubmissionDataSource.InsertParameters.Add("Question", Request.QueryString["p"]);
                        SubmissionDataSource.InsertParameters.Add("Username", Membership.GetUser().UserName);
                        SubmissionDataSource.InsertParameters.Add("Date", DateTime.Now.ToString());
                        SubmissionDataSource.Insert();
                    }
                }
                else
                {
                    //TODO run compile test etc... delay
                }
            }
        }
}


