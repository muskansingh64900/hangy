namespace HangPoint.API.Models
{
    public class Itinerary
    {
        public int Id { get; set; }
        
        // Which group
        public int GroupId { get; set; }
        public Group Group { get; set; } = null!;
        
        // Itinerary Info
        public string Title { get; set; } = string.Empty;
        public DateTime HangoutDate { get; set; }
        public string MeetingPoint { get; set; } = string.Empty;
        public double MeetingLat { get; set; }
        public double MeetingLng { get; set; }
        
        // Status
        public string Status { get; set; } = "Planning"; // Planning, Confirmed, Completed
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
        // Navigation
        public ICollection<ItineraryItem> Items { get; set; } = new List<ItineraryItem>();
        public ICollection<Vote> Votes { get; set; } = new List<Vote>();
    }
}