# PRD — BeautyMax Personal Site & Content Tool

## Problem
The owner needs a site they fully own and control — not a rented platform that can change rules, charge fees, or disappear. They need to publish content, capture leads, and manage enquiries from one place.

## Target User
Sole owner-operator (beauty therapist / service professional). One admin. Visitors are prospective customers.

## Core Objects
- **Post** — blog/article content; draft or published
- **Page** — static pages (About, Services); appears in nav
- **Lead** — visitor enquiry submitted via contact form
- **Site Settings** — name, tagline, owner details, social links

## MVP Must-Haves (v1)
- [ ] Public homepage: site name, tagline, latest posts
- [ ] Public post feed (`/posts`) and single post pages
- [ ] Public static pages rendered from DB (About, Services)
- [ ] Enquiry form on public site → inserts Lead row
- [ ] Admin leads inbox: view all leads, update status
- [ ] Admin post editor: create/edit/publish/draft posts
- [ ] Admin page editor: create/edit pages
- [ ] Admin site settings: update name, tagline, contact email
- [ ] Seed data so site looks real on first load

## Non-Goals (v1)
- Multi-user / team access
- Payment / booking system
- Email sending
- Authentication (added in lock-down sprint)

## Success Scenario
Owner opens the live URL, sees their branded homepage with posts. A visitor fills in the enquiry form. Owner opens `/admin/leads`, sees the new lead, and marks it viewed — all persisted to the database.
