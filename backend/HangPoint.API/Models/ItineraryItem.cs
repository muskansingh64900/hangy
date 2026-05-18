namespace HangPoint.API.Models
{
    public class ItineraryItem
    {
        public int Id { get; set; }
        
        // Which itinerary
        public int ItineraryId { get; set; }
        public Itinerary Itinerary { get; set; } = null!;
        
        // Place Info (from Google Places API)
        public string PlaceName { get; set; } = string.Empty;
        public string PlaceId { get; set; } = string.Empty; // Google Place ID
        public string Category { get; set; } = string.Empty; // Cafe, Club, Activity etc
        public string Address { get; set; } = string.Empty;
        public double Lat { get; set; }
        public double Lng { get; set; }
        public double Rating { get; set; }
        public string PhotoUrl { get; set; } = string.Empty;
        
        // Timing
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public string OpeningHours { get; set; } = string.Empty;
        
        // Cost
        public decimal EstimatedCostPerPerson { get; set; }
        
        // Order in itinerary
        public int OrderIndex { get; set; } // 1st place, 2nd place etc
        
        public DateTime AddedAt { get; set; } = DateTime.UtcNow;
    }
}