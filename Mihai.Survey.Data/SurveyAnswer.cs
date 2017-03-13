using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class SurveyAnswer
    {
        public int Id { get; set; }

        public int SurveyId { get; set; }

        public int AnswerId { get; set; }

        public virtual Answer Answer { get; set; }

        public virtual Survey Survey { get; set; }
    }
}
