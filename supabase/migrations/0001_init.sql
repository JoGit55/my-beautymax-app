create table if not exists site_settings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  site_name text not null default 'My BeautyMax',
  tagline text,
  owner_name text,
  contact_email text,
  social_instagram text,
  social_tiktok text,
  social_facebook text,
  logo_url text,
  created_at timestamptz not null default now()
);

alter table site_settings enable row level security;
drop policy if exists "site_settings_v1_read" on site_settings;
create policy "site_settings_v1_read" on site_settings for select using (true);
drop policy if exists "site_settings_v1_write" on site_settings;
create policy "site_settings_v1_write" on site_settings for all using (true) with check (true);

insert into site_settings (site_name, tagline, owner_name, contact_email, social_instagram)
values ('BeautyMax', 'Professional beauty treatments & advice', 'Alex Jordan', 'hello@beautymax.com', '@beautymaxofficial')
on conflict do nothing;

create table if not exists pages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  title text not null,
  slug text not null unique,
  body text,
  status text not null default 'published',
  show_in_nav boolean not null default true,
  nav_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table pages enable row level security;
drop policy if exists "pages_v1_read" on pages;
create policy "pages_v1_read" on pages for select using (true);
drop policy if exists "pages_v1_write" on pages;
create policy "pages_v1_write" on pages for all using (true) with check (true);

insert into pages (title, slug, body, status, show_in_nav, nav_order) values
('About', 'about', '## About Me\n\nI am a certified beauty therapist with over 8 years of experience in skincare, lash extensions, and holistic treatments. My studio is a calm, professional space where you come first.', 'published', true, 1),
('Services', 'services', '## Services\n\n- **Lash Extensions** — classic, hybrid & volume sets\n- **Facials** — deep cleanse, brightening, anti-ageing\n- **Brow Sculpting** — tint, wax & lamination\n\nAll treatments are tailored to you. Book via the enquiry form.', 'published', true, 2)
on conflict do nothing;

create table if not exists posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  title text not null,
  slug text not null unique,
  excerpt text,
  body text,
  cover_image_url text,
  status text not null default 'draft',
  published_at timestamptz,
  tags text[],
  tag_source text,
  tag_confidence numeric,
  tag_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table posts enable row level security;
drop policy if exists "posts_v1_read" on posts;
create policy "posts_v1_read" on posts for select using (true);
drop policy if exists "posts_v1_write" on posts;
create policy "posts_v1_write" on posts for all using (true) with check (true);

insert into posts (title, slug, excerpt, body, status, published_at, tags) values
('5 Skincare Habits That Changed My Clients'' Skin', '5-skincare-habits', 'Simple daily habits that deliver real results — no expensive products required.', '## 5 Skincare Habits\n\n1. Double cleanse every evening\n2. SPF every single morning\n3. Hydrate before you moisturise\n4. Never sleep in makeup\n5. Book a professional facial every 6–8 weeks\n\nConsistency beats expensive products every time.', 'published', now() - interval '10 days', ARRAY['skincare','tips']),
('Why Lash Extensions Are Worth It', 'why-lash-extensions', 'Thinking about lash extensions? Here is what you need to know before your first appointment.', '## Lash Extensions 101\n\nA good set of lashes should look natural, feel weightless, and last 3–4 weeks with proper care. Here is what to expect at your first appointment and how to make them last.', 'published', now() - interval '4 days', ARRAY['lashes','beauty']),
('Getting Ready for Summer: My Treatment Checklist', 'summer-treatment-checklist', 'The treatments I recommend before summer to look and feel your best.', '## Summer Prep Checklist\n\n- Brow lamination for effortless arches\n- A brightening facial for that glow\n- Fresh lash set before your holiday\n- Body exfoliation treatment\n\nBook early — summer slots fill fast!', 'draft', null, ARRAY['seasonal','treatments'])
on conflict do nothing;

create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  email text not null,
  phone text,
  service_interest text,
  message text,
  status text not null default 'new',
  lead_score numeric,
  lead_score_source text,
  lead_score_confidence numeric,
  lead_score_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

insert into leads (name, email, phone, service_interest, message, status, lead_score) values
('Sophie Clarke', 'sophie.clarke@email.com', '07712 345678', 'Lash Extensions', 'Hi! I would love to book a full set of volume lashes before my wedding in 6 weeks. Do you have availability?', 'new', 85),
('Priya Patel', 'priya.p@email.com', null, 'Facial', 'I have been struggling with congested skin. Would a deep cleanse facial help? What do you recommend?', 'viewed', 60),
('Jamie Lee', 'jamie.lee@email.com', '07890 123456', 'Brow Sculpting', 'Interested in brow lamination. How long does it last and what is the aftercare?', 'new', 70)
on conflict do nothing;

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  object_type text not null,
  object_id uuid,
  action text not null,
  detail jsonb,
  created_at timestamptz not null default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);