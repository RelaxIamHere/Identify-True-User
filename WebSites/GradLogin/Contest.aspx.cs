using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;

public partial class _Contest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void QButton_Click(object sender, EventArgs e)
    {
        bool skipSearchUserByQuestion = true;
        bool skipSearchUserByCategory = true;
        bool skipSearchUserByLanguage = true;
        SimilarQuestionsSource.SelectParameters.Clear();
        SimilarQuestionsSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
        DataView dv = (DataView)SimilarQuestionsSource.Select(new DataSourceSelectArguments());
        if (dv.Table.Rows.Count != 0)
        {
            int userCount = dv.Table.Rows.Count;
            for (int i = 0; i < userCount; i++)
            {
                QuestionSource.SelectParameters.Clear();
                QuestionSource.SelectParameters.Add("SimilarUser", dv.Table.Rows[i]["Username"].ToString());
                QuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                DataView dv2 = (DataView)QuestionSource.Select(new DataSourceSelectArguments());
                if (dv2.Table.Rows.Count != 0)
                {
                    skipSearchUserByQuestion = false;
                    Response.Redirect("Challange.aspx?p=" + dv2.Table.Rows[0]["Question"].ToString());
                    break;
                }
            }
        }
        if (skipSearchUserByQuestion)
        {
            SimilarCategorySource.SelectParameters.Clear();
            SimilarCategorySource.SelectParameters.Add("Username", Membership.GetUser().UserName);
            DataView dv3 = (DataView)SimilarCategorySource.Select(new DataSourceSelectArguments());
            if (dv3.Table.Rows.Count != 0)
            {
                int userCount = dv3.Table.Rows.Count;
                for (int i = 0; i < userCount; i++)
                {
                    QuestionSource.SelectParameters.Clear();
                    QuestionSource.SelectParameters.Add("SimilarUser", dv3.Table.Rows[i]["Username"].ToString());
                    QuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                    DataView dv4 = (DataView)QuestionSource.Select(new DataSourceSelectArguments());
                    if (dv4.Table.Rows.Count != 0)
                    {
                        skipSearchUserByCategory = false;
                        Response.Redirect("Challange.aspx?p=" + dv4.Table.Rows[0]["Question"].ToString());
                        break;
                    }
                }
            }
            if (skipSearchUserByCategory)
            {
                SimilarLanguageSource.SelectParameters.Clear();
                SimilarLanguageSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                DataView dv5 = (DataView)SimilarLanguageSource.Select(new DataSourceSelectArguments());
                if (dv5.Table.Rows.Count != 0)
                {
                    int userCount = dv5.Table.Rows.Count;
                    for (int i = 0; i < userCount; i++)
                    {
                        QuestionSource.SelectParameters.Clear();
                        QuestionSource.SelectParameters.Add("SimilarUser", dv5.Table.Rows[i]["Username"].ToString());
                        QuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                        DataView dv6 = (DataView)QuestionSource.Select(new DataSourceSelectArguments());
                        if (dv6.Table.Rows.Count != 0)
                        {
                            skipSearchUserByLanguage = false;
                            Response.Redirect("Challange.aspx?p=" + dv6.Table.Rows[0]["Question"].ToString());
                            break;
                        }
                    }
                }
                if (skipSearchUserByLanguage) 
                {
                    UnsolvedQuestionSource.SelectParameters.Clear();
                    UnsolvedQuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                    DataView dv7 = (DataView)UnsolvedQuestionSource.Select(new DataSourceSelectArguments());
                    if (dv7.Table.Rows.Count != 0)
                    {
                        Response.Redirect("Challange.aspx?p=" + dv7.Table.Rows[0]["Question"].ToString());
                    }
                    else
                    {
                        warn.InnerText = "Congratulations! Already you have solved all question.";
                    }
                }
            }
        }
    }
}
