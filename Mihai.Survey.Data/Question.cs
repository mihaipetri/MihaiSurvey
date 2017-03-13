using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class Question
    {
        public Question()
        {
            Answers = new HashSet<Answer>();
            SurveyComments = new HashSet<SurveyComment>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        [Required]
        [StringLength(256)]
        public string Name { get; set; }

        public int DisplayOrder { get; set; }

        public short Status { get; set; }

        public short Type { get; set; }

        public DateTime CreateDate { get; set; }

        public DateTime UpdateDate { get; set; }

        public virtual ICollection<Answer> Answers { get; set; }

        public virtual QuestionStatu QuestionStatu { get; set; }

        public virtual QuestionType QuestionType { get; set; }

        public virtual ICollection<SurveyComment> SurveyComments { get; set; }
    }
}
