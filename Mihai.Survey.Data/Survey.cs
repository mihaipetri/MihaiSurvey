using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class Survey
    {
        public Survey()
        {
            SurveyAnswers = new HashSet<SurveyAnswer>();
            SurveyComments = new HashSet<SurveyComment>();
        }

        public int Id { get; set; }

        [Required]
        [StringLength(256)]
        public string Name { get; set; }

        [StringLength(64)]
        public string UserId { get; set; }

        public DateTime CreateDate { get; set; }

        public DateTime UpdateDate { get; set; }

        public virtual ICollection<SurveyAnswer> SurveyAnswers { get; set; }

        public virtual ICollection<SurveyComment> SurveyComments { get; set; }
    }
}
