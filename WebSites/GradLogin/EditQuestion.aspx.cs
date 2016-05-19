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
    private string token = "a512ef00c67f5676ae277ffdb81eb4b8fb67ef70";
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
            table.InnerHtml="";
            foreach (var testcase in testcaseObj["testcases"])
            {
                table.InnerHtml+=
                "<tr role=\"row\" class=\"gradeA odd\">"+
                    "<td class=\"sorting_1\">"+
                        testcase["number"]+
                    "</td>"+
                    "<td>"+
                    "<center><input type=\"checkbox\" " + (testcase["active"] == true ? "checked=\"checked\"" : "") + " runat=\"server\" onchange=\"javascript:updateActive()\"> </center> " +
                    "</td>"+
                    "<td>"+
                        testcase["limits"]["time"]+" Second"+
                    "</td>"+
                    "<td>"+
                        "<span><a class=\"btn btn-primary btn-block btn-outline\" href=\"javascript:__doPostBack('buttonTestEdit','" + testcase["number"] + "')\"><i class=\"fa fa-pencil-square-o\"></i></a></span>" +
                    "</td>"+
                "</tr>";
            }
        }

        string ctrlName = Page.Request.Params.Get("__EVENTTARGET");
        if (!String.IsNullOrEmpty(ctrlName) && (ctrlName == "buttonUpdate" || ctrlName == "checkChange" ))
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

            string activeString="";
            string [] activeList=Request.Cookies["activeTest"].Value.Split(',');
            foreach(string item in activeList)
                activeString += item+",";
            if (activeString.Substring(activeString.Length - 1,1) == ",")
                activeString = activeString.Substring(0, activeString.Length - 1);

            string jsonData = "{\"name\":\"" + qName.Value + "\" , \"activeTestcases\":\"" + activeString + "\" ,\"body\":" + jss.Serialize(body) + " }";

            client.Headers.Add("Content-Type", "application/json");
            try
            {
                response = client.UploadString(url, "PUT", jsonData);
                MapDataSource.UpdateParameters.Clear();
                MapDataSource.UpdateParameters.Add("QuestionName",qName.Value);
                MapDataSource.UpdateParameters.Add("Question", Request.QueryString["p"]);
                MapDataSource.Update();
                Response.Redirect(Request.RawUrl);
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
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "buttonCreate")
        {
            var jss = new JavaScriptSerializer();
            string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] + "/testcases?access_token=" + token;
            client.Headers.Add("Content-Type", "application/json");
            response = client.UploadString(url, "POST");
            var numberObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
            table.InnerHtml +=
                "<tr role=\"row\" class=\"gradeA odd\">" +
                    "<td class=\"sorting_1\">" +
                        numberObj["number"] +
                    "</td>" +
                    "<td>" +
                    "<center><input type=\"checkbox\" runat=\"server\" checked=\"checked\" onchange=\"javascript:javascript:updateActive()\"></center>" +
                    "</td>" +
                    "<td>" +
                    "1 Second" +
                    "</td>" +
                    "<td>" +
                        "<span><a class=\"btn btn-primary btn-block btn-outline\" href=\"javascript:__doPostBack('buttonTestEdit','" + numberObj["number"] + "')\"><i class=\"fa fa-pencil-square-o\"></i></a></span>" +
                    "</td>" +
                "</tr>";
        }
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "buttonTestEdit")
        {
            var jss = new JavaScriptSerializer();
            string testId=Page.Request.Params.Get("__EVENTARGUMENT");
                
            string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] + "/testcases/" + testId + "?access_token=" + token;
            response = client.DownloadString(url);
            var testcaseObj = jss.Deserialize<Dictionary<string, dynamic>>(response);
            editTime.Value = testcaseObj["limits"]["time"];

            editInput.Value = client.DownloadString(testcaseObj["input"]["url"] + "?access_token=" + token);
            editOutput.Value = client.DownloadString(testcaseObj["output"]["url"] + "?access_token=" + token);
               
            labelIdTestcase.InnerText = " Test Case " + testId;
            divTestcase.Visible = true;
        }
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "buttonApiUpdate")
        {
            var jss = new JavaScriptSerializer();
            string testId = labelIdTestcase.InnerText.Split(' ')[3];
            string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems/" + Request.QueryString["p"] + "/testcases/" + testId + "?access_token=" + token;
            client.Headers.Add("Content-Type", "application/json");
            string jsonData = "{\"input\":" + jss.Serialize(editInput.InnerText) + ",\"output\":" + jss.Serialize(editOutput.InnerText) + ",\"timelimit\":" + jss.Serialize(editTime.Value) + "}";
            try
            {
                response = client.UploadString(url, "PUT", jsonData);
                Response.Redirect(Request.RawUrl);
            }
            catch (WebException ex)
            {
                using (WebResponse response = ex.Response)
                {
                    using (Stream data = response.GetResponseStream())
                    {
                        StreamReader sr = new StreamReader(data);
                        var resultObj = jss.Deserialize<Dictionary<string, dynamic>>(sr.ReadToEnd());
                        labelUpdate.Visible = true;
                        labelUpdate.InnerText = resultObj["message"];
                    }
                }
            }
        }
    }
}