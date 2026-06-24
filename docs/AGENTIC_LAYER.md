# Agentic Layer

## Risk Classification

### Low Risk — Auto (no approval needed)
- Auto-tag a post on save using suggested keywords
- Compute lead score on insert
- Generate post excerpt from body if left blank

### Medium Risk — Light Approval
- Draft a reply to a lead enquiry (owner reviews before sending)
- Suggest a post title/meta description from body content

### High Risk — Always Approval
- Send an email reply to a lead
- Publish a post (toggle from draft → published)

### Critical — Human Only
- Delete a lead or post
- Change contact email in site settings
- Any bulk delete

## Named Tools (v1 scope)
- `compute_lead_score(lead_id)` — rule-based scoring on insert
- `suggest_post_tags(post_id)` — calls AI, writes to tag fields with `review_status = 'unreviewed'`
- `draft_lead_reply(lead_id)` — generates reply draft, stored as `detail` in activities, never auto-sent

## Audit Log Fields (activities table)
- `object_type`, `object_id`, `action`, `detail` (jsonb before/after), `user_id`, `created_at`

## v1 vs Later
- **v1:** `compute_lead_score` only (rule-based, auto)
- **Next:** `suggest_post_tags` with owner review UI
- **Later:** `draft_lead_reply` → approval → send
