using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class Answer
    {
        public Answer()
        {
            SurveyAnswers = new HashSet<SurveyAnswer>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        public int QuestionId { get; set; }

        [Required]
        [StringLength(256)]
        public string Name { get; set; }

        public int DisplayOrder { get; set; }

        public short Status { get; set; }

        public DateTime CreateDate { get; set; }

        public DateTime UpdateDate { get; set; }

        public virtual AnswerStatu AnswerStatu { get; set; }

        public virtual Question Question { get; set; }

        public virtual ICollection<SurveyAnswer> SurveyAnswers { get; set; }
    }
}
