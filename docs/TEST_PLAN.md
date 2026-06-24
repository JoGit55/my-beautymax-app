# Test Plan

## v1 Success Scenario (manual)

### Step 1 — Public site loads
1. Open `/` — verify site name, tagline, and 3 published posts render
2. Click a post card — verify `/posts/[slug]` renders full body
3. Open `/pages/about` — verify About content renders from DB
4. Verify nav contains About and Services links

### Step 2 — Lead capture (core engine)
1. Navigate to `/` — find enquiry form
2. Submit with: Name=Test User, Email=test@test.com, Service=Lash Extensions, Message=Hello I would like to book a full set of lashes please
3. Verify form shows loading state then success message
4. Open `/admin/leads` — verify new row at top with status `new` and score > 0
5. Click row — verify full message visible
6. Change status to `viewed` — verify badge updates and persists on refresh

### Step 3 — Publish a post
1. Open `/admin/posts/new`
2. Fill: title, body (markdown), excerpt
3. Click Save as Draft — verify appears in `/admin/posts` with `draft` badge
4. Open post, toggle to Published — verify `published` badge
5. Open `/posts` — verify new post appears in feed
6. Open `/posts/[new-slug]` — verify body renders correctly

## Empty State Tests
- Delete all leads → `/admin/leads` shows "No enquiries yet" message
- No published posts → `/posts` shows "No posts published yet" message

## Error / Edge Case Tests
- Submit enquiry form with missing required fields → inline field errors, no DB insert
- Submit with invalid email format → validation error shown
- Navigate to `/posts/nonexistent-slug` → 404 page (not crash)
- Save post with duplicate slug → error message returned, no duplicate inserted

## Loading State Tests
- Slow network simulation: form submit button shows spinner, not double-submittable
- Admin lists show skeleton loader while fetching
