# Transfer API — example contract

`POST /v1/transfers`

Request:
```json
{
  "recipient_account_id": 20,
  "amount": "1500.00",
  "currency": "RUB",
  "idempotency_key": "sample-request-1"
}
```

Response 201:
```json
{
  "transfer_id": "tr_example_101",
  "status": "completed"
}
```

Errors: `401 unauthenticated`, `404 recipient_not_found`, `409 insufficient_funds`, `422 invalid_amount`, `429 rate_limited`.

**Design note:** Real implementations also need authorization, ledger accounting, transactional consistency, retries, monitoring, and regulatory review. These examples describe requirements rather than provide a banking backend.
