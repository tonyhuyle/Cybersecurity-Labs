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

**Evidence:** 
- [Tenant Information](../Images/tenant-info.png)
- [Microsoft Graph Modules](../Images/graph-modules.png)
- [Microsoft Graph Authentication](../Images/graph-auth.png)

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

**Evidence:** [User Inventory](../Images/user-inventory.png)

## 3. Account Status Analysis

**Objective:** Identify disabled identities for further access lifecycle review.

**Methodology:** Filtered retrieved user objects using PowerShell `Where-Object` against the `AccountEnabled` property.

**Results:**
- Six accounts are enabled.
- One account, Victor Wemby (test identity), is disabled.

**Security Assessment:** The disabled identity requires further examination to determine whether unnecessary group memberships or privileged assignments remain. The disabled status alone does not constitute a security finding.

**Evidence:** [Account Status Analysis](../Images/account-status.png)

## 4. Disabled Account Membership Review

**Objective:** Identify direct group memberships retained by a disabled account.

**Methodology:** Queried the disabled identity using `Get-MgUserMemberOfAsGroup` to enumerate direct group memberships.

**Results:**
- Disabled identity: Victor Wemby
- Direct group memberships: 2
- Groups: Contractors, All Company (Dynamic)

**Security Assessment:** The disabled identity retains two group memberships. Further investigation is required to determine whether the memberships confer application access or conflict with offboarding requirements. The dynamic group's membership rule has not yet been reviewed.

**Evidence:** [Disabled Account Memberships](../Images/disabled-account-memberships.png)

### Contractors Group Verification

**Methodology:** Inspected the Contractors security group in the Microsoft Entra admin center to validate membership and group configuration.

**Results:**
- Group type: Security
- Membership type: Assigned
- Source: Cloud
- Direct members: 1 (Victor Wemby, disabled)
- Group owners: 0
- Nested group memberships: 0

**Security Assessment:** Confirmed that a disabled account retains assigned security group membership. Application access impact and offboarding requirements remain unverified.

**Evidence:** 
- [Contractors Group Overview](../Images/contractors-group-overview.png)
- [Contractors Group Members](../Images/contractors-group-members.png)

### Enterprise Application Assignment Review

**Objective:** Determine whether the disabled account's retained group membership is associated with enterprise application access.

**Methodology:** Reviewed enterprise application assignments in the Microsoft Entra admin center and compared them with the disabled account's group memberships.

**Results:**
- Application: THL Contractor Portal Demo
- Assigned security group: Contractors
- Disabled identity: Victor Wemby
- Authorization path: Victor Wemby → Contractors → THL Contractor Portal Demo

**Security Assessment:** Confirmed that a disabled identity retains group-based application assignment. Current access is not established because the account is disabled. Reactivation may restore authorization without an additional group membership review.

**Evidence:** [Contractor Portal Application Assignment](../Images/contractors-app-assignment.png)

## 5. Preliminary Findings and Follow-Up

| ID | Observation | Status |
|---|---|---|
| OBS-001 | Disabled account retains group-based enterprise application assignment | Pending access impact and lifecycle review |

No confirmed security vulnerabilities have been established.

## 6. Assessment Limitations

- Assessment performed against a simulated tenant containing seven user accounts.
- Business authorization requirements and offboarding history have not been verified.
- Group membership does not independently prove effective application access.
- Transitive memberships and privileged role assignments have not yet been reviewed.
- No identity configurations were modified during testing.
