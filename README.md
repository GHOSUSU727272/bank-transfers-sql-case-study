# Bank Transfers: System Analysis + SQL Practice

Educational case study for junior system analyst interviews. It is not a production banking system and does not contain actual customer data.

## Business goal
A user sends funds to another customer by phone number or account number. The service validates the request, authorizes the sender, checks limits and balance, processes the transfer once, and returns its status.

## Functional requirements
1. User selects a recipient by supported identifier and enters an amount.
2. Backend validates a positive amount, supported currency and recipient.
3. Balance and operation limits are validated atomically.
4. Duplicate requests carrying the same idempotency key do not create a second transfer.
5. Transfer statuses: `pending`, `completed`, `failed`.
6. A completed transfer appears in both participants' transaction history.
7. Sensitive card details and OTP codes are not stored in logs.

## Non-functional requirements
- Use authenticated endpoints and role checks.
- Do not log bank secrets or personal authentication codes.
- Return a stable transfer ID and an error code on failure.
- Treat transfer completion and account posting as an atomic operation (database transaction).

## Acceptance scenarios
| Given | When | Then |
| --- | --- | --- |
| Active sender, sufficient balance | Make valid transfer | Exactly one completed transfer |
| Not enough balance | Submit transfer | Failed with insufficient_funds; no posting |
| Repeated idempotency key | Retry request | Same result, no extra posting |
| Unknown recipient | Submit transfer | Validation error; no posting |
| Not authenticated | Call API | 401; no transfer |

## SQL exercises
Schema and sample data are in the repository root. Solutions demonstrate INNER/LEFT JOIN, aggregation, GROUP BY, HAVING, correlated filtering, ordering, and successful-transaction reports using PostgreSQL syntax.

