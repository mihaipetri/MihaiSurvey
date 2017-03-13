using Mihai.Survey.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;

namespace Mihai.Survey.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Survey()
        {
            try
            {
                var questions = DataAPI.GetQuestionsAndAnswers();
                return View(questions);
            }
            catch
            {
                return View();
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateSurvey()
        {
            try
            {
                var survey = new Mihai.Survey.Data.Survey()
                {
                    Name = Guid.NewGuid().ToString(),
                    UserId = User.Identity.IsAuthenticated ? User.Identity.Name : "Anonymous",
                    CreateDate = DateTime.UtcNow,
                    UpdateDate = DateTime.UtcNow
                };

                var questions = DataAPI.GetQuestions();
                foreach (var question in questions)
                {
                    BuildSurvey(survey, question);
                }

                DataAPI.SaveSurvey(survey);
            }
            catch(Exception e)
            {
                // log exception
            }

            return RedirectToAction("Index", "Home");
        }

        public ActionResult Reports()
        {
            ViewBag.TotalData = DataAPI.GetTotalReportData();
            ViewBag.ReportsData = JsonConvert.SerializeObject(DataAPI.GetReportsData());
            return View();
        }

        private void BuildSurvey(Data.Survey survey, Question question)
        {
            if (!string.IsNullOrWhiteSpace(Request.Form[question.Id.ToString()]))
            {
                switch (question.Type)
                {
                    case 0:
                    case 1:
                        var ans = new SurveyAnswer()
                        {
                            AnswerId = Convert.ToInt32(Request.Form[question.Id.ToString()])
                        };
                        survey.SurveyAnswers.Add(ans);
                        break;
                    case 2:
                        string[] values = Request.Form[question.Id.ToString()].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (var val in values)
                        {
                            var a = new SurveyAnswer()
                            {
                                AnswerId = Convert.ToInt32(val)
                            };
                            survey.SurveyAnswers.Add(a);
                        }
                        break;
                    case 3:
                        var comment = new SurveyComment()
                        {
                            QuestionId = question.Id,
                            Comments = Request.Form[question.Id.ToString()]
                        };
                        survey.SurveyComments.Add(comment);
                        break;
                }
            }
        }
    }
}