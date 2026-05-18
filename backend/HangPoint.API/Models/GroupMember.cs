namespace HangPoint.API.Models
{
    public class GroupMember
    {
        public int Id { get; set; }
        
        // Which group and which user
        public int GroupId { get; set; }
        public Group Group { get; set; } = null!;
        public int UserId { get; set; }
        public User User { get; set; } = null!;
        
        // Role in group
        public string Role { get; set; } = "Member"; // Admin or Member
        
        // Status
        public bool HasSharedLocation { get; set; } = false;
        public DateTime JoinedAt { get; set; } = DateTime.UtcNow;
    }
}