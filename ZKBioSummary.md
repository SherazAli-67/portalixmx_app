# ZKBio CVSecurity — Portalix Integration Summary

## Executive Summary

**ZKBio CVSecurity can support Portalix door access via Model A (show QR at the door).** ZKTeco confirmed that Portalix **cannot generate its own QR payloads** — the software must create dynamic QR codes via API, which Portalix then displays.

| Verdict | Detail |
|---------|--------|
| Feasible | Yes, with on-prem ZKBio server + door readers + Firebase Cloud Functions proxy |
| v1 scope | Residents (My Access QR) + Guests (visitor QR) in `portalixmx_app` |
| Constraint | No app calls ZKBio REST directly; all calls go through Cloud Functions |

## Multi-Codebase Architecture

Portalix has **five separate codebases** sharing one Firebase project:

| Role | Codebase | ZKBio phase |
|------|----------|-------------|
| Super-Admin | Website (separate repo) | Phase 2 — society config UI |
| Resident-Admin | App (separate repo) | Phase 2 — approvals + guest QR |
| **Resident** | **`portalixmx_app`** | **Phase 1** |
| Guards | App (separate repo) | Phase 2 — log sync |
| Visitors | App (separate repo) | Phase 3 — approved QR |

```
Flutter Apps / Website
        │
        ▼
Firebase Callable Functions  ←── only place with ZKBio access_token
        │
        ▼
ZKBio CVSecurity Server (on-prem, e.g. access.portalix.com)
        │
        ▼
Access Controller → QR Reader → Door
```

## Model A Flow

1. Register person/visitor in ZKBio (via Cloud Functions)
2. Fetch dynamic QR payload from ZKBio API
3. Display QR in app using `qr_flutter`
4. User shows phone at door reader
5. Reader validates with ZKBio → door opens

## Critical: Current QR Is Incompatible

The resident app previously generated custom JSON QR codes locally. **ZKTeco readers will not accept these.** All QR content must come from:

- `POST /api/v2/person/getQrCode?pin={pin}` — residents
- `POST /api/visRegistration/getQrCode?pin={pin}` — guests

Response `data` is a **payload string** (not a PNG), e.g. `"2#6SQLIaSLhprGhpkCgFrhHfdyZXFJxK2DLy+oLVoImoI="`.

## Firestore Schema Contract (all codebases)

### `societies/{societyId}`

| Field | Type | Notes |
|-------|------|-------|
| `zkbioEnabled` | bool | Master switch |
| `zkbioServerUrl` | string | e.g. `https://access.portalix.com` |
| `zkbioServerPort` | int | e.g. `8088` |
| `defaultAccLevelIds` | string[] | Resident door groups |
| `defaultVisLevelIds` | string[] | Guest door groups |
| `amenityAccLevelMap` | map | Amenity ID → level ID |

`access_token` → Firebase Secret Manager `ZKBIO_TOKEN_{societyId}` (never in Firestore).

### `residents/{uid}`

| Field | Type |
|-------|------|
| `status` | int (0=pending, 1=approved) |
| `zkPin` | string? |
| `zkProvisionedAt` | timestamp? |
| `zkAccLevelIds` | string[]? |

Provisioning runs when `status` → `approved` (resident-admin approval).

### `residents/{uid}/visitors/{visitorId}`

| Field | Type |
|-------|------|
| `zkVisEmpPin` | string? |
| `zkCertNum` | string? |
| `zkRegisteredAt` | timestamp? |
| `zkCheckedOutAt` | timestamp? |

### `access_requests/{id}`

| Field | Type |
|-------|------|
| `status` | string (`pending` / `approved` / `rejected`) |
| `zkAccessGrantedAt` | timestamp? |

### `societies/{societyId}/guard_logs/{logId}`

Synced from ZKBio `transaction/list` (Guards app, Phase 2).

## Callable Functions API

| Callable | Roles | Purpose |
|----------|-------|---------|
| `getResidentQr` | resident (approved) | Fetch dynamic resident QR |
| `registerGuestZkAccess` | resident, resident_admin | Register guest in ZKBio + return QR |
| `refreshGuestQr` | resident, resident_admin | Refresh guest QR payload |
| `checkoutGuestZkAccess` | resident, resident_admin, guard | End guest visit in ZKBio |
| `syncGuardAccessLogs` | guard, resident_admin | Pull door events into Firestore |

Firestore triggers (no app call):

- `residents/{uid}` status → `approved` → provision in ZKBio
- `access_requests/{id}` status → `approved` → grant amenity access

## ZKBio API Reference (key endpoints)

| Endpoint | Purpose |
|----------|---------|
| `POST /api/person/add` | Provision resident |
| `POST /api/v2/person/getQrCode` | Resident dynamic QR |
| `POST /api/visRegistration/add` | Register guest visit |
| `POST /api/visRegistration/getQrCode` | Guest dynamic QR |
| `POST /api/visRegistration/exit` | Checkout guest |
| `GET /api/v2/transaction/list` | Door access logs |
| `POST /api/door/remoteOpenById` | Model B only (not v1) |

Base URL: `http(s)://{serverIP}:{port}/api/...?access_token={token}`

## Super-Admin Setup (per society)

1. Install ZKBio CVSecurity on on-prem server
2. Activate API license; create API client → obtain `access_token`
3. Configure access level groups + visitor level groups for gates
4. Expose server via reverse proxy (e.g. `https://access.portalix.com`)
5. Store token: `firebase functions:secrets:set ZKBIO_TOKEN_{societyId}`
6. Seed Firestore `societies/{id}` with `zkbioEnabled`, URLs, level IDs

## POC Checklist

- [ ] `person/add` + `getPersonQr` → door reader opens
- [ ] `visRegistration/add` + `getQrCode` → guest QR works in time window
- [ ] QR rejected outside `endTime`
- [ ] `visRegistration/exit` revokes access
- [ ] `transaction/list` returns door events
- [ ] Confirm `visEmpPin` in `visRegistration/add` response
- [ ] Confirm dynamic QR TTL → set app refresh interval

## Risks

| Risk | Mitigation |
|------|------------|
| QR TTL unknown | Auto-refresh in `ZkbioQrWidget` (default 60s) |
| Resident not approved before QR | Account-pending gate + Firestore trigger on approval |
| Five repos schema drift | This document as cross-repo contract |
| Guards scan API may not exist | Phase 2; fallback to transaction log audit |

## Documentation

- API manual: `assets/zktech/ZKBio CVSecurity _3rd Party API_User Manual_20251218.pdf`
- Datasheet: `assets/zktech/ZKBio CVSecurity V6.7.0_Datasheet_20251127.pdf`
