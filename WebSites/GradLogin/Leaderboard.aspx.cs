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
            DataView dv = (DataView)MapDataSource.Select(new DataSourceSelectArguments());
            foreach (System.Data.DataRow row in dv.Table.Rows)
                dropdown.Items.Add(row["Category"].ToString());
            dropdown.SelectedIndex = 0;
        }
        LeaderDataSource.SelectParameters.Clear();
        LeaderDataSource.SelectParameters.Add("Category", dropdown.Value);
        DataView dvv = (DataView)LeaderDataSource.Select(new DataSourceSelectArguments());
        if (search.Value == "")
            Repeater1.DataSource = LeaderDataSource;
        else
        {
            DataTable source = dvv.Table.Clone();
            source.Rows.Clear();
            foreach (System.Data.DataRow row in dvv.Table.Rows)
                if (row["Username"].ToString().Contains(search.Value))
                    source.ImportRow(row);
            Repeater1.DataSource = source;
        }
        Repeater1.DataBind();

    }

}
