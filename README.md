
# drop●it 📍
> drop your location. find the vibe.

A group hangout planner app — share locations, find the midpoint, discover places, vote and plan together.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| Backend | C# ASP.NET Core 8 |
| Database | PostgreSQL |
| Auth | JWT + BCrypt |
| Real-time | SignalR |
| CI/CD | GitHub Actions |
| Hosting | Railway |

---

## 🚀 Getting Started — New Laptop Setup

### Prerequisites
Install these first:
- [Git](https://git-scm.com/download/win)
- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8)
- [Flutter](https://flutter.dev)
- [VS Code](https://code.visualstudio.com) + C# Dev Kit extension
- [PostgreSQL](https://postgresql.org)
- [Postman](https://postman.com) or RapidAPI VS Code extension

---

### Step 1 — Clone the repo
```bash
git clone https://github.com/muskansingh64900/hangy.git
cd hangy
```

### Step 2 — Switch to working branch
```bash
git checkout feature/auth
```

### Step 3 — Setup backend config
```bash
# Copy example config
cp backend/HangPoint.API/appsettings.Example.json backend/HangPoint.API/appsettings.json
```
Then open `appsettings.json` and fill in:
- Your PostgreSQL password
- Keep everything else same

### Step 4 — Create database
Open PostgreSQL / pgAdmin and run:
```sql
CREATE DATABASE hangpoint;
```

### Step 5 — Install backend packages + run migrations
```bash
cd backend/HangPoint.API
dotnet restore
dotnet ef database update
```

### Step 6 — Run the backend
```bash
dotnet run
# API runs on http://localhost:5166
```

### Step 7 — Setup Flutter
```bash
cd ../../frontend/hangpoint_app
flutter pub get
flutter run
```

---

## 📁 Project Structure

```
hangy/
├── .github/workflows/     → CI/CD pipelines
├── backend/
│   ├── HangPoint.API/     → C# ASP.NET Core API
│   │   ├── Controllers/   → API endpoints
│   │   ├── Models/        → database tables
│   │   ├── Services/      → business logic
│   │   ├── Data/          → DbContext
│   │   └── Migrations/    → database migrations
│   └── HangPoint.Tests/   → unit tests
├── frontend/
│   └── hangpoint_app/     → Flutter app
├── HangPoint.sln          → solution file
└── README.md
```

---

## 🔌 API Endpoints

### Auth
| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/auth/register` | Create new account |
| POST | `/api/auth/login` | Login, get JWT token |

### Coming Soon
| Method | Endpoint | Description |
|---|---|---|
| POST | `/api/group/create` | Create hangout group |
| POST | `/api/group/join` | Join via invite code |
| POST | `/api/location/share` | Share your location |
| GET | `/api/location/midpoint/{groupId}` | Get midpoint |
| GET | `/api/places/nearby` | Get places near midpoint |
| POST | `/api/itinerary/create` | Build itinerary |
| POST | `/api/vote` | Vote yes/no |

---

## 🗃️ Database Tables

```
Users          → app users
Groups         → hangout groups
GroupMembers   → who is in which group
Locations      → shared locations + midpoint
Itineraries    → hangout plans
ItineraryItems → individual places in plan
Votes          → yes/no votes
```

---

## 🔐 Environment Variables

Never commit `appsettings.json`! Use `appsettings.Example.json` as template.

| Variable | Description |
|---|---|
| `DefaultConnection` | PostgreSQL connection string |
| `JwtSettings:SecretKey` | JWT signing key (min 32 chars) |
| `GoogleMaps:ApiKey` | Google Maps + Places API key |

---

## 👥 Team

| Role | Responsibility |
|---|---|
| Muskan | Backend (C# API, Database, CI/CD) |
| Teammate | Frontend (Flutter UI) |

---

## 📅 Progress

- [x] Project setup + CI/CD pipeline
- [x] Database models (7 tables)
- [x] Auth module (register + login)
- [x] Flutter UI (register + login screens)
- [ ] Groups module
- [ ] Location + midpoint calculation
- [ ] Google Places integration
- [ ] Itinerary builder
- [ ] Voting system (real-time)
- [ ] Community feed
- [ ] Deploy to Railway
```

