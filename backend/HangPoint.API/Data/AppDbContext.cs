using HangPoint.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HangPoint.API.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        // Each line = one table in database
        public DbSet<User> Users { get; set; }
        public DbSet<Group> Groups { get; set; }
        public DbSet<GroupMember> GroupMembers { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<Itinerary> Itineraries { get; set; }
        public DbSet<ItineraryItem> ItineraryItems { get; set; }
        public DbSet<Vote> Votes { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // User - email must be unique
            modelBuilder.Entity<User>()
                .HasIndex(u => u.Email)
                .IsUnique();

            // Group - invite code must be unique
            modelBuilder.Entity<Group>()
                .HasIndex(g => g.InviteCode)
                .IsUnique();

            // One user can't join same group twice
            modelBuilder.Entity<GroupMember>()
                .HasIndex(gm => new { gm.GroupId, gm.UserId })
                .IsUnique();

            // One user can't vote twice on same itinerary
            modelBuilder.Entity<Vote>()
                .HasIndex(v => new { v.UserId, v.ItineraryId })
                .IsUnique();
        }
    }
}