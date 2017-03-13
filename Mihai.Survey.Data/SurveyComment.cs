using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class SurveyComment
    {
        public int Id { get; set; }

        public int SurveyId { get; set; }

        public int QuestionId { get; set; }

        [StringLength(1024)]
        public string Comments { get; set; }

        public virtual Question Question { get; set; }

        public virtual Survey Survey { get; set; }
    }
}
