# Microsoft Entra ID IAM Audit Notes

**Organization:** THL (Simulated)  
**Environment:** Microsoft Entra ID Lab Tenant  
**Assessment Type:** Identity Configuration and Access Review  
**Status:** In Progress (Step 3C Completed)

## 1. Environment Overview

| Component | Details |
|---|---|
| Identity Platform | Microsoft Entra ID |
| User Accounts | 7 |
| Security & Microsoft 365 Groups | 9 total groups |
| Applications | 4 shown in tenant overview |
| PowerShell | 7.6.9 |
| Microsoft Graph SDK | 2.41.2 |
| Authentication | Delegated OAuth 2.0 |

**Evidence:** `tenant-info.png`, `graph-modules.png`, `graph-auth.png`

## 2. User Inventory

**Objective:** Establish an identity inventory to identify account configurations requiring security review.

**Methodology:** Queried Microsoft Entra ID using `Get-MgUser` and collected display names, UPNs, account status, user classification, and creation timestamps.

**Results:**

| Metric | Count |
|---|---:|
| Total Accounts | 7 |
| Enabled Accounts | 6 |
| Disabled Accounts | 1 |
| Member Accounts | 7 |
| Guest Accounts | 0 |

**Observation:** All seven accounts were classified as Members. One account was identified as disabled.

**Evidence:** `user-inventory.png`

## 3. Account Status Analysis

**Objective:** Identify disabled identities for further access lifecycle review.

**Methodology:** Filtered retrieved user objects using PowerShell `Where-Object` against the `AccountEnabled` property.

**Results:**
- Six accounts are enabled.
- One account, Victor Wemby (test identity), is disabled.

**Security Assessment:** The disabled identity requires further examination to determine whether unnecessary group memberships or privileged assignments remain. The disabled status alone does not constitute a security finding.

**Evidence:** `account-status.png`

## 4. Preliminary Findings and Follow-Up

| ID | Observation | Status |
|---|---|---|
| OBS-001 | Disabled identity identified for retained-access review | Pending investigation |

No confirmed security vulnerabilities have been established.

**Next Test:** Review the disabled account's group memberships and privileged access assignments.

## 5. Assessment Limitations

- Assessment performed against a simulated tenant containing seven user accounts.
- Current analysis is limited to identity inventory and account status.
- Business authorization requirements and offboarding history have not yet been verified.
- No identity configurations were modified during testing.