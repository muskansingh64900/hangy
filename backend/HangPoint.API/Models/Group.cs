namespace HangPoint.API.Models
{
    public class Group
    {
        public int Id { get; set; }
        
        // Group Info
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string InviteCode { get; set; } = string.Empty; // unique code to join group
        
        // Group Creator
        public int CreatedByUserId { get; set; }
        public User CreatedBy { get; set; } = null!;
        
        // Status
        public bool IsActive { get; set; } = true;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
        // Navigation Properties
        public ICollection<GroupMember> Members { get; set; } = new List<GroupMember>();
        public ICollection<Itinerary> Itineraries { get; set; } = new List<Itinerary>();
    }
}