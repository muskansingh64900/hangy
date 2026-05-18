namespace HangPoint.API.Models
{
    public class Location
    {
        public int Id { get; set; }
        
        // Which user and group
        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public int GroupId { get; set; }
        public Group Group { get; set; } = null!;
        
        // Actual location
        public double Lat { get; set; }
        public double Lng { get; set; }
        public string Address { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        
        // Midpoint (calculated after all share)
        public double? MidpointLat { get; set; }
        public double? MidpointLng { get; set; }
        
        public DateTime SharedAt { get; set; } = DateTime.UtcNow;
    }
}