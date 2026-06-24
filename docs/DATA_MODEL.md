# Data Model

## site_settings
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | nullable until lock-down |
| site_name | text | |
| tagline | text | |
| owner_name | text | |
| contact_email | text | |
| social_instagram | text | |
| social_tiktok | text | |
| social_facebook | text | |
| logo_url | text | |
| created_at | timestamptz | |

## pages
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | |
| title | text | |
| slug | text | unique |
| body | text | markdown |
| status | text | published / draft |
| show_in_nav | boolean | |
| nav_order | int | |
| created_at | timestamptz | |

## posts
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | |
| title | text | |
| slug | text | unique |
| excerpt | text | |
| body | text | markdown |
| cover_image_url | text | |
| status | text | draft / published |
| published_at | timestamptz | |
| tags | text[] | |
| tag_source | text | AI field: source |
| tag_confidence | numeric | AI field: 0–1 |
| tag_review_status | text | unreviewed / accepted / overridden |
| created_at | timestamptz | |

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | |
| name | text | |
| email | text | |
| phone | text | optional |
| service_interest | text | |
| message | text | |
| status | text | new / viewed / responded |
| lead_score | numeric | AI field: 0–100 |
| lead_score_source | text | AI field: source |
| lead_score_confidence | numeric | AI field: 0–1 |
| lead_score_review_status | text | unreviewed / accepted / overridden |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | |
| object_type | text | post / page / lead / settings |
| object_id | uuid | |
| action | text | created / updated / published / status_changed |
| detail | jsonb | before/after snapshot |
| created_at | timestamptz | |

## RLS
- All tables: v1 permissive policies (full read + write without login)
- Lock-down sprint: replace with `auth.uid() = user_id` owner policies
- Public reads on posts/pages remain open post-lock-down
