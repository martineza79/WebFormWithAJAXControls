using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebFormWithAJAXControls.Models;

namespace WebFormWithAJAXControls
{
    public partial class ProductView : System.Web.UI.Page
    {
        private const string APP_KEY = "viewlist";

        protected void Page_Load(object sender, EventArgs e)
        {
            ProductViewList viewlist;

            if(Application[APP_KEY] == null)
            {
                viewlist = new ProductViewList();
                Application.Add(APP_KEY, viewlist);
            }

            else
            {
                viewlist = (ProductViewList)Application[APP_KEY];
                BindViewGrid(viewlist.Display());
            }
        }

        protected void grdProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            Models.ProductView view = new Models.ProductView();
            view.ProductID = grdProducts.SelectedValue.ToString();
            view.ProductName = grdProducts.SelectedRow.Cells[2].Text;
            view.CategoryID = ddlCategory.SelectedValue.ToString();
            view.ViewCount = 1;

            Application.Lock();
            ProductViewList viewlist = (ProductViewList)Application[APP_KEY];
            viewlist.Add(view);

            BindViewGrid(viewlist.Display());
        }

        protected void Reset(object sender, EventArgs e)
        {
            grdProducts.SelectedIndex = -1;
        }

        private void BindViewGrid(List<Models.ProductView> views)
        {
            grdViews.DataSource = views;
            grdViews.DataBind();
        }

        protected void GridView_PreRender(object sender, EventArgs e)
        {
            grdProducts.HeaderRow.TableSection = TableRowSection.TableHeader;

            if (grdViews.HeaderRow != null)
                grdViews.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}