using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace Mihai.Survey.Data
{
    public partial class AnswerStatu
    {
        public AnswerStatu()
        {
            Answers = new HashSet<Answer>();
        }

        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Id { get; set; }

        [Required]
        [StringLength(64)]
        public string Name { get; set; }

        public virtual ICollection<Answer> Answers { get; set; }
    }
}
