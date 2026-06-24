# Architecture

## Stack
- **Frontend + API:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres + RLS + Auth)
- **Styling:** Tailwind CSS
- **Rich text:** Markdown (stored as text, rendered with `react-markdown`)

## What to Build Now vs Later
**Now:** public site shell, post/page rendering, enquiry form, leads inbox, content editor, site settings.
**Next:** owner auth, RLS lock-down, email notifications, analytics.
**Later:** AI tag suggestions, lead scoring, newsletter, booking integration.

## Key User-Action Flow (Visitor submits enquiry)
1. Visitor fills enquiry form on public site
2. Browser POSTs to `/api/leads`
3. API validates fields, inserts row into `leads` table
4. Row gets a `status = 'new'`, `created_at` timestamp
5. API returns `{ success: true }` — form shows confirmation
6. Owner opens `/admin/leads` — new row appears at top
7. Owner clicks row, updates `status = 'viewed'` via PATCH
8. Activity row logged: `{ object_type: 'lead', action: 'status_updated' }`

## Layer Plan
1. **Data first** — tables, seed data, RLS policies
2. **App logic** — API routes, CRUD, status transitions
3. **Smart features** — AI tagging, lead scoring (later)

## Why the Core Works Without AI
All publishing, lead capture, and status management are plain DB reads/writes. AI fields (`tag_confidence`, `lead_score`) are optional columns — the app renders and functions whether they are populated or null.
