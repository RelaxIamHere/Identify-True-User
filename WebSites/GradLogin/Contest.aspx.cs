using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Web.Script.Serialization;

public partial class _Contest : System.Web.UI.Page
{
        private string token = "79a33a949a690966cbe4b9d6fe226356";
        private WebClient client = new WebClient();
        private string response = "";
        public static List<string> languageId;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DropDownLanguage.Attributes.Add("onchange", "fillSampleCode();");
                languageId = new List<string>();
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
            string url = "http://api.compilers.sphere-engine.com/api/v3/submissions?access_token=" + token;
            string code = TextBoxCode.Text;
            var json = jss.Serialize(code);
            string jsonData = "{\"language\":" + languageId[DropDownLanguage.SelectedIndex] + ",\"sourceCode\":" + json + ",\"input\":\"4 5\\r\"}";
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
                    finished = true;
                    TextBoxCompiler.Text = "";
                    foreach (KeyValuePair<string, string> status in resultObj)
                    {
                        if (status.Key != "source" && status.Key != "public" && status.Key != "error"
                            && status.Key != "langId" && status.Key != "date" && status.Key != "status"
                            && status.Key != "input" && status.Key != "result" && status.Value != "" && status.Key != "output")
                            TextBoxCompiler.Text += status.Key + ": " + status.Value + "\n";
                        if (status.Key == "output")
                            TextBoxOutput.Text =status.Value;
                        if (status.Key == "result")
                        {
                            TextBoxCompiler.Text += status.Key + ": ";
                            if(status.Value=="11")
                                TextBoxCompiler.Text += "Compilation Error\n";
                            if (status.Value == "12")
                                TextBoxCompiler.Text += "Runtime Error\n";
                            if (status.Value == "13")
                                TextBoxCompiler.Text += "Time Limit Exceeded\n";
                            if (status.Value == "15")
                                TextBoxCompiler.Text += "Success\n";
                            if (status.Value == "17")
                                TextBoxCompiler.Text += "Memory Limit Exceeded\n";
                            if (status.Value == "19")
                                TextBoxCompiler.Text += "Illegal System Call\n";
                            if (status.Value == "20")
                                TextBoxCompiler.Text += "Internal Error\n";
                        }
                    }
                }
            }
        }
}


