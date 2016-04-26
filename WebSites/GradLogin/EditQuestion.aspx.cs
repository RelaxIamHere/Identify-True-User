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
using System.IO;
using System.Web.UI.HtmlControls;

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
                qName.Value = problemObj["name"];
                var doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(problemObj["body"]);
                var paragraphs = doc.DocumentNode.Descendants("p");
                HtmlTextArea[] textList={qText1,qText2,qText3,qText4,qText5};
                int index=0;
                foreach (var node in paragraphs)
                    textList[index++].Value = node.InnerHtml;

                url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] + "/testcases?access_token=" + token;
                response = client.DownloadString(url);
                var testcaseObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
                foreach (var testcase in testcaseObj["testcases"])
                    index = 1;
            }

            string ctrlName = Page.Request.Params.Get("__EVENTTARGET");
            if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "buttonUpdate")
            {
                var jss = new JavaScriptSerializer();
                string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] + "?access_token=" + token;
                string body =
            "<p>" + qText1.Value.Replace("<p>","").Replace("</p>","") + "</p>" +
            "<h4>Input</h4>" +
            "<p>" + qText2.Value.Replace("<p>", "").Replace("</p>", "") + "</p>" +
            "<h4>Output</h4>" +
            "<p>" + qText3.Value.Replace("<p>", "").Replace("</p>", "") + "</p>" +
            "<h4>Example</h4>" +
            "<pre>" +
            "<strong>Input:</strong>" +
            "<p>" + qText4.Value.Replace("<p>", "").Replace("</p>", "") + "</p>" +
            "<strong>Output:</strong>" +
            "<p>" + qText5.Value.Replace("<p>", "").Replace("</p>", "") + "</p>" +
            "</pre>";

                string jsonData = "{\"name\":\"" + qName.Value + "\",\"body\":"+jss.Serialize(body)+"}";
                client.Headers.Add("Content-Type", "application/json");
                try
                {
                    response = client.UploadString(url, "PUT", jsonData);
                    MapDataSource.UpdateParameters.Clear();
                    MapDataSource.UpdateParameters.Add("QuestionName",qName.Value);
                    MapDataSource.UpdateParameters.Add("Question", Request.QueryString["p"]);
                    MapDataSource.Update();
                    Response.Redirect(Request.Url.ToString());
                }
                catch (WebException ex)
                {
                    using (WebResponse response = ex.Response)
                    {
                        using (Stream data = response.GetResponseStream())
                        {
                            StreamReader sr = new StreamReader(data);
                            var resultObj = jss.Deserialize<Dictionary<string, dynamic>>(sr.ReadToEnd());
                            labelResult.Visible = true;
                            labelResult.InnerText = resultObj["message"];
                        }
                    }
                }
            }
        }
}


