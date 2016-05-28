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
        SimilarQuestionsSource.SelectParameters.Clear();
        SimilarQuestionsSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
        DataView dv = (DataView)SimilarQuestionsSource.Select(new DataSourceSelectArguments());
        if (dv.Table.Rows[0]["Username"] != null)
        {
            QuestionSource.SelectParameters.Clear();
            QuestionSource.SelectParameters.Add("SimilarUser", dv.Table.Rows[0]["Username"].ToString());
            QuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
            DataView dv2 = (DataView)QuestionSource.Select(new DataSourceSelectArguments());
            if (dv2.Table.Rows[0]["Question"] != null)
            {
                Response.Redirect("Challange.aspx?p=" + dv2.Table.Rows[0]["Question"].ToString());
            }
        }
        else
        {
            SimilarCategorySource.SelectParameters.Clear();
            SimilarCategorySource.SelectParameters.Add("Username", Membership.GetUser().UserName);
            DataView dv3 = (DataView)SimilarCategorySource.Select(new DataSourceSelectArguments());
            if (dv3.Table.Rows[0]["Username"] != null)
            {
                QuestionSource.SelectParameters.Clear();
                QuestionSource.SelectParameters.Add("SimilarUser", dv3.Table.Rows[0]["Username"].ToString());
                QuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                DataView dv4 = (DataView)QuestionSource.Select(new DataSourceSelectArguments());
                if (dv4.Table.Rows[0]["Question"] != null)
                {
                    Response.Redirect("Challange.aspx?p=" + dv4.Table.Rows[0]["Question"].ToString());
                }
            }
            else
            {
                SimilarLanguageSource.SelectParameters.Clear();
                SimilarLanguageSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                DataView dv5 = (DataView)SimilarLanguageSource.Select(new DataSourceSelectArguments());
                if (dv5.Table.Rows[0]["Username"] != null)
                {
                    QuestionSource.SelectParameters.Clear();
                    QuestionSource.SelectParameters.Add("SimilarUser", dv5.Table.Rows[0]["Username"].ToString());
                    QuestionSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
                    DataView dv6 = (DataView)QuestionSource.Select(new DataSourceSelectArguments());
                    if (dv6.Table.Rows[0]["Question"] != null)
                    {
                        Response.Redirect("Challange.aspx?p="+dv6.Table.Rows[0]["Question"].ToString());
                    }
                }
            }
        }
    }
}
