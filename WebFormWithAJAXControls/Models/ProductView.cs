using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebFormWithAJAXControls.Models
{
    public class ProductView
    {
        public string ProductID { get; set; }
        public string ProductName { get; set; }
        public string CategoryID { get; set; }
        public int ViewCount { get; set; }  
    }
}