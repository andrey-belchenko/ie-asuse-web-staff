using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using FastReport.Web;
using Microsoft.AspNetCore.Hosting;

namespace FRCoreVue.Controllers
{
    [Route("api/[controller]")]
    public class SampleDataController : Controller
    {
        private IHostingEnvironment _env;

        public SampleDataController(IHostingEnvironment env)
        {
            _env = env;
        }

        [HttpGet("[action]")]
        public IActionResult DisplayReport(string name)
        {
            var webRoot = _env.WebRootPath;
            WebReport WebReport = new WebReport();
            WebReport.Width = "1000";
            WebReport.Height = "1000";
            //WebReport.Report.Load(System.IO.Path.Combine(webRoot, (String.Format("App_Data/my_table1.frx", name)))); // Load the report into the WebReport object
            //System.Data.DataSet dataSet = new System.Data.DataSet(); // Create a data source
            //dataSet.ReadXml(System.IO.Path.Combine(webRoot, "App_Data/nwind.xml")); // Open the xml database
            WebReport.Report.Load(System.IO.Path.Combine(webRoot, "App_Data/my_table2.frx"));
            var dataTable = new System.Data.DataTable();
            dataTable.Columns.Add("value", typeof(int));
            dataTable.Rows.Add(5);
            dataTable.Rows.Add(6);
            dataTable.Rows.Add(7);
            dataTable.TableName = "my_table";
            var dataSet = new System.Data.DataSet();
            dataSet.Tables.Add(dataTable);
            WebReport.Report.RegisterData(dataTable,"my_table");
            ViewBag.WebReport = WebReport; // pass the report to View
            return View("index");
        }
    }
}