# Transitly - Bus Booking System

A modern bus booking application built with Next.js 14, Supabase, and Tailwind CSS.

## Features

- 🔐 **Authentication** - Secure user signup/login with Supabase Auth
- 🔍 **Search** - Find buses by route and date
- 💺 **Seat Selection** - Interactive seat map for selecting seats
- 📝 **Booking** - Complete booking flow with passenger details
- 🎫 **E-Tickets** - Downloadable PDF tickets
- 📱 **Dashboard** - Manage upcoming and past bookings
- 💳 **Payment** - Demo payment integration

## Tech Stack

- **Frontend**: Next.js 14 (App Router), TypeScript
- **Styling**: Tailwind CSS, Lucide Icons
- **Backend**: Supabase (Auth, Database, Realtime)
- **Deployment**: Vercel

## Project Structure

```
src/
├── app/
│   ├── (auth)/          # Auth pages (login, signup)
│   ├── book/[id]/       # Booking page
│   ├── dashboard/       # User dashboard
│   │   ├── user/        # User dashboard home
│   │   └── bookings/    # Bookings management
│   ├── search/          # Bus search
│   ├── layout.tsx       # Root layout
│   └── page.tsx         # Home page
├── actions/             # Server actions
│   ├── auth.ts         # Auth actions
│   └── bookings.ts     # Booking actions
├── lib/                 # Utilities
│   ├── supabase/       # Supabase client/server
│   ├── utils.ts        # Helper functions
│   └── schemas.ts      # Zod schemas
└── middleware.ts        # Auth protection
```

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd training-ground-7
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env.local
```

4. Add your Supabase credentials to `.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
```

5. Run the development server:
```bash
npm run dev
```

6. Open [http://localhost:3000](http://localhost:3000)

### Database Setup

Run the SQL files in Supabase SQL Editor in this order:

1. `supabase/schema.sql` - Creates all tables and RLS policies
2. `supabase/seed.sql` - Adds sample data

## Deployment

### Vercel

1. Connect your GitHub repository to Vercel
2. Add environment variables in Vercel settings
3. Deploy

### Supabase Setup

1. Create a new Supabase project
2. Run the SQL scripts in the `supabase/` folder
3. Configure authentication (email/password)
4. Set up Row Level Security policies

## API Routes

- `POST /api/auth/login` - User login
- `POST /api/auth/signup` - User registration
- `GET /api/bookings` - List user bookings
- `POST /api/bookings` - Create new booking

## Environment Variables

| Variable | Description |
|----------|-------------|
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase anon key |
| `SUPABASE_SERVICE_ROLE_KEY` | Service role key (server-side) |

## License

MIT
