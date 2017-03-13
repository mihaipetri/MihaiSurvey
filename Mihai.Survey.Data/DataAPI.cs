using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mihai.Survey.Data
{
    public class DataAPI
    {
        public static IEnumerable<Question> GetQuestions()
        {
            try
            {
                using (MihaiSurveyDB db = new MihaiSurveyDB())
                {
                    return db.Questions.AsNoTracking()
                        .Where(q => q.Status == 1)
                        .OrderBy(q => q.DisplayOrder)
                        .ToList();
                }
            }
            catch (Exception e)
            {
                // log exception
                throw;
            }
        }

        public static Survey SaveSurvey(Survey survey)
        {
            try
            {
                using (MihaiSurveyDB db = new MihaiSurveyDB())
                {
                    db.Surveys.Add(survey);
                    db.SaveChanges();
                }
            }
            catch (Exception e)
            {
                // log exception
                throw;
            }

            return survey;
        }

        public static IEnumerable<Question> GetQuestionsAndAnswers()
        {
            try
            {
                using (MihaiSurveyDB db = new MihaiSurveyDB())
                {
                    return db.Questions.Include("Answers").AsNoTracking()
                        .Where(q => q.Status == 1)
                        .OrderBy(q => q.DisplayOrder)
                        .ToList();
                }
            }
            catch (Exception e)
            {
                // log exception
                throw;
            }
        }
        
        public static string GetTotalReportData()
        {
            StringBuilder totalData = new StringBuilder("[['Total Surveys',");

            try
            {
                using (MihaiSurveyDB db = new MihaiSurveyDB())
                {
                    totalData.Append(db.Surveys.Count().ToString() + "]");

                    var questions = (from sa in db.SurveyAnswers
                                     join a in db.Answers on sa.AnswerId equals a.Id
                                     join q in db.Questions on a.QuestionId equals q.Id
                                     group sa by new { q.Name, q.DisplayOrder } into g
                                     orderby g.Key.DisplayOrder
                                     select new
                                     {
                                         QuestionName = g.Key.Name,
                                         AnswersCount = g.Count()
                                     }).ToList();

                    foreach(var q in questions)
                    {
                        totalData.Append(string.Format(",['{0}',{1}]", q.QuestionName, q.AnswersCount));
                    }

                    totalData.Append("]");
                }
            }
            catch (Exception e)
            {
                // log exception
                throw;
            }

            return totalData.ToString(); 
        }

        public static IEnumerable GetReportsData()
        {
            try
            {
                using (MihaiSurveyDB db = new MihaiSurveyDB())
                {
                    return db.Questions.AsNoTracking()
                        .Where(q => q.Status == 1)
                        .OrderBy(q => q.DisplayOrder)
                        .Select(q => new
                        {
                            QuestionId = q.Id,
                            QuestionName = q.Name,
                            QuestionType = q.Type,
                            Answers = q.Answers
                                    .Where(a => a.Status == 1)
                                    .Select(a => new
                                    {
                                        label = a.Name,
                                        data = a.SurveyAnswers.Count
                                    }),
                            CommentsCount = q.SurveyComments.Count
                        })
                        .ToList();
                }
            }
            catch (Exception e)
            {
                // log exception
                throw;
            }
        }
    }
}
