# Tasks & Sprints

## Sprint 1 — DB, Seed Data & Public Site Shell
**Goal:** Site renders with real content for anonymous visitors. No login needed.

- [ ] Run migration SQL (all tables + seed data)
- [ ] Next.js project scaffolded, Supabase client configured
- [ ] Homepage (`/`): reads `site_settings` + latest 3 published posts
- [ ] Post feed (`/posts`): lists all published posts
- [ ] Single post (`/posts/[slug]`): renders markdown body
- [ ] Static page (`/pages/[slug]`): renders About, Services from DB
- [ ] Nav bar driven by `pages` with `show_in_nav = true`, ordered by `nav_order`
- [ ] Tailwind layout: header, footer, responsive grid

**Definition of Done:** Visit `/`, `/posts`, `/posts/5-skincare-habits`, `/pages/about` — all render seed data. No login required.

---

## Sprint 2 — Lead Capture (Core Engine) ✦ v1 functional milestone
**Goal:** Visitor submits enquiry → stored in DB → visible in admin leads inbox.

- [ ] Enquiry form component: name, email, phone (optional), service interest (select), message
- [ ] `POST /api/leads` — validate, score (rule-based), insert row, log activity
- [ ] Inline form states: loading spinner, success message, field errors
- [ ] `/admin/leads` — table of all leads, sorted by score desc
- [ ] Lead detail: click row → view full message + status badge
- [ ] `PATCH /api/leads/[id]` — update status (new → viewed → responded)
- [ ] Empty state: "No enquiries yet. Share your site to start receiving leads."

**Definition of Done:** Submit form on live preview → row appears in `/admin/leads` with correct score and status. Status update persists on reload.

---

## Sprint 3 — Content Management (Publish/Edit Engine)
**Goal:** Owner can create, edit, and publish posts and pages from admin.

- [ ] `/admin/posts` — list all posts with status badge (draft/published)
- [ ] `/admin/posts/new` and `/admin/posts/[id]` — form: title, slug (auto-generated), excerpt, body (markdown textarea), cover image URL, status toggle
- [ ] `POST /api/posts` and `PATCH /api/posts/[id]` — persist, log activity
- [ ] Publish toggle: sets `status = 'published'` and `published_at = now()`
- [ ] Published post immediately appears on public `/posts` feed
- [ ] `/admin/pages` — same pattern for static pages
- [ ] Delete post/page with confirmation dialog (critical action)

**Definition of Done:** Create a new post in admin → publish it → visible at `/posts/[slug]` without reload.

---

## Sprint 4 — Site Settings & Polish
**Goal:** Owner controls site identity; public site is production-ready.

- [ ] `/admin/settings` — form for `site_settings` row
- [ ] `PATCH /api/site-settings` — upsert single settings row
- [ ] Homepage and nav reflect saved settings immediately
- [ ] `<head>` meta tags (title, description) on all public pages
- [ ] Mobile-responsive pass: nav hamburger, post grid, form layout
- [ ] Favicon and `og:image` from settings

**Definition of Done:** Update site name in settings → homepage title changes. All public pages have correct meta tags. Passes mobile viewport test.

---

## Sprint 5 — Lock It Down (Auth + RLS)
**Goal:** Only the owner can write data or access admin. Public site stays open.

- [ ] Supabase Auth: email/password for owner
- [ ] `/login` page + session management (Supabase SSR helpers)
- [ ] `/admin/*` middleware: redirect to `/login` if no session
- [ ] Replace v1 permissive RLS with owner-scoped policies on leads, drafts, settings
- [ ] Public RLS: posts/pages with `status = 'published'` remain readable by all
- [ ] Assign `user_id` on all write operations from `auth.uid()`
- [ ] Smoke test: logged-out user cannot POST to `/api/leads` admin actions

**Definition of Done:** Logged-out visitor sees public site normally. Visiting `/admin` redirects to `/login`. After login, all admin functions work. Logged-out POST to admin API returns 401.

---

## Sprint 6 — Intelligence Layer (Tags + Lead Scoring)
**Goal:** AI assists with tagging and lead prioritisation; owner reviews before accepting.

- [ ] `suggest_post_tags` tool: on post save, call GPT-4o, write `tags`, `tag_source`, `tag_confidence`, `tag_review_status = 'unreviewed'`
- [ ] Tag review UI in post editor: accept or override suggested tags
- [ ] Upgrade `compute_lead_score` to include GPT-4o intent signal alongside rules
- [ ] Store `lead_score_source`, `lead_score_confidence`, `lead_score_review_status`
- [ ] Lead inbox shows score + confidence badge; owner can override
- [ ] All AI calls logged as `activities` rows

**Definition of Done:** Save a post → tags appear with confidence score → owner accepts → `tag_review_status = 'accepted'`. Lead score shows AI signal in inbox.

---

## Gantt (Sprint → Feature)
```
Sprint 1: DB schema, seed data, public site shell, nav
Sprint 2: Enquiry form, /api/leads, leads inbox, status updates  ← v1 functional
Sprint 3: Post editor, page editor, publish toggle
Sprint 4: Site settings, meta tags, mobile polish
Sprint 5: Auth, RLS lock-down, /login, admin protection
Sprint 6: AI tagging, lead scoring upgrade, review UI
```
