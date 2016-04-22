using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (string.IsNullOrEmpty(Request.QueryString["p"]))
            {
                DataView dv = (DataView)MapDataSource.Select(new DataSourceSelectArguments());
                foreach (System.Data.DataRow row in dv.Table.Rows)
                    dropdownCategory.Items.Add(row["Category"].ToString());
                dropdownCategory.SelectedIndex = 0;
                if (!string.IsNullOrEmpty(Request.QueryString["c"]))
                    dropdownCategory.SelectedIndex=dropdownCategory.Items.IndexOf(new ListItem(Request.QueryString["c"]));
            }
            else
            {
                CategoryDataSource.SelectParameters.Clear();
                CategoryDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
                DataView dv = (DataView)CategoryDataSource.Select(new DataSourceSelectArguments());
                if(dv.Table.Rows.Count>0)
                    labelCategory.InnerHtml = "Category: <a href='Leaderboard.aspx?c=" + dv.Table.Rows[0]["Category"] + "'>" + dv.Table.Rows[0]["Category"] + "</a> <br />Question: " + dv.Table.Rows[0]["QuestionName"];
                else
                    labelCategory.InnerHtml = "Question Not Found";
            }
        }

        LeaderDataSource.SelectParameters.Clear();
        if (string.IsNullOrEmpty(Request.QueryString["p"]))
            LeaderDataSource.SelectParameters.Add("Category", dropdownCategory.Value);
        else
        {
            LeaderDataSource.SelectCommand =
                "SELECT* FROM ( SELECT ROW_NUMBER() OVER( ORDER BY Submission.Score DESC) AS Rank, Submission.Username AS Username, Submission.Score AS Score " +
                        "FROM Map INNER JOIN Submission ON Map.Question = Submission.Question " +
                        "WHERE (Map.Question = @Question)) a " +
                    "WHERE a.Username LIKE @Username";
            LeaderDataSource.SelectParameters.Add("Question", Request.QueryString["p"]);
        }
        LeaderDataSource.SelectParameters.Add("Username", "%"+search.Value+"%");
        ListView1.DataSource = LeaderDataSource;
        ListView1.DataBind();

        string ctrlName = Page.Request.Params.Get("__EVENTTARGET");
        if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "dropdownSize")
            DataPager1.PageSize = Convert.ToInt32(dropdownSize.Value);

        int CurrentPage = ((DataPager1.StartRowIndex) / DataPager1.MaximumRows) + 1;
        recordCount.InnerHtml = "Showing " + (DataPager1.StartRowIndex+1) + " to " + (DataPager1.StartRowIndex + DataPager1.PageSize) + " of " + DataPager1.TotalRowCount + " entries";

    }
}
