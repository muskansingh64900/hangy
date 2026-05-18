namespace HangPoint.API.Models
{
    public class Vote
    {
        public int Id { get; set; }
        
        // Who voted
        public int UserId { get; set; }
        public User User { get; set; } = null!;
        
        // What they voted on
        public int ItineraryId { get; set; }
        public Itinerary Itinerary { get; set; } = null!;
        
        // The vote
        public bool IsYes { get; set; } // true = yes, false = no
        public DateTime VotedAt { get; set; } = DateTime.UtcNow;
    }
}