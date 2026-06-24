# Security

## Secret Handling
- Supabase service-role key: server-side only (`SUPABASE_SERVICE_ROLE_KEY` in Vercel env, never in client bundle)
- Public anon key: safe for client reads only
- OpenAI key: server-side only, never referenced in frontend code
- No secrets in `NEXT_PUBLIC_*` vars

## Permission Model
- **v1 (demo):** permissive RLS — all reads and writes open so the site is demoable without login
- **Lock-down sprint:** 
  - Public tables (posts `status=published`, pages `status=published`): `SELECT` open to all
  - Leads, site_settings, drafts: `auth.uid() = user_id` required for all access
  - `/admin/*` routes: server-side session check; redirect to `/login` if unauthenticated

## Approved-Tools Rule
- Agents may only call explicitly named tools (`compute_lead_score`, `suggest_post_tags`, `draft_lead_reply`)
- No `run_any`, `exec_sql`, or open-ended tool calls
- Every tool call writes an `activities` row before returning

## Audit Principle
- Every create, update, publish, status change, and tool invocation logs an `activities` row
- Logs include `user_id`, `action`, `object_id`, and a `detail` jsonb snapshot
- Logs are append-only (no delete policy on `activities`)
