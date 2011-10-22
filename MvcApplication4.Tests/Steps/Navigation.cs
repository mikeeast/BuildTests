using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using CassiniDev;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.IE;
using OpenQA.Selenium.Remote;
using Should.Fluent;
using TechTalk.SpecFlow;

namespace MvcApplication4.Tests.Steps
{
    [Binding]
    public class Navigation
    {
        static readonly CassiniDev.CassiniDevServer webServer = new CassiniDevServer();
        static IWebDriver driver;

        [BeforeTestRun]
        public static void BeforeTestRun()
        {
            string applicationPath = Path.GetFullPath(@"_PublishedWebsites\MvcApplication4");
            if (!Directory.Exists(applicationPath))
                applicationPath = Path.GetFullPath(@"..\..\..\MvcApplication4");

            Console.WriteLine(applicationPath);

            webServer.StartServer(Path.GetFullPath(applicationPath));
            driver = new FirefoxDriver();
        }

        [AfterTestRun]
        public static void AfterTestRun()
        {
            driver.Quit();
            webServer.StopServer();
        }

        [When(@"navigating to (.*)")]
        public void WhenNavigateTo(string uri)
        {
            driver.Navigate().GoToUrl(webServer.NormalizeUrl(uri));
        }

        [Then(@"the page title should be (.*)")]
        public void ThenThePageShouldContainTheTextHomepage(string text)
        {
            driver.Title.Should().Equal(text);
        }

        [Given(@"that I am on the Home Page")]
        public void GivenThatIAmOnTheHomePage()
        {
            driver.Navigate().GoToUrl(webServer.NormalizeUrl("/"));
        }
    }
}
