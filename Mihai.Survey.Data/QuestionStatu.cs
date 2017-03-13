using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class QuestionStatu
    {
        public QuestionStatu()
        {
            Questions = new HashSet<Question>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Id { get; set; }

        [Required]
        [StringLength(64)]
        public string Name { get; set; }

        public virtual ICollection<Question> Questions { get; set; }
    }
}
