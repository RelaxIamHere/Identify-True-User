using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Web.Script.Serialization;

public partial class _Compiler : System.Web.UI.Page
{
        private string token = "e0934678943a8799bd349ae01d24bb9b";
        private WebClient client = new WebClient();
        private string response = "";
        public static List<string> languageId = new List<string>();
        public string output="";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DropDownLanguage.Attributes.Add("onchange", "fillSampleCode();");
                languageId.Clear();
                var jss = new JavaScriptSerializer();
                string url = "http://api.compilers.sphere-engine.com/api/v3/languages?access_token=" + token;
                response = client.DownloadString(url);
                var langObj = jss.Deserialize<Dictionary<string, string>>(response);
                foreach (KeyValuePair<string, string> language in langObj)
                {
                    DropDownLanguage.Items.Add(language.Value);
                    languageId.Add(language.Key);
                }
                DropDownLanguage.SelectedIndex = 7;
            }
            Page.ClientScript.RegisterStartupScript(this.GetType(), "init", "init(" + Convert.ToInt32(IsPostBack).ToString() + ")", true);
        }

        protected void ButtonCompile_Click(object sender, EventArgs e)
        {
            var jss = new JavaScriptSerializer();
            string url = "http://api.compilers.sphere-engine.com/api/v3/languages?access_token=" + token;
            if (languageId.Count == 0)
            {
                jss = new JavaScriptSerializer();
                response = client.DownloadString(url);
                var langObj = jss.Deserialize<Dictionary<string, string>>(response);
                foreach (KeyValuePair<string, string> language in langObj)
                    languageId.Add(language.Key);
            }
            
            url = "http://api.compilers.sphere-engine.com/api/v3/submissions?access_token=" + token;
            var input = jss.Serialize(TextBoxInput.Text);
            var code = jss.Serialize(TextBoxCode.Text);
            string jsonData = "{\"language\":" + languageId[DropDownLanguage.SelectedIndex] + ",\"sourceCode\":" + code + ",\"input\":" + input + "}";
            client.Headers.Add("Content-Type", "application/json");
            response = client.UploadString(url, "POST", jsonData);
            var idObj = jss.Deserialize<Dictionary<string, string>>(response);
            string id = idObj["id"];

            bool finished = false;
            while (!finished)
            {
                url = "http://api.compilers.sphere-engine.com/api/v3/submissions/" + id + "?withSource=1&withInput=1&withOutput=1&withStderr=1&withCmpinfo=1&access_token=" + token;
                response = client.DownloadString(url);
                var resultObj = jss.Deserialize<Dictionary<string, string>>(response);
                if (resultObj["status"] == "0")
                {
                    output = "";
                    finished = true;
                    compInfo.InnerHtml = "";
                    compInfo.InnerHtml = "<table aria-describedby=\"dataTables-example_info\" role=\"grid\""+
                                        "class=\"table table-responsive table-striped table-bordered table-hover dataTable no-footer dtr-inline\""+
                                        "width=\"100%\"><tbody>";
                    foreach (KeyValuePair<string, string> status in resultObj)
                    {
                        if (status.Key != "source" && status.Key != "public" && status.Key != "error"
                            && status.Key != "langId" && status.Key != "date" && status.Key != "status"
                            && status.Key != "input" && status.Key != "result" && status.Value != "" && status.Key != "output")
                            compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>"+status.Key+"</label></td><td>" + status.Value + "</td></tr>";

                        if (status.Key == "output" && status.Value!="")
                        {
                            output += "<h5><a href=\"#\"><label><i class=\"fa fa-gear fa-fw\"></i>Output </label></a></h5><div class=\"no-padding\" style=\"border:0;\">";
                            output += "<label>"+status.Value+"</label></div>";
                        }
                        if (status.Key == "result")
                        {
                            compInfo.InnerHtml += "<tr role=\"row\" class=\"gradeA odd\"><td><label>" + status.Key + "</label></td><td>";
                            if (status.Value == "11")
                                compInfo.InnerHtml += "Compilation Error";
                            if (status.Value == "12")
                                compInfo.InnerHtml += "Runtime Error";
                            if (status.Value == "13")
                                compInfo.InnerHtml += "Time Limit Exceeded";
                            if (status.Value == "15")
                                compInfo.InnerHtml += "Success";
                            if (status.Value == "17")
                                compInfo.InnerHtml += "Memory Limit Exceeded";
                            if (status.Value == "19")
                                compInfo.InnerHtml += "Illegal System Call";
                            if (status.Value == "20")
                                compInfo.InnerHtml += "Internal Error";

                            compInfo.InnerHtml +="</td></tr>";
                        }
                    }
                    compInfo.InnerHtml+="</tbody></table>";
                }
            }
        }
}


