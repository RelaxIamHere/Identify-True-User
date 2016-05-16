using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;

public partial class _ChangePassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ContactDataSource.SelectParameters.Clear();
            ContactDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
            System.Data.DataView dv = (System.Data.DataView)ContactDataSource.Select(new DataSourceSelectArguments());
            foreach (System.Data.DataRow line in dv.Table.Rows)
            {
                name.Value = line["Name"].ToString();
                DateTime dt = (DateTime)line["Birthday"];
                birthday.Text = dt.ToString("yyyy-MM-dd");
                phone.Text = line["Phone"].ToString();
                mail.Text = line["Mail"].ToString();
                website.Text = line["Website"].ToString();
                country.Value = line["Country"].ToString();
                city.Value = line["City"].ToString();
                company.Value = line["Company"].ToString();
                school.Value = line["School"].ToString();
            }
        }
    }
    protected void ContactButton_Click(object sender, EventArgs e)
    {
        ContactDataSource.SelectParameters.Clear(); //Select
        ContactDataSource.SelectParameters.Add("Username", Membership.GetUser().UserName);
        DataSourceSelectArguments args = new DataSourceSelectArguments();
        DataView dv = (DataView)ContactDataSource.Select(args);
        if (dv.Table.Rows.Count == 1) //Update if exist
        {
            ContactDataSource.UpdateParameters.Clear();
            ContactDataSource.UpdateParameters.Add("Name", name.Value);
            ContactDataSource.UpdateParameters.Add("Birthday", birthday.Text);
            ContactDataSource.UpdateParameters.Add("Phone", phone.Text);
            ContactDataSource.UpdateParameters.Add("Mail", mail.Text);
            ContactDataSource.UpdateParameters.Add("Website", website.Text);
            ContactDataSource.UpdateParameters.Add("Country", country.Value);
            ContactDataSource.UpdateParameters.Add("City", city.Value);
            ContactDataSource.UpdateParameters.Add("Company", company.Value);
            ContactDataSource.UpdateParameters.Add("School", school.Value);
            ContactDataSource.UpdateParameters.Add("Username", Membership.GetUser().UserName);
            ContactDataSource.Update();
        }
        else //Insert
        {
            ContactDataSource.InsertParameters.Clear();
            ContactDataSource.InsertParameters.Add("Username", Membership.GetUser().UserName);
            ContactDataSource.InsertParameters.Add("Name", name.Value);
            ContactDataSource.InsertParameters.Add("Birthday", birthday.Text);
            ContactDataSource.InsertParameters.Add("Phone", phone.Text);
            ContactDataSource.InsertParameters.Add("Mail", mail.Text);
            ContactDataSource.InsertParameters.Add("Website", website.Text);
            ContactDataSource.InsertParameters.Add("Country", country.Value);
            ContactDataSource.InsertParameters.Add("City", city.Value);
            ContactDataSource.InsertParameters.Add("Company", company.Value);
            ContactDataSource.InsertParameters.Add("School", school.Value);
            ContactDataSource.Insert();
        }
    }
}
