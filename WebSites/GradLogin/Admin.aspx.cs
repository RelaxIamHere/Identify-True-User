using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class _Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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
        else if (!String.IsNullOrEmpty(ctrlName) && ctrlName == "dropdownCategory" && !checkboxCategory.Checked)
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
            {
                /*TODO 
                 *  CALL API
                 *  if (succes)
                 *      CALL SQL
                 *  return result
                 *  if(result=succes)
                 *      select category from dropdown (postback may required or refresh for category)
                 */

                labelMessage.InnerText = "result";
            }
            else
                labelMessage.InnerText = "Invalid or missing fields";

        }

        int CurrentPage = ((DataPager1.StartRowIndex) / DataPager1.MaximumRows) + 1;
        recordCount.InnerHtml = "Showing " + (DataPager1.StartRowIndex+1) + " to " + (DataPager1.StartRowIndex + DataPager1.PageSize) + " of " + DataPager1.TotalRowCount + " entries";
    }
}
