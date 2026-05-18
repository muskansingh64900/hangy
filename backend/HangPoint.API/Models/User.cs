namespace HangPoint.API.Models
{
    public class User
    {
        public int Id { get; set; }
        
        // Basic Info
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string PasswordHash { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;
        public string ProfilePicture { get; set; } = string.Empty;
        
        // Current Location (can change anytime like Zomato!)
        public double CurrentLat { get; set; }
        public double CurrentLng { get; set; }
        public string CurrentAddress { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        public string State { get; set; } = string.Empty;
        public string Country { get; set; } = "India";
        
        // App Info
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime LastActive { get; set; } = DateTime.UtcNow;
        public bool IsActive { get; set; } = true;
        
        // Navigation Properties (relationships)
        public ICollection<GroupMember> GroupMembers { get; set; } = new List<GroupMember>();
    }
}