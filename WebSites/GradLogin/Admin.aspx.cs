using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net;
using System.Web.Script.Serialization;
using System.IO;

public partial class _Admin : System.Web.UI.Page
{
    private string token = "a512ef00c67f5676ae277ffdb81eb4b8fb67ef70";
    private WebClient client = new WebClient();
    private string response = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        labelMessage.InnerText = "";
        if (!Page.IsPostBack)
        {
            checkboxCategory.Checked=true;
            DataView dv = (DataView)MapDataSource.Select(new DataSourceSelectArguments());
            foreach (System.Data.DataRow row in dv.Table.Rows)
                dropdownCategory.Items.Add(row["Category"].ToString());
            dropdownCategory.SelectedIndex = 0;
            textQcategory.Value=dropdownCategory.Value;
        }

        QuestionDataSource.SelectParameters.Clear();
        QuestionDataSource.SelectParameters.Add("Category", dropdownCategory.Value);
        QuestionDataSource.SelectParameters.Add("QuestionName", "%"+search.Value+"%");
        ListView1.DataSource = QuestionDataSource;
        ListView1.DataBind();

        string ctrlName = Page.Request.Params.Get("__EVENTTARGET");
        if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "dropdownSize")
            DataPager1.PageSize = Convert.ToInt32(dropdownSize.Value);
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "dropdownCategory" && checkboxCategory.Checked)
            textQcategory.Value = dropdownCategory.Value;
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "checkboxCategory")
        {
            if (checkboxCategory.Checked)
            {
                textQcategory.Disabled = true;
                textQcategory.Value = dropdownCategory.Value;
            }
            else
            {
                textQcategory.Disabled = false;
                textQcategory.Value = "";
            }
        }
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "buttonCreate")
        {
            if (textQcategory.Value != "" && textQcode.Value != "" && textQname.Value != "")
                labelMessage.InnerText = createQuestion();
            else
                labelMessage.InnerText = "Invalid or missing fields";
        }
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "delete")
        {
            string question = Request["__EVENTARGUMENT"];
            QuestionDataSource.DeleteParameters.Clear();
            QuestionDataSource.DeleteParameters.Add("Question",question);
            QuestionDataSource.Delete();
            if (DataPager1.TotalRowCount == 1)
                dropdownCategory.Items.RemoveAt(dropdownCategory.SelectedIndex);
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "DoPostBack", "__doPostBack('dropdownCategory','')", true);
        }

        int CurrentPage = ((DataPager1.StartRowIndex) / DataPager1.MaximumRows) + 1;
        recordCount.InnerHtml = "Showing " + (DataPager1.StartRowIndex+1) + " to " + (DataPager1.StartRowIndex + DataPager1.PageSize) + " of " + DataPager1.TotalRowCount + " entries";
    }

    private string createQuestion()
    {
        var jss = new JavaScriptSerializer();
        string url = "http://2d73b8c2.problems.sphere-engine.com/api/v3/problems?access_token=" + token;
        string jsonData = "{\"code\":\""+textQcode.Value+ "\",\"name\":\""+textQname.Value+"\"}";
        client.Headers.Add("Content-Type", "application/json");
        try
        {
            response = client.UploadString(url, "POST", jsonData);
            QuestionDataSource.InsertParameters.Clear();
            QuestionDataSource.InsertParameters.Add("Category", textQcategory.Value);
            QuestionDataSource.InsertParameters.Add("Question",textQcode.Value);
            QuestionDataSource.InsertParameters.Add("QuestionName",textQname.Value);
            QuestionDataSource.Insert();
            if (!checkboxCategory.Checked)
            {
                DataView dv = (DataView)MapDataSource.Select(new DataSourceSelectArguments());
                dropdownCategory.Items.Clear();
                foreach (System.Data.DataRow row in dv.Table.Rows)
                    dropdownCategory.Items.Add(row["Category"].ToString());
                dropdownCategory.SelectedIndex = dropdownCategory.Items.IndexOf(new ListItem(textQcategory.Value));
                checkboxCategory.Checked = true;
                textQcategory.Disabled = true;
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "DoPostBack", "__doPostBack('dropdownCategory','')", true);
            }
            ListView1.DataBind();
            return "";
        }
        catch (WebException ex)
        {
            using (WebResponse response = ex.Response)
            {
                using (Stream data = response.GetResponseStream())
                {
                    StreamReader sr = new StreamReader(data);
                    var resultObj = jss.Deserialize<Dictionary<string, dynamic>>(sr.ReadToEnd());
                    return resultObj["message"];
                }
            }
        }
    }

    
}
