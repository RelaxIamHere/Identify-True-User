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
                string theme = "danger";
                score = "";
                int value=0;
                if (dvSubmission.Table.Rows.Count > 0)
                {
                    score = "Score: "+dvSubmission.Table.Rows[0]["Score"].ToString()+"/100";
                    value = Convert.ToInt32(dvSubmission.Table.Rows[0]["Score"]);
                    if (value == 100)
                        theme = "success";
                    else if (value >= 50)
                        theme = "info";
                    else
                        theme = "warning";
                }
                populate.InnerHtml +=
                    "<div class=\"col-lg-4\">" +
                    "<div class=\"panel panel-"+theme+"\">" +
                        "<div class=\"panel-heading\"><label>" +
                            row["QuestionName"].ToString() +
                        "</label></div>" +
                        "<div class=\"panel-body\">" +
                           "<div class=\"progress progress-striped active\">"+
                                "<div class=\"progress-bar progress-bar-" + theme + "\" role=\"progressbar\" aria-valuenow=\"" + value + "\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width:" + value + "%\">" +
                                    "<span class=\"sr-only\"><span>"+score+"</span>% Complete (success)</span>"+
                                "</div>"+
                            "</div>"+

                           "<button onclick=\"location.href=\'Challange.aspx?p=" + row["Question"].ToString() + "'\" type=\"button\" class=\"btn btn-" + theme + "\" style=\"float:right;\">Go to Question</button>" +
                           "<h5 style=\"font-weight:bold\">" + score + "</h5>" +
                           "</div>" +
                        "<div class=\"panel-footer\" style=\"overflow:hidden;\">" +
                            "<button onclick=\"location.href=\'Leaderboard.aspx?p=" + row["Question"].ToString() + "'\" type=\"button\" class=\"btn btn-outline btn-"+theme+"\">Leaderboard</button>" + 
                        "</div>" +
                    "</div>" +
                "</div>";
                /*
                 * */
            }
        }
    }
}
