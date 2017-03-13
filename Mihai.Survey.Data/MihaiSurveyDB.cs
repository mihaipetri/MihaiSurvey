using System;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace Mihai.Survey.Data
{
    public partial class MihaiSurveyDB : DbContext
    {
        public MihaiSurveyDB()
            : base("name=MihaiSurveyDB")
        {
        }

        public virtual DbSet<Answer> Answers { get; set; }
        public virtual DbSet<AnswerStatu> AnswerStatus { get; set; }
        public virtual DbSet<Question> Questions { get; set; }
        public virtual DbSet<QuestionStatu> QuestionStatus { get; set; }
        public virtual DbSet<QuestionType> QuestionTypes { get; set; }
        public virtual DbSet<SurveyAnswer> SurveyAnswers { get; set; }
        public virtual DbSet<SurveyComment> SurveyComments { get; set; }
        public virtual DbSet<Survey> Surveys { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Answer>()
                .HasMany(e => e.SurveyAnswers)
                .WithRequired(e => e.Answer)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<AnswerStatu>()
                .HasMany(e => e.Answers)
                .WithRequired(e => e.AnswerStatu)
                .HasForeignKey(e => e.Status)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Question>()
                .HasMany(e => e.Answers)
                .WithRequired(e => e.Question)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Question>()
                .HasMany(e => e.SurveyComments)
                .WithRequired(e => e.Question)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<QuestionStatu>()
                .HasMany(e => e.Questions)
                .WithRequired(e => e.QuestionStatu)
                .HasForeignKey(e => e.Status)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<QuestionType>()
                .HasMany(e => e.Questions)
                .WithRequired(e => e.QuestionType)
                .HasForeignKey(e => e.Type)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Survey>()
                .HasMany(e => e.SurveyAnswers)
                .WithRequired(e => e.Survey)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Survey>()
                .HasMany(e => e.SurveyComments)
                .WithRequired(e => e.Survey)
                .WillCascadeOnDelete(false);
        }
    }
}
