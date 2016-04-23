using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

public partial class _Category : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (string.IsNullOrEmpty(Request.QueryString["c"]))
                Response.Redirect("Default.aspx");

            DataSourceSelectArguments args  =new DataSourceSelectArguments();
            MapDataSource.SelectParameters.Add("Category", Request.QueryString["c"]);
            DataView dvMap = (DataView)MapDataSource.Select(args);
            
            DataView dvSubmission;
            string score;

            foreach (System.Data.DataRow row in dvMap.Table.Rows)
            {
                SubmissionSource.SelectParameters.Clear();
                SubmissionSource.SelectParameters.Add("Question", row["Question"].ToString());
                SubmissionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                dvSubmission = (DataView)SubmissionSource.Select(args);
                score = "";
                if (dvSubmission.Table.Rows.Count > 0)
                    score = "Score: "+dvSubmission.Table.Rows[0]["Score"].ToString()+"/100";
                populate.InnerHtml +=
                    "<div class=\"col-lg-4\">" +
                    "<div class=\"panel panel-primary\">" +
                        "<div class=\"panel-heading\">" +
                            row["QuestionName"].ToString() +
                        "</div>" +
                        "<div class=\"panel-body\">" +
                           "<button onclick=\"location.href=\'Challange.aspx?p=" + row["Question"].ToString() + "'\" type=\"button\" class=\"btn btn-primary\" style=\"float:right;\">Go to Question</button>" +
                            "<h5 style=\"font-weight:bold\">" + score + "</h5>" +                        
                           "</div>" +
                        "<div class=\"panel-footer\" style=\"overflow:hidden;\">" +
                            "<button onclick=\"location.href=\'Leaderboard.aspx?p=" + row["Question"].ToString() + "'\" type=\"button\" class=\"btn btn-outline btn-primary\">Leaderboard</button>" + 
                        "</div>" +
                    "</div>" +
                "</div>";
            }
        }
    }
}
