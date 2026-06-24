# Intelligence Layer

## Messy Inputs
- Free-text enquiry messages (intent, urgency, service unknown)
- Post body text (topics, tags unstructured)
- Visitor behaviour (which page they came from — future)

## Auto-Structure Schema (Lead)
```json
{
  "lead_id": "uuid",
  "detected_service": "lash extensions",
  "urgency_signal": "wedding in 6 weeks",
  "lead_score": 85,
  "lead_score_source": "rule+gpt-4o",
  "lead_score_confidence": 0.88,
  "lead_score_review_status": "unreviewed"
}
```

## Events to Track
- Lead submitted (service field filled? message length? phone provided?)
- Post published (word count, has excerpt, has cover image)
- Lead status updated (time-to-first-view in hours)

## Scoring Rules (v1 — rule-based, no AI required)
| Signal | Points |
|---|---|
| Service interest filled | +20 |
| Phone number provided | +15 |
| Message > 50 chars | +20 |
| Urgency keyword (wedding, urgent, asap) | +30 |
| Email only, short message | baseline 15 |

## What Gets Ranked
- Leads inbox: sorted by `lead_score DESC`, then `created_at DESC`

## v1 vs Later
- **v1:** rule-based lead score computed on insert in API route
- **Later:** GPT-4o intent extraction, tag suggestions for posts, confidence scores stored and reviewable in admin
