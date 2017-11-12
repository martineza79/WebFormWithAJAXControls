using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebFormWithAJAXControls.Models
{
    public class ProductViewList
    {
        private List<ProductView> list = new List<ProductView>();

        public void Add(ProductView newView)
        {
            System.Threading.Thread.Sleep(2000);
            string id = newView.ProductID;
            ProductView view = (from p in list
                                where p.ProductID == id
                                select p).SingleOrDefault();

            if (view == null)
                list.Add(newView);

            else
                view.ViewCount += 1;
        }

        public List<ProductView> Display()
        {
            return (from p in list
                    orderby p.ViewCount descending,
                    p.ProductName
                    select p).ToList();
        }
    }
}