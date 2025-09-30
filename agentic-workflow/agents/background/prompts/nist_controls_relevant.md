```markdown
# NIST SP 800-53 Control Catalog (Filtered for Relevance)

## AC: Access Control

### AC-2: Account Management

#### AC-2(a): Account Management - a
- **Control Statement:** Define and document the types of accounts allowed and specifically prohibited for use within the system;
- **Organizational Assignments (Variables):**
    - types of accounts allowed and specifically prohibited for use within the system

#### AC-2(b): Account Management - b
- **Control Statement:** Assign account managers;
- **Organizational Assignments (Variables):**
    - None

#### AC-2(c): Account Management - c
- **Control Statement:** Require organization-defined prerequisites and criteria for group and role membership.
- **Organizational Assignments (Variables):**
    - organization-defined prerequisites and criteria for group and role membership

#### AC-2(d): Account Management - d
- **Control Statement:** Specify authorized users of the system, group and role membership, and access authorizations (i.e., privileges) and organization-defined attributes (as required) for each account.
- **Organizational Assignments (Variables):**
    - organization-defined attributes (as required)

#### AC-2(e): Account Management - e
- **Control Statement:** Require approvals by organization-defined personnel or roles for requests to create accounts.
- **Organizational Assignments (Variables):**
    - organization-defined personnel or roles (for approvals)

#### AC-2(f): Account Management - f
- **Control Statement:** Create, enable, modify, disable, and remove accounts in accordance with organization-defined policy, procedures, prerequisites, and criteria.
- **Organizational Assignments (Variables):**
    - organization-defined policy, procedures, prerequisites, and criteria

#### AC-2(g): Account Management - g
- **Control Statement:** Monitor the use of accounts;
- **Organizational Assignments (Variables):**
    - None

#### AC-2(h): Account Management - h
- **Control Statement:** Notify account managers and organization-defined personnel or roles within organization-defined time periods when accounts are no longer required, when users are terminated or transferred, and when system usage or need-to-know changes for an individual.
- **Organizational Assignments (Variables):**
    - organization-defined personnel or roles (for notification)
    - organization-defined time periods

#### AC-2(i): Account Management - i
- **Control Statement:** Authorize access to the system based on a valid access authorization, intended system usage, and organization-defined attributes (as required).
- **Organizational Assignments (Variables):**
    - organization-defined attributes (as required)

#### AC-2(j): Account Management - j
- **Control Statement:** Review accounts for compliance with account management requirements at organization-defined frequency.
- **Organizational Assignments (Variables):**
    - organization-defined frequency

#### AC-2(k): Account Management - k
- **Control Statement:** Establish and implement a process for changing shared or group account authenticators (if deployed) when individuals are removed from the group;
- **Organizational Assignments (Variables):**
    - None

#### AC-2(l): Account Management - l
- **Control Statement:** Align account management processes with personnel termination and transfer processes.
- **Organizational Assignments (Variables):**
    - None

#### AC-2(1): Account Management | Automated System Account Management
- **Control Statement:** Support the management of system accounts through the use of automated mechanisms that are defined by the organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms that are defined by the organization

#### AC-2(2): Account Management | Automated Temporary and Emergency Account Management
- **Control Statement:** Automatically remove or disable temporary and emergency accounts after a time period that is defined by the organization for each type of account.
- **Organizational Assignments (Variables):**
    - time period that is defined by the organization for each type of account

#### AC-2(3)(a): Account Management | Disable Accounts - a
- **Control Statement:** "Disable accounts within a time period defined by the organization when any of the following conditions occur: The accounts have expired."
- **Organizational Assignments (Variables):**
    - time period defined by the organization (for disabling)

#### AC-2(3)(b): Account Management | Disable Accounts - b
- **Control Statement:** "Disable accounts within a time period defined by the organization when any of the following conditions occur: The accounts are no longer associated with a user or individual."
- **Organizational Assignments (Variables):**
    - time period defined by the organization (for disabling)

#### AC-2(3)(c): Account Management | Disable Accounts - c
- **Control Statement:** "Disable accounts within a time period defined by the organization when any of the following conditions occur: The accounts are in violation of organizational policy."
- **Organizational Assignments (Variables):**
    - time period defined by the organization (for disabling)

#### AC-2(3)(d): Account Management | Disable Accounts - d
- **Control Statement:** "Disable accounts within a time period defined by the organization when any of the following conditions occur: The accounts have been inactive for a time period defined by the organization."
- **Organizational Assignments (Variables):**
    - time period defined by the organization (for disabling)
    - time period defined by the organization (for inactivity)

#### AC-2(4): Account Management | Automated Audit Actions
- **Control Statement:** Automatically audit account creation, modification, enabling, disabling, and removal actions.
- **Organizational Assignments (Variables):**
    - None

#### AC-2(5): Account Management | Inactivity Logout
- **Control Statement:** Require that users log out after a defined period of expected inactivity, or in accordance with specific circumstances outlined by the organization regarding when to log out.
- **Organizational Assignments (Variables):**
    - defined period of expected inactivity
    - specific circumstances outlined by the organization regarding when to log out

#### AC-2(7)(a): Account Management | Privileged User Accounts - a
- **Control Statement:** Establish and manage privileged user accounts in accordance with a role-based access scheme or an attribute-based access scheme, as defined by the organization.
- **Organizational Assignments (Variables):**
    - role-based access scheme or an attribute-based access scheme, as defined by the organization

#### AC-2(7)(b): Account Management | Privileged User Accounts - b
- **Control Statement:** Monitor the assignments of privileged roles or attributes to ensure compliance and security.
- **Organizational Assignments (Variables):**
    - None

#### AC-2(7)(c): Account Management | Privileged User Accounts - c
- **Control Statement:** Monitor changes to roles or attributes.
- **Organizational Assignments (Variables):**
    - None

#### AC-2(7)(d): Account Management | Privileged User Accounts - d
- **Control Statement:** Revoke access when privileged role or attribute assignments are no longer appropriate.
- **Organizational Assignments (Variables):**
    - None

#### AC-2(9): Account Management | Restrictions on Use of Shared and Group Accounts
- **Control Statement:** Only permit the use of shared and group accounts that comply with conditions for establishing such accounts as defined by the organization.
- **Organizational Assignments (Variables):**
    - conditions for establishing such accounts as defined by the organization

#### AC-2(11): Account Management | Usage Conditions
- **Control Statement:** Enforce circumstances and/or usage conditions defined by the organization for specific system accounts as specified.
- **Organizational Assignments (Variables):**
    - circumstances and/or usage conditions defined by the organization for specific system accounts

#### AC-2(12)(a): Account Management | Account Monitoring for Atypical Usage - a
- **Control Statement:** Monitor system accounts for atypical usage as defined by the organization.
- **Organizational Assignments (Variables):**
    - atypical usage as defined by the organization

#### AC-2(12)(b): Account Management | Account Monitoring for Atypical Usage - b
- **Control Statement:** Report atypical usage of system accounts to personnel or roles defined by the organization.
- **Organizational Assignments (Variables):**
    - personnel or roles defined by the organization (for reporting)

#### AC-2(13): Account Management | Disable Accounts for High-risk Individuals
- **Control Statement:** Disable the accounts of individuals within a time period defined by the organization upon the discovery of significant risks as specified by the organization.
- **Organizational Assignments (Variables):**
    - time period defined by the organization
    - significant risks as specified by the organization

### AC-3: Access Enforcement

#### AC-3: Access Enforcement
- **Control Statement:** Enforce approved authorizations for logical access to information and system resources in accordance with applicable access control policies.
- **Organizational Assignments (Variables):**
    - None

### AC-4: Information Flow Enforcement

#### AC-4: Information Flow Enforcement
- **Control Statement:** Enforce approved authorizations for managing the flow of information within the system and between connected systems in accordance with information flow control policies defined by the organization.
- **Organizational Assignments (Variables):**
    - information flow control policies defined by the organization

#### AC-4(4): Information Flow Enforcement | Flow Control of Encrypted Information
- **Control Statement:** Prevent encrypted information from bypassing information flow control mechanisms defined by the organization by taking actions such as decrypting the information, blocking the flow of encrypted information, terminating communication sessions attempting to transmit encrypted information, or following other procedures or methods specified by the organization.
- **Organizational Assignments (Variables):**
    - information flow control mechanisms defined by the organization
    - other procedures or methods specified by the organization

#### AC-4(21): Information Flow Enforcement | Physical or Logical Separation of Information Flows
- **Control Statement:** Separate information flows either logically or physically using mechanisms and techniques defined by the organization to achieve the required separations by types of information as specified by the organization.
- **Organizational Assignments (Variables):**
    - mechanisms and techniques defined by the organization
    - types of information as specified by the organization

### AC-6: Least Privilege

#### AC-6: Least Privilege
- **Control Statement:** Employ the principle of least privilege by granting users (or processes acting on their behalf) only the access necessary to perform their assigned organizational tasks.
- **Organizational Assignments (Variables):**
    - None

#### AC-6(1)(a): Least Privilege | Authorize Access to Security Functions - a
- **Control Statement:** "Authorize access for individuals or roles defined by the organization to the following: Security functions deployed in hardware, software, and firmware as specified by the organization."
- **Organizational Assignments (Variables):**
    - individuals or roles defined by the organization
    - Security functions deployed in hardware, software, and firmware as specified by the organization

#### AC-6(1)(b): Least Privilege | Authorize Access to Security Functions - b
- **Control Statement:** "Authorize access for individuals or roles defined by the organization to the following: Security-relevant information as defined by the organization."
- **Organizational Assignments (Variables):**
    - individuals or roles defined by the organization
    - Security-relevant information as defined by the organization

#### AC-6(2): Least Privilege | Non-privileged Access for Nonsecurity Functions
- **Control Statement:** Require that users of system accounts or roles with access to security functions or security-relevant information use non-privileged accounts or roles when accessing non-security functions.
- **Organizational Assignments (Variables):**
    - None

#### AC-6(3): Least Privilege | Network Access to Privileged Commands
- **Control Statement:** Authorize network access to privileged commands defined by the organization only for compelling operational needs specified by the organization, and document the rationale for such access in the security plan for the system.
- **Organizational Assignments (Variables):**
    - privileged commands defined by the organization
    - compelling operational needs specified by the organization

#### AC-6(5): Least Privilege | Privileged Accounts
- **Control Statement:** Restrict privileged accounts on the system to personnel or roles defined by the organization.
- **Organizational Assignments (Variables):**
    - personnel or roles defined by the organization

#### AC-6(7)(a): Least Privilege | Review of User Privileges - a
- **Control Statement:** Review the privileges assigned to roles or classes of users defined by the organization at a frequency specified by the organization to validate the necessity of those privileges.
- **Organizational Assignments (Variables):**
    - roles or classes of users defined by the organization
    - frequency specified by the organization

#### AC-6(7)(b): Least Privilege | Review of User Privileges - b
- **Control Statement:** Reassign or remove privileges, if necessary, to correctly reflect organizational mission and business needs.
- **Organizational Assignments (Variables):**
    - None

#### AC-6(8): Least Privilege | Privilege Levels for Code Execution
- **Control Statement:** Prevent the specified software from executing at privilege levels higher than those of the users who are running the software. The software to be restricted is defined by the organization.
- **Organizational Assignments (Variables):**
    - specified software
    - software to be restricted is defined by the organization

#### AC-6(9): Least Privilege | Log Use of Privileged Functions
- **Control Statement:** Log the execution of privileged functions.
- **Organizational Assignments (Variables):**
    - None

#### AC-6(10): Least Privilege | Prohibit Non-privileged Users from Executing Privileged Functions
- **Control Statement:** Prevent non-privileged users from executing privileged functions.
- **Organizational Assignments (Variables):**
    - None

### AC-7: Unsuccessful Logon Attempts

#### AC-7(a): Unsuccessful Logon Attempts - a
- **Control Statement:** Enforce a limit on the number of consecutive invalid logon attempts by a user, which is defined by the organization, during a specified time period also defined by the organization.
- **Organizational Assignments (Variables):**
    - limit on the number of consecutive invalid logon attempts by a user, which is defined by the organization
    - specified time period also defined by the organization

#### AC-7(b): Unsuccessful Logon Attempts - b
- **Control Statement:** "Automatically take one or more of the following actions when the maximum number of unsuccessful logon attempts is exceeded: Lock the account or node for a time period defined by the organization. Lock the account or node until it is released by an administrator. Delay the next logon prompt according to a delay algorithm defined by the organization. Notify the system administrator. Take other actions as defined by the organization."
- **Organizational Assignments (Variables):**
    - time period defined by the organization (for lock)
    - delay algorithm defined by the organization
    - other actions as defined by the organization

### AC-8: System Use Notification

#### AC-8(a): System Use Notification - a
- **Control Statement:** "Display a system use notification message or banner defined by the organization to users before granting access to the system. This notification must provide privacy and security notices consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines, and must state the following: 1. Users are accessing a U.S. Government system. 2. System usage may be monitored, recorded, and is subject to audit. 3. Unauthorized use of the system is prohibited and may result in criminal and civil penalties. 4. Use of the system indicates consent to monitoring and recording."
- **Organizational Assignments (Variables):**
    - system use notification message or banner defined by the organization
    - privacy and security notices consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### AC-8(b): System Use Notification - b
- **Control Statement:** Retain the notification message or banner on the screen until users acknowledge the usage conditions and take explicit actions to log on to or further access the system; and
- **Organizational Assignments (Variables):**
    - None

### AC-12: Session Termination

#### AC-12: Session Termination
- **Control Statement:** Automatically terminate a user session after conditions or trigger events defined by the organization that require a session disconnect occur.
- **Organizational Assignments (Variables):**
    - conditions or trigger events defined by the organization

### AC-17: Remote Access

#### AC-17(1): Remote Access | Monitoring and Control
- **Control Statement:** Employ automated mechanisms to monitor and control remote access methods.
- **Organizational Assignments (Variables):**
    - None

#### AC-17(2): Remote Access | Protection of Confidentiality and Integrity Using Encryption
- **Control Statement:** Implement cryptographic mechanisms to protect the confidentiality and integrity of remote access sessions.
- **Organizational Assignments (Variables):**
    - None

#### AC-17(3): Remote Access | Managed Access Control Points
- **Control Statement:** Route remote accesses through authorized and managed network access control points.
- **Organizational Assignments (Variables):**
    - None

#### AC-17(4)(a): Remote Access | Privileged Commands and Access - a
- **Control Statement:** Authorize the execution of privileged commands and access to security-relevant information via remote access only in a manner that provides assessable evidence, and only for the needs defined by the organization.
- **Organizational Assignments (Variables):**
    - needs defined by the organization

#### AC-17(4)(b): Remote Access | Privileged Commands and Access - b
- **Control Statement:** Document the rationale for remote access in the security plan for the system.
- **Organizational Assignments (Variables):**
    - None

## AU: Audit and Accountability

### AU-2: Event Logging

#### AU-2(a): Event Logging - a
- **Control Statement:** Identify the types of events that the system is capable of logging in support of the audit function defined by the event types that the system is capable of logging.
- **Organizational Assignments (Variables):**
    - event types that the system is capable of logging

#### AU-2(b): Event Logging - b
- **Control Statement:** Coordinate the event logging function with other organizational entities requiring audit-related information to guide and inform the selection criteria for events to be logged.
- **Organizational Assignments (Variables):**
    - None

#### AU-2(c): Event Logging - c
- **Control Statement:** Specify the following event types for logging within the system as defined by a subset of events from AU-2(a) along with the frequency of logging for each identified event type.
- **Organizational Assignments (Variables):**
    - subset of events from AU-2(a)
    - frequency of logging for each identified event type

#### AU-2(d): Event Logging - d
- **Control Statement:** Provide a rationale for why the event types selected for logging are deemed to be adequate to support after-the-fact investigations of incidents.
- **Organizational Assignments (Variables):**
    - None

### AU-3: Content of Audit Records

#### AU-3(a): Content of Audit Records - a
- **Control Statement:** Ensure that audit records contain information that establishes What type of event occurred.
- **Organizational Assignments (Variables):**
    - None

#### AU-3(b): Content of Audit Records - b
- **Control Statement:** Ensure that audit records contain information that establishes when the event occurred.
- **Organizational Assignments (Variables):**
    - None

#### AU-3(c): Content of Audit Records - c
- **Control Statement:** Ensure that audit records contain information that establishes where the event occurred.
- **Organizational Assignments (Variables):**
    - None

#### AU-3(d): Content of Audit Records - d
- **Control Statement:** Ensure that audit records contain information that establishes the source of the event.
- **Organizational Assignments (Variables):**
    - None

#### AU-3(e): Content of Audit Records - e
- **Control Statement:** Ensure that audit records contain information that establishes the outcome of the event.
- **Organizational Assignments (Variables):**
    - None

#### AU-3(f): Content of Audit Records - f
- **Control Statement:** Ensure that audit records contain information that establishes identity of any individuals, subjects, or objects/entities associated with the event.
- **Organizational Assignments (Variables):**
    - None

#### AU-3(1): Content of Audit Records | Additional Audit Information
- **Control Statement:** Generate audit records containing the following additional information: ex.. access control or flow control rules invoked and individual identities of group account users.
- **Organizational Assignments (Variables):**
    - None (The example lists information that should be captured)

### AU-4: Audit Log Storage Capacity

#### AU-4: Audit Log Storage Capacity
- **Control Statement:** Allocate audit log storage capacity to accommodate defined audit log retention requirements.
- **Organizational Assignments (Variables):**
    - defined audit log retention requirements

### AU-5: Response to Audit Logging Process Failures

#### AU-5(a): Response to Audit Logging Process Failures - a
- **Control Statement:** Alert personnel or role within a defined time period in the event of an audit logging process failure.
- **Organizational Assignments (Variables):**
    - defined time period

#### AU-5(b): Response to Audit Logging Process Failures - b
- **Control Statement:** Take the following additional actions: organization-defined additional actions.
- **Organizational Assignments (Variables):**
    - organization-defined additional actions

#### AU-5(1): Response to Audit Logging Process Failures | Storage Capacity Warning
- **Control Statement:** Provide a warning to defined personnel, roles, and/or locations within a defined time period when allocated audit log storage volume reaches a defined percentage of repository maximum audit log storage capacity.
- **Organizational Assignments (Variables):**
    - defined personnel, roles, and/or locations
    - defined time period
    - defined percentage of repository maximum audit log storage capacity

#### AU-5(2): Response to Audit Logging Process Failures | Real-time Alerts
- **Control Statement:** Provide an alert within a defined real-time period to defined personnel, roles, and/or locations when the defined audit failure events occur.
- **Organizational Assignments (Variables):**
    - defined real-time period
    - defined personnel, roles, and/or locations
    - defined audit failure events

### AU-6: Audit Record Review, Analysis, and Reporting

#### AU-6(a): Audit Record Review, Analysis, and Reporting - a
- **Control Statement:** Review and analyze system audit records defined frequency for indications of defined inappropriate or unusual activity and the potential impact of the inappropriate or unusual activity.
- **Organizational Assignments (Variables):**
    - defined frequency
    - defined inappropriate or unusual activity

#### AU-6(b): Audit Record Review, Analysis, and Reporting - b
- **Control Statement:** Report findings to defined personnel or roles.
- **Organizational Assignments (Variables):**
    - defined personnel or roles (for reporting)

#### AU-6(c): Audit Record Review, Analysis, and Reporting - c
- **Control Statement:** Adjust the level of audit record review, analysis, and reporting within the system when there is a change in risk based on law enforcement information, intelligence information, or other credible sources of information.
- **Organizational Assignments (Variables):**
    - None

#### AU-6(1): Audit Record Review, Analysis, and Reporting | Automated Process Integration
- **Control Statement:** Integrate audit record review, analysis, and reporting processes using organization-defined automated mechanisms.
- **Organizational Assignments (Variables):**
    - organization-defined automated mechanisms

#### AU-6(3): Audit Record Review, Analysis, and Reporting | Correlate Audit Record Repositories
- **Control Statement:** Analyze and correlate audit records across different repositories to gain organization-wide situational awareness.
- **Organizational Assignments (Variables):**
    - None

#### AU-6(4): Audit Record Review, Analysis, and Reporting | Central Review and Analysis
- **Control Statement:** Provide and implement the capability to centrally review and analyze audit records from multiple components within the system.
- **Organizational Assignments (Variables):**
    - None

#### AU-6(5): Audit Record Review, Analysis, and Reporting | Integrated Analysis of Audit Records
- **Control Statement:** Integrate analysis of audit records with analysis of one or more: vulnerability scanning information, performance data, system monitoring information, defined data/information collected from other sources to further enhance the ability to identify inappropriate or unusual activity.
- **Organizational Assignments (Variables):**
    - defined data/information collected from other sources

#### AU-6(6): Audit Record Review, Analysis, and Reporting | Correlation with Physical Monitoring
- **Control Statement:** Correlate information from audit records with information obtained from monitoring physical access to further enhance the ability to identify suspicious, inappropriate, unusual, or malevolent activity.
- **Organizational Assignments (Variables):**
    - None

#### AU-6(7): Audit Record Review, Analysis, and Reporting | Permitted Actions
- **Control Statement:** Specify the permitted actions for each system process, role, or user associated with the review, analysis, and reporting of audit record information.
- **Organizational Assignments (Variables):**
    - None

### AU-7: Audit Record Reduction and Report Generation

#### AU-7(a): Audit Record Reduction and Report Generation - a
- **Control Statement:** Supports on-demand audit record review, analysis, and reporting requirements and after-the-fact investigations of incidents
- **Organizational Assignments (Variables):**
    - None

#### AU-7(b): Audit Record Reduction and Report Generation - b
- **Control Statement:** Does not alter the original content or time ordering of audit records.
- **Organizational Assignments (Variables):**
    - None

#### AU-7(1): Audit Record Reduction and Report Generation | Automatic Processing
- **Control Statement:** Provide and implement the capability to process, sort, and search audit records for events of interest based on the defined fields within audit records.
- **Organizational Assignments (Variables):**
    - defined fields within audit records

### AU-8: Time Stamps

#### AU-8(a): Time Stamps - a
- **Control Statement:** Use internal system clocks to generate time stamps for audit records
- **Organizational Assignments (Variables):**
    - None

#### AU-8(b): Time Stamps - b
- **Control Statement:** Record time stamps for audit records that meet defined granularity of time measurement and that use Coordinated Universal Time, have a fixed local time offset from Coordinated Universal Time, or that include the local time offset as part of the time stamp
- **Organizational Assignments (Variables):**
    - defined granularity of time measurement

### AU-9: Protection of Audit Information

#### AU-9(a): Protection of Audit Information - a
- **Control Statement:** Protect audit information and audit logging tools from unauthorized access, modification, and deletion
- **Organizational Assignments (Variables):**
    - None

#### AU-9(b): Protection of Audit Information - b
- **Control Statement:** Alert defined personnel or roles upon detection of unauthorized access, modification, or deletion of audit information.
- **Organizational Assignments (Variables):**
    - defined personnel or roles (for alerting)

#### AU-9(2): Protection of Audit Information | Store on Separate Physical Systems or Components
- **Control Statement:** Store audit records defined frequency in a repository that is part of a physically different system or system component than the system or component being audited.
- **Organizational Assignments (Variables):**
    - defined frequency

#### AU-9(3): Protection of Audit Information | Cryptographic Protection
- **Control Statement:** Implement cryptographic mechanisms to protect the integrity of audit information and audit tools.
- **Organizational Assignments (Variables):**
    - None

#### AU-9(4): Protection of Audit Information | Access by Subset of Privileged Users
- **Control Statement:** Authorize access to management of audit logging functionality to only defined subset of privileged users or roles.
- **Organizational Assignments (Variables):**
    - defined subset of privileged users or roles

### AU-10: Non-repudiation

#### AU-10: Non-repudiation
- **Control Statement:** Provide irrefutable evidence that an individual or process acting on behalf of an individual has performed.
- **Organizational Assignments (Variables):**
    - None

### AU-11: Audit Record Retention

#### AU-11: Audit Record Retention
- **Control Statement:** Retain audit records for defined time period consistent with records retention policy to provide support for after-the-fact investigations of incidents and to meet regulatory and organizational information retention requirements.
- **Organizational Assignments (Variables):**
    - defined time period

### AU-12: Audit Record Generation

#### AU-12(a): Audit Record Generation - a
- **Control Statement:** Provide audit record generation capability for the event types the system is capable of auditing as defined in AU-2a.
- **Organizational Assignments (Variables):**
    - None

#### AU-12(b): Audit Record Generation - b
- **Control Statement:** Allow defined personnel or roles to select the event types that are to be logged by specific components of the system.
- **Organizational Assignments (Variables):**
    - defined personnel or roles (for selection)

#### AU-12(c): Audit Record Generation - c
- **Control Statement:** Generate audit records for the event types defined in AU-2c that include the audit record content defined in AU-3.
- **Organizational Assignments (Variables):**
    - None

#### AU-12(1): Audit Record Generation | System-wide and Time-correlated Audit Trail
- **Control Statement:** Compile audit records from defined system components into a system-wide (logical or physical) audit trail that is time-correlated to within a defined level of tolerance for the relationship between time stamps of individual records in the audit trail.
- **Organizational Assignments (Variables):**
    - defined system components
    - defined level of tolerance

#### AU-12(3): Audit Record Generation | Changes by Authorized Individuals
- **Control Statement:** Provide and implement the capability for defined individuals or roles to change the logging to be performed on defined system components based on selectable event criteria within defined time thresholds.
- **Organizational Assignments (Variables):**
    - defined individuals or roles
    - defined system components
    - defined time thresholds

## CA: Assessment, Authorization, and Monitoring

### CA-2: Control Assessments

#### CA-2(3): Control Assessments | Leveraging Results from External Organizations
- **Control Statement:** Use the results of control assessments conducted by an external organization on a specific system, provided that the assessment meets the requirements defined by your organization.
- **Organizational Assignments (Variables):**
    - requirements defined by your organization

### CA-7: Continuous Monitoring

#### CA-7(a): Continuous Monitoring - a
- **Control Statement:** Establish the system-level metrics to be monitored, as defined by your organization.
- **Organizational Assignments (Variables):**
    - system-level metrics to be monitored, as defined by your organization

## CM: Configuration Management

### CM-2: Baseline Configuration

#### CM-2(a): Baseline Configuration - a
- **Control Statement:** Develop, document, and maintain a current baseline configuration of the system under configuration control.
- **Organizational Assignments (Variables):**
    - None

#### CM-2(b): Baseline Configuration - b
- **Control Statement:** Review and update the baseline configuration of the system at a frequency defined by your organization, when required due to specified circumstances, and whenever system components are installed or upgraded.
- **Organizational Assignments (Variables):**
    - frequency defined by your organization
    - specified circumstances

#### CM-2(2): Baseline Configuration | Automation Support for Accuracy and Currency
- **Control Statement:** Maintain the currency, completeness, accuracy, and availability of the baseline configuration of the system using automated mechanisms defined by your organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization

#### CM-2(3): Baseline Configuration | Retention of Previous Configurations
- **Control Statement:** Retain a specified number of previous versions of the baseline configurations of the system, as defined by your organization, to support rollback.
- **Organizational Assignments (Variables):**
    - specified number of previous versions
    - defined by your organization (for retention)

#### CM-2(7)(a): Baseline Configuration | Configure Systems and Components for High-risk Areas - a
- **Control Statement:** Issue designated systems or system components with specific configurations to individuals traveling to locations identified by your organization as having significant risk.
- **Organizational Assignments (Variables):**
    - designated systems or system components
    - locations identified by your organization as having significant risk

#### CM-2(7)(b): Baseline Configuration | Configure Systems and Components for High-risk Areas - b
- **Control Statement:** Apply the specified controls to the systems or components when individuals return from travel, as defined by your organization.
- **Organizational Assignments (Variables):**
    - specified controls
    - as defined by your organization (for application of controls)

### CM-3: Configuration Change Control

#### CM-3(a): Configuration Change Control - a
- **Control Statement:** Determine and document the types of changes to the system that are configuration-controlled;
- **Organizational Assignments (Variables):**
    - types of changes to the system that are configuration-controlled

#### CM-3(b): Configuration Change Control - b
- **Control Statement:** Review proposed configuration-controlled changes to the system and approve or disapprove such changes with explicit consideration for security and privacy impact analyses;
- **Organizational Assignments (Variables):**
    - None

#### CM-3(c): Configuration Change Control - c
- **Control Statement:** Document configuration change decisions associated with the system;
- **Organizational Assignments (Variables):**
    - None

#### CM-3(d): Configuration Change Control - d
- **Control Statement:** Implement approved configuration-controlled changes to the system;
- **Organizational Assignments (Variables):**
    - None

#### CM-3(e): Configuration Change Control - e
- **Control Statement:** Retain records of configuration-controlled changes to the system for a time period defined by your organization.
- **Organizational Assignments (Variables):**
    - time period defined by your organization

#### CM-3(f): Configuration Change Control - f
- **Control Statement:** Monitor and review activities related to configuration-controlled changes to the system.
- **Organizational Assignments (Variables):**
    - None

#### CM-3(g): Configuration Change Control - g
- **Control Statement:** Coordinate and provide oversight for configuration change control activities through a designated configuration change control element that convenes at a frequency defined by your organization or when specified configuration change conditions are met.
- **Organizational Assignments (Variables):**
    - frequency defined by your organization
    - specified configuration change conditions

#### CM-3(1)(a): Configuration Change Control | Automated Documentation, Notification, and Prohibition of Changes - a
- **Control Statement:** Use automated mechanisms defined by your organization to document proposed changes to the system;
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization

#### CM-3(1)(b): Configuration Change Control | Automated Documentation, Notification, and Prohibition of Changes - b
- **Control Statement:** Use automated mechanisms defined by your organization to notify designated approval authorities of proposed changes to the system and request their approval
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization
    - designated approval authorities

#### CM-3(1)(c): Configuration Change Control | Automated Documentation, Notification, and Prohibition of Changes - c
- **Control Statement:** Use automated mechanisms defined by your organization to highlight proposed changes to the system that have not been approved or disapproved within a specified time period
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization
    - specified time period

#### CM-3(1)(d): Configuration Change Control | Automated Documentation, Notification, and Prohibition of Changes - d
- **Control Statement:** Use automated mechanisms defined by your organization to prohibit changes to the system until designated approvals are received.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization

#### CM-3(1)(e): Configuration Change Control | Automated Documentation, Notification, and Prohibition of Changes - e
- **Control Statement:** Use automated mechanisms defined by your organization to document all changes to the system.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization

#### CM-3(1)(f): Configuration Change Control | Automated Documentation, Notification, and Prohibition of Changes - f
- **Control Statement:** Use automated mechanisms defined by your organization to notify designated personnel when approved changes to the system are completed
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization
    - designated personnel

#### CM-3(2): Configuration Change Control | Testing, Validation, and Documentation of Changes
- **Control Statement:** Test, validate, and document changes to the system before finalizing the implementation of the changes.
- **Organizational Assignments (Variables):**
    - None

#### CM-3(4): Configuration Change Control | Security and Privacy Representatives
- **Control Statement:** Require designated security and privacy representatives to be members of the specified configuration change control element.
- **Organizational Assignments (Variables):**
    - specified configuration change control element

#### CM-3(6): Configuration Change Control | Cryptography Management
- **Control Statement:** Ensure that cryptographic mechanisms used to provide the specified controls are under configuration management as defined by your organization.
- **Organizational Assignments (Variables):**
    - specified controls
    - as defined by your organization (for configuration management)

### CM-4: Impact Analyses

#### CM-4: Impact Analyses
- **Control Statement:** Analyze changes to the system to determine potential security and privacy impacts prior to change implementation.
- **Organizational Assignments (Variables):**
    - None

#### CM-4(1): Impact Analyses | Separate Test Environments
- **Control Statement:** Analyze changes to the system in a separate test environment before implementation in an operational environment, looking for security and privacy impacts due to flaws, weaknesses, incompatibility, or intentional malice.
- **Organizational Assignments (Variables):**
    - None

#### CM-4(2): Impact Analyses | Verification of Controls
- **Control Statement:** After system changes, verify that the impacted controls are implemented correctly, operating as intended, and producing the desired outcome with regard to meeting the security and privacy requirements for the system.
- **Organizational Assignments (Variables):**
    - None

### CM-5: Access Restrictions for Change

#### CM-5: Access Restrictions for Change
- **Control Statement:** Define, document, approve, and enforce physical and logical access restrictions associated with changes to the system.
- **Organizational Assignments (Variables):**
    - None

#### CM-5(1)(a): Access Restrictions for Change | Automated Access Enforcement and Audit Records - a
- **Control Statement:** Enforce access restrictions using automated mechanisms defined by your organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization

#### CM-5(1)(b): Access Restrictions for Change | Automated Access Enforcement and Audit Records - b
- **Control Statement:** Automatically generate audit records of the enforcement actions.
- **Organizational Assignments (Variables):**
    - None

#### CM-5(5)(a): Access Restrictions for Change | Privilege Limitation for Production and Operation - a
- **Control Statement:** Limit privileges to change system components and system-related information within a production or operational environment.
- **Organizational Assignments (Variables):**
    - None

#### CM-5(5)(b): Access Restrictions for Change | Privilege Limitation for Production and Operation - b
- **Control Statement:** Review and reevaluate privileges at a frequency defined by your organization.
- **Organizational Assignments (Variables):**
    - frequency defined by your organization

### CM-6: Configuration Settings

#### CM-6(a): Configuration Settings - a
- **Control Statement:** Establish and document configuration settings for components used within the system that reflect the most restrictive mode consistent with operational requirements, using common secure configurations defined by your organization.
- **Organizational Assignments (Variables):**
    - common secure configurations defined by your organization

#### CM-6(b): Configuration Settings - b
- **Control Statement:** Implement the configuration settings;
- **Organizational Assignments (Variables):**
    - None

#### CM-6(c): Configuration Settings - c
- **Control Statement:** Identify, document, and approve any deviations from established configuration settings for designated system components based on specified operational requirements defined by your organization.
- **Organizational Assignments (Variables):**
    - designated system components
    - specified operational requirements defined by your organization

#### CM-6(d): Configuration Settings - d
- **Control Statement:** Monitor and control changes to the configuration settings in accordance with your organization's policies and procedures.
- **Organizational Assignments (Variables):**
    - None

#### CM-6(1): Configuration Settings | Automated Management, Application, and Verification
- **Control Statement:** Manage, apply, and verify configuration settings for designated system components using automated mechanisms defined by your organization.
- **Organizational Assignments (Variables):**
    - designated system components
    - automated mechanisms defined by your organization

#### CM-6(2): Configuration Settings | Respond to Unauthorized Changes
- **Control Statement:** Take the specified actions in response to unauthorized changes to the configuration settings defined by your organization.
- **Organizational Assignments (Variables):**
    - specified actions
    - configuration settings defined by your organization

### CM-7: Least Functionality

#### CM-7(a): Least Functionality - a
- **Control Statement:** Configure the system to provide only the mission-essential capabilities defined by your organization.
- **Organizational Assignments (Variables):**
    - mission-essential capabilities defined by your organization

#### CM-7(b): Least Functionality - b
- **Control Statement:** Prohibit or restrict the use of the specified functions, ports, protocols, software, and services defined by your organization.
- **Organizational Assignments (Variables):**
    - specified functions, ports, protocols, software, and services defined by your organization

#### CM-7(1)(a): Least Functionality | Periodic Review - a
- **Control Statement:** Review the system at a frequency defined by your organization to identify unnecessary and/or nonsecure functions, ports, protocols, software, and services.
- **Organizational Assignments (Variables):**
    - frequency defined by your organization

#### CM-7(1)(b): Least Functionality | Periodic Review - b
- **Control Statement:** Disable or remove the specified functions, ports, protocols, software, and services within the system that are deemed unnecessary and/or nonsecure, as defined by your organization.
- **Organizational Assignments (Variables):**
    - specified functions, ports, protocols, software, and services
    - as defined by your organization (for unnecessary/nonsecure definition)

#### CM-7(2): Least Functionality | Prevent Program Execution
- **Control Statement:** Prevent program execution in accordance with the policies, rules of behavior, and access agreements regarding software program usage and restrictions defined by your organization, as well as the rules authorizing the terms and conditions of software program usage.
- **Organizational Assignments (Variables):**
    - policies, rules of behavior, and access agreements regarding software program usage and restrictions defined by your organization

#### CM-7(5)(a): Least Functionality | Authorized Software — Allow-by-exception - a
- **Control Statement:** Identify the software programs authorized to execute on the system, as defined by your organization.
- **Organizational Assignments (Variables):**
    - software programs authorized to execute on the system, as defined by your organization

#### CM-7(5)(b): Least Functionality | Authorized Software — Allow-by-exception - b
- **Control Statement:** Employ a deny-all, permit-by-exception policy to allow the execution of authorized software programs on the system; and
- **Organizational Assignments (Variables):**
    - None

#### CM-7(5)(c): Least Functionality | Authorized Software — Allow-by-exception - c
- **Control Statement:** Review and update the list of authorized software programs at a frequency defined by your organization.
- **Organizational Assignments (Variables):**
    - frequency defined by your organization

### CM-8: System Component Inventory

#### CM-8(a): System Component Inventory - a
- **Control Statement:** Develop and document an inventory of system components that accurately reflects the system and includes all components within it. Ensure that the inventory does not include duplicate entries for components or those assigned to other systems, and maintain the level of granularity necessary for tracking and reporting. The inventory should also include information deemed necessary by your organization to achieve effective system component accountability.
- **Organizational Assignments (Variables):**
    - information deemed necessary by your organization

#### CM-8(b): System Component Inventory - b
- **Control Statement:** Review and update the system component inventory at a frequency defined by your organization.
- **Organizational Assignments (Variables):**
    - frequency defined by your organization

#### CM-8(1): System Component Inventory | Updates During Installation and Removal
- **Control Statement:** Update the inventory of system components as part of component installations, removals, and system updates.
- **Organizational Assignments (Variables):**
    - None

#### CM-8(2): System Component Inventory | Automated Maintenance
- **Control Statement:** Maintain the currency, completeness, accuracy, and availability of the inventory of system components using automated mechanisms defined by your organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization

#### CM-8(3)(a): System Component Inventory | Automated Unauthorized Component Detection - a
- **Control Statement:** Detect the presence of unauthorized hardware, software, and firmware components within the system using automated mechanisms defined by your organization at a frequency specified by your organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by your organization
    - frequency specified by your organization

#### CM-8(3)(b): System Component Inventory | Automated Unauthorized Component Detection - b
- **Control Statement:** Take the specified actions when unauthorized components are detected, including disabling network access for such components, isolating the components, and notifying designated personnel or roles defined by your organization.
- **Organizational Assignments (Variables):**
    - specified actions
    - designated personnel or roles defined by your organization

#### CM-8(4): System Component Inventory | Accountability Information
- **Control Statement:** Include in the system component inventory a means for identifying individuals responsible and accountable for administering those components by their name, position, or role, as defined by your organization.
- **Organizational Assignments (Variables):**
    - by their name, position, or role, as defined by your organization

## CP: Contingency Planning

### CP-1: Policy and Procedures

#### CP-1(a): Policy and Procedures - a
- **Control Statement:** Develop, document, and share a contingency planning policy with designated personnel or roles that addresses its purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance. Ensure that the policy is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines. Include procedures that facilitate the implementation of the contingency planning policy and the associated controls.
- **Organizational Assignments (Variables):**
    - designated personnel or roles
    - applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### CP-1(b): Policy and Procedures - b
- **Control Statement:** Designate an official to manage the development, documentation, and dissemination of the contingency planning policy and procedures.
- **Organizational Assignments (Variables):**
    - official

#### CP-1(c): Policy and Procedures - c
- **Control Statement:** Review and update the current contingency planning policy at a defined frequency and following specified events. Review and update the procedures at a defined frequency and following specified events.
- **Organizational Assignments (Variables):**
    - defined frequency (Policy)
    - specified events (Policy)
    - defined frequency (Procedures)
    - specified events (Procedures)

### CP-2: Contingency Plan

#### CP-2(a): Contingency Plan - a
- **Control Statement:** "Develop a contingency plan for the system that: Identifies essential mission and business functions and associated contingency requirements. Provides recovery objectives, restoration priorities, and metrics. Addresses contingency roles, responsibilities, and assigned individuals with contact information. Ensures the maintenance of essential mission and business functions despite system disruptions, compromises, or failures. Addresses the eventual, full system restoration without deterioration of the originally planned and implemented controls. Addresses the sharing of contingency information. Is reviewed and approved by designated personnel or roles."
- **Organizational Assignments (Variables):**
    - essential mission and business functions and associated contingency requirements
    - designated personnel or roles (for review and approval)

#### CP-2(b): Contingency Plan - b
- **Control Statement:** Distribute copies of the contingency plan to key contingency personnel and organizational elements as defined by the organization.
- **Organizational Assignments (Variables):**
    - organizational elements as defined by the organization

#### CP-2(c): Contingency Plan - c
- **Control Statement:** Coordinate contingency planning activities with incident handling activities;
- **Organizational Assignments (Variables):**
    - None

#### CP-2(d): Contingency Plan - d
- **Control Statement:** Review the contingency plan for the system at a defined frequency to ensure it remains current and effective.
- **Organizational Assignments (Variables):**
    - defined frequency

#### CP-2(e): Contingency Plan - e
- **Control Statement:** Update the contingency plan to reflect changes in the organization, system, or environment of operation, as well as issues encountered during its implementation, execution, or testing.
- **Organizational Assignments (Variables):**
    - None

#### CP-2(f): Contingency Plan - f
- **Control Statement:** Communicate changes to the contingency plan to key contingency personnel and organizational elements as defined by the organization.
- **Organizational Assignments (Variables):**
    - organizational elements as defined by the organization

#### CP-2(g): Contingency Plan - g
- **Control Statement:** Incorporate lessons learned from contingency plan testing, training, or actual contingency activities into future contingency testing and training.
- **Organizational Assignments (Variables):**
    - None

#### CP-2(h): Contingency Plan - h
- **Control Statement:** Protect the contingency plan from unauthorized access, disclosure, and modification.
- **Organizational Assignments (Variables):**
    - None

#### CP-2(1): Contingency Plan | Coordinate with Related Plans
- **Control Statement:** Coordinate contingency plan development with organizational elements responsible for related plans.
- **Organizational Assignments (Variables):**
    - None

#### CP-2(2): Contingency Plan | Capacity Planning
- **Control Statement:** Conduct capacity planning so that necessary capacity for information processing, telecommunications, and environmental support exists during contingency operations.
- **Organizational Assignments (Variables):**
    - None

#### CP-2(3): Contingency Plan | Resume Mission and Business Functions
- **Control Statement:** Plan for the resumption of all essential mission and business functions within a time period defined by the organization following the activation of the contingency plan.
- **Organizational Assignments (Variables):**
    - time period defined by the organization

#### CP-2(5): Contingency Plan | Continue Mission and Business Functions
- **Control Statement:** Plan for the continuance of all essential mission and business functions with minimal or no loss of operational continuity, and ensure that continuity is maintained until full system restoration at primary processing and/or storage sites.
- **Organizational Assignments (Variables):**
    - None

#### CP-2(8): Contingency Plan | Identify Critical Assets
- **Control Statement:** Identify critical system assets that support all essential mission and business functions.
- **Organizational Assignments (Variables):**
    - None

### CP-3: Contingency Training

#### CP-3(a): Contingency Training - a
- **Control Statement:** "Provide contingency training to system users based on their assigned roles and responsibilities: - Within a time period defined by the organization after assuming a contingency role or responsibility; - When required by system changes; and - At a frequency defined by the organization thereafter."
- **Organizational Assignments (Variables):**
    - time period defined by the organization (after assuming role)
    - frequency defined by the organization (thereafter)

#### CP-3(b): Contingency Training - b
- **Control Statement:** Review and update contingency training content at a frequency defined by the organization and following events specified by the organization.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization
    - events specified by the organization

#### CP-3(1): Contingency Training | Simulated Events
- **Control Statement:** Incorporate simulated events into contingency training to facilitate effective response by personnel in crisis situations.
- **Organizational Assignments (Variables):**
    - None

### CP-4: Contingency Plan Testing

#### CP-4(a): Contingency Plan Testing - a
- **Control Statement:** Test the contingency plan for the system at a frequency defined by the organization using specific tests defined by the organization to evaluate the effectiveness of the plan and readiness to execute it.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization
    - specific tests defined by the organization

#### CP-4(b): Contingency Plan Testing - b
- **Control Statement:** Review the results of the contingency plan test.
- **Organizational Assignments (Variables):**
    - None

#### CP-4(c): Contingency Plan Testing - c
- **Control Statement:** Initiate corrective actions if necessary.
- **Organizational Assignments (Variables):**
    - None

#### CP-4(1): Contingency Plan Testing | Coordinate with Related Plans
- **Control Statement:** Coordinate contingency plan testing with organizational elements responsible for related plans.
- **Organizational Assignments (Variables):**
    - None

#### CP-4(2)(a): Contingency Plan Testing | Alternate Processing Site - a
- **Control Statement:** Test the contingency plan at the alternate processing site to familiarize contingency personnel with the facility and available resources.
- **Organizational Assignments (Variables):**
    - None

#### CP-4(2)(b): Contingency Plan Testing | Alternate Processing Site - b
- **Control Statement:** Test the contingency plan at the alternate processing site to evaluate the capabilities of the site to support contingency operations.
- **Organizational Assignments (Variables):**
    - None

### CP-6: Alternate Storage Site

#### CP-6(a): Alternate Storage Site - a
- **Control Statement:** Establish an alternate storage site and make necessary agreements to enable the storage and retrieval of system backup information.
- **Organizational Assignments (Variables):**
    - None

#### CP-6(b): Alternate Storage Site - b
- **Control Statement:** Ensure that the alternate storage site provides controls equivalent to that of the primary site.
- **Organizational Assignments (Variables):**
    - None

#### CP-6(1): Alternate Storage Site | Separation from Primary Site
- **Control Statement:** Identify an alternate storage site that is sufficiently separated from the primary storage site to reduce susceptibility to the same threats.
- **Organizational Assignments (Variables):**
    - None

#### CP-6(2): Alternate Storage Site | Recovery Time and Recovery Point Objectives
- **Control Statement:** Configure the alternate storage site to facilitate recovery operations in accordance with recovery time and recovery point objectives.
- **Organizational Assignments (Variables):**
    - None

#### CP-6(3): Alternate Storage Site | Accessibility
- **Control Statement:** Identify potential accessibility problems to the alternate storage site in the event of an area-wide disruption or disaster and outline explicit mitigation actions.
- **Organizational Assignments (Variables):**
    - None

### CP-7: Alternate Processing Site

#### CP-7(a): Alternate Processing Site - a
- **Control Statement:** Establish an alternate processing site and make necessary agreements to enable the transfer and resumption of defined system operations for essential mission and business functions within a time period defined by the organization, consistent with recovery time and recovery point objectives, when primary processing capabilities are unavailable.
- **Organizational Assignments (Variables):**
    - defined system operations
    - time period defined by the organization

#### CP-7(b): Alternate Processing Site - b
- **Control Statement:** Make the equipment and supplies required to transfer and resume operations available at the alternate processing site, or establish contracts to ensure delivery to the site within the time period defined by the organization for transfer and resumption.
- **Organizational Assignments (Variables):**
    - time period defined by the organization

#### CP-7(c): Alternate Processing Site - c
- **Control Statement:** Provide controls at the alternate processing site that are equivalent to those at the primary site.
- **Organizational Assignments (Variables):**
    - None

#### CP-7(1): Alternate Processing Site | Separation from Primary Site
- **Control Statement:** Identify an alternate processing site that is sufficiently separated from the primary processing site to reduce susceptibility to the same threats.
- **Organizational Assignments (Variables):**
    - None

#### CP-7(2): Alternate Processing Site | Accessibility
- **Control Statement:** Identify potential accessibility problems to alternate processing sites in the event of an area-wide disruption or disaster and outlines explicit mitigation actions.
- **Organizational Assignments (Variables):**
    - None

#### CP-7(3): Alternate Processing Site | Priority of Service
- **Control Statement:** Develop alternate processing site agreements that include priority-of-service provisions based on availability requirements, including recovery time objectives.
- **Organizational Assignments (Variables):**
    - None

#### CP-7(4): Alternate Processing Site | Preparation for Use
- **Control Statement:** Prepare the alternate processing site to serve as the operational site supporting essential mission and business functions.
- **Organizational Assignments (Variables):**
    - None

### CP-8: Telecommunications Services

#### CP-8: Telecommunications Services
- **Control Statement:** Establish alternate telecommunications services and make necessary agreements to enable the resumption of defined system operations for essential mission and business functions within a time period defined by the organization, when primary telecommunications capabilities are unavailable at either the primary or alternate processing or storage sites.
- **Organizational Assignments (Variables):**
    - defined system operations
    - time period defined by the organization

#### CP-8(1)(a): Telecommunications Services | Priority of Service Provisions - a
- **Control Statement:** Develop primary and alternate telecommunications service agreements that include priority-of-service provisions based on availability requirements, including recovery time objectives.
- **Organizational Assignments (Variables):**
    - None

### CP-9: System Backup

#### CP-9(a): System Backup - a
- **Control Statement:** Conduct backups of user-level information contained in defined system components at a frequency specified by the organization, consistent with recovery time and recovery point objectives.
- **Organizational Assignments (Variables):**
    - defined system components
    - frequency specified by the organization

#### CP-9(b): System Backup - b
- **Control Statement:** Conduct backups of system-level information contained in the system at a frequency defined by the organization, consistent with recovery time and recovery point objectives.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization

#### CP-9(c): System Backup - c
- **Control Statement:** Conduct backups of system documentation, including security- and privacy-related documentation, at a frequency defined by the organization, consistent with recovery time and recovery point objectives.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization

#### CP-9(d): System Backup - d
- **Control Statement:** Protect the confidentiality, integrity, and availability of backup information.
- **Organizational Assignments (Variables):**
    - None

#### CP-9(1): System Backup | Testing for Reliability and Integrity
- **Control Statement:** Test backup information at a frequency defined by the organization to verify media reliability and information integrity.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization

#### CP-9(2): System Backup | Test Restoration Using Sampling
- **Control Statement:** Use a sample of backup information in the restoration of selected system functions as part of contingency plan testing.
- **Organizational Assignments (Variables):**
    - None

#### CP-9(3): System Backup | Separate Storage for Critical Information
- **Control Statement:** Store backup copies of organization-defined critical system software and other security-related information in a separate facility or in a fire-rated container that is not collocated with the operational system.
- **Organizational Assignments (Variables):**
    - organization-defined critical system software

#### CP-9(5): System Backup | Transfer to Alternate Storage Site
- **Control Statement:** Transfer system backup information to the alternate storage site within an organization-defined time period and transfer rate consistent with the recovery time and recovery point objectives.
- **Organizational Assignments (Variables):**
    - organization-defined time period
    - transfer rate

#### CP-9(8): System Backup | Cryptographic Protection
- **Control Statement:** Implement cryptographic mechanisms to prevent unauthorized disclosure and modification of organization-defined backup information.
- **Organizational Assignments (Variables):**
    - organization-defined backup information

### CP-10: System Recovery and Reconstitution

#### CP-10: System Recovery and Reconstitution
- **Control Statement:** Provide for the recovery and reconstitution of the system to a known state within an organization-defined time period consistent with recovery time and recovery point objectives after a disruption, compromise, or failure.
- **Organizational Assignments (Variables):**
    - organization-defined time period

## IA: Identification and Authentication

### IA-1: Policy and Procedures

#### IA-1(a): Policy and Procedures - a
- **Control Statement:** Develop, document, and disseminate to designated personnel or roles an identification and authentication policy that addresses the purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance. The policy must be consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines. Additionally, include procedures to facilitate the implementation of the identification and authentication policy and the associated controls at the organization, mission/business process, or system level.
- **Organizational Assignments (Variables):**
    - designated personnel or roles
    - applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### IA-1(b): Policy and Procedures - b
- **Control Statement:** Designate an official defined by the organization to manage the development, documentation, and dissemination of the identification and authentication policy and procedures.
- **Organizational Assignments (Variables):**
    - official defined by the organization

#### IA-1(c): Policy and Procedures - c
- **Control Statement:** Review and update the current identification and authentication policy at a frequency defined by the organization and following specific events defined by the organization. Additionally, review and update the procedures at a frequency defined by the organization and following specific events defined by the organization.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization (Policy)
    - specific events defined by the organization (Policy)
    - frequency defined by the organization (Procedures)
    - specific events defined by the organization (Procedures)

### IA-2: Identification and Authentication (organizational Users)

#### IA-2: Identification and Authentication (organizational Users)
- **Control Statement:** Uniquely identify and authenticate organizational users and associate that unique identification with processes acting on behalf of those users.
- **Organizational Assignments (Variables):**
    - None

#### IA-2(1): Identification and Authentication (organizational Users) | Multi-factor Authentication to Privileged Accounts
- **Control Statement:** Implement multi-factor authentication for access to privileged accounts.
- **Organizational Assignments (Variables):**
    - None

#### IA-2(2): Identification and Authentication (organizational Users) | Multi-factor Authentication to Non-privileged Accounts
- **Control Statement:** Implement multi-factor authentication for access to non-privileged accounts.
- **Organizational Assignments (Variables):**
    - None

#### IA-2(5): Identification and Authentication (organizational Users) | Individual Authentication with Group Authentication
- **Control Statement:** When shared accounts or authenticators are employed, require users to be individually authenticated before granting access to the shared accounts or resources.
- **Organizational Assignments (Variables):**
    - None

#### IA-2(6)(a): Identification and Authentication (organizational Users) | Access to Accounts – Separate Device - a
- **Control Statement:** Implement multi-factor authentication for local, network, and remote access to privileged and non-privileged accounts such that one of the factors is provided by a device separate from the system gaining access.
- **Organizational Assignments (Variables):**
    - None

#### IA-2(6)(b): Identification and Authentication (organizational Users) | Access to Accounts – Separate Device - b
- **Control Statement:** Implement multi-factor authentication for local, network, and remote access to privileged and non-privileged accounts such that the device meets the strength of mechanism requirements defined by the organization.
- **Organizational Assignments (Variables):**
    - strength of mechanism requirements defined by the organization

#### IA-2(8): Identification and Authentication (organizational Users) | Access to Accounts — Replay Resistant
- **Control Statement:** Implement replay-resistant authentication mechanisms for access to privileged and non-privileged accounts.
- **Organizational Assignments (Variables):**
    - None

#### IA-2(12): Identification and Authentication (organizational Users) | Acceptance of PIV Credentials
- **Control Statement:** Accept and electronically verify Personal Identity Verification-compliant credentials.
- **Organizational Assignments (Variables):**
    - None

### IA-4: Identifier Management

#### IA-4(a): Identifier Management - a
- **Control Statement:** Manage system identifiers by receiving authorization from designated personnel or roles defined by the organization to assign an individual, group, role, service, or device identifier.
- **Organizational Assignments (Variables):**
    - designated personnel or roles defined by the organization

#### IA-4(b): Identifier Management - b
- **Control Statement:** Manage system identifiers by selecting an identifier that uniquely identifies an individual, group, role, service, or device.
- **Organizational Assignments (Variables):**
    - None

#### IA-4(c): Identifier Management - c
- **Control Statement:** Manage system identifiers by assigning the identifier to the intended individual, group, role, service, or device.
- **Organizational Assignments (Variables):**
    - None

#### IA-4(d): Identifier Management - d
- **Control Statement:** Manage system identifiers by preventing reuse of identifiers for a time period defined by the organization.
- **Organizational Assignments (Variables):**
    - time period defined by the organization

#### IA-4(4): Identifier Management | Identify User Status
- **Control Statement:** Manage individual identifiers by uniquely identifying each individual based on a characteristic defined by the organization that identifies individual status.
- **Organizational Assignments (Variables):**
    - characteristic defined by the organization

### IA-5: Authenticator Management

#### IA-5(a): Authenticator Management - a
- **Control Statement:** "Manage system authenticators by: Verifying, as part of the initial authenticator distribution, the identity of the individual, group, role, service, or device receiving the authenticator."
- **Organizational Assignments (Variables):**
    - None

#### IA-5(b): Authenticator Management - b
- **Control Statement:** "Manage system authenticators by: Establishing initial authenticator content for any authenticators issued by the organization."
- **Organizational Assignments (Variables):**
    - None

#### IA-5(c): Authenticator Management - c
- **Control Statement:** "Manage system authenticators by: Ensuring that authenticators have sufficient strength of mechanism for their intended use."
- **Organizational Assignments (Variables):**
    - None

#### IA-5(d): Authenticator Management - d
- **Control Statement:** "Manage system authenticators by: Establishing and implementing administrative procedures for initial authenticator distribution, as well as for lost, compromised, or damaged authenticators, and for revoking authenticators. Changing default authenticators prior to first use."
- **Organizational Assignments (Variables):**
    - None

#### IA-5(e): Authenticator Management - e
- **Control Statement:** "Manage system authenticators by: Changing default authenticators prior to first use."
- **Organizational Assignments (Variables):**
    - None

#### IA-5(f): Authenticator Management - f
- **Control Statement:** "Manage system authenticators by: Changing or refreshing authenticators at a time period defined by the organization for each authenticator type or when specific events defined by the organization occur."
- **Organizational Assignments (Variables):**
    - time period defined by the organization for each authenticator type
    - specific events defined by the organization

#### IA-5(g): Authenticator Management - g
- **Control Statement:** "Manage system authenticators by: Protecting authenticator content from unauthorized disclosure and modification."
- **Organizational Assignments (Variables):**
    - None

#### IA-5(h): Authenticator Management - h
- **Control Statement:** "Manage system authenticators by: Requiring individuals to take, and having devices implement, specific controls to protect authenticators."
- **Organizational Assignments (Variables):**
    - specific controls

#### IA-5(i): Authenticator Management - i
- **Control Statement:** "Manage system authenticators by: Changing authenticators for group or role accounts when membership to those accounts changes."
- **Organizational Assignments (Variables):**
    - None

## IR: Incident Response

### IR-1: Policy and Procedures

#### IR-1(a): Policy and Procedures - a
- **Control Statement:** Develop, document, and disseminate to designated personnel or roles an incident response policy that addresses the purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance. The policy must be consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines. Additionally, include procedures to facilitate the implementation of the incident response policy and the associated incident response controls at the organization, mission/business process, or system level.
- **Organizational Assignments (Variables):**
    - designated personnel or roles
    - applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### IR-1(b): Policy and Procedures - b
- **Control Statement:** Designate an official defined by the organization to manage the development, documentation, and dissemination of the incident response policy and procedures.
- **Organizational Assignments (Variables):**
    - official defined by the organization

#### IR-1(c): Policy and Procedures - c
- **Control Statement:** Review and update the current incident response policy at a frequency defined by the organization and following specific events defined by the organization. Additionally, review and update the procedures at a frequency defined by the organization and following specific events defined by the organization.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization (Policy)
    - specific events defined by the organization (Policy)
    - frequency defined by the organization (Procedures)
    - specific events defined by the organization (Procedures)

### IR-2: Incident Response Training

#### IR-2(a): Incident Response Training - a
- **Control Statement:** Provide incident response training to system users consistent with assigned roles and responsibilities within a time period defined by the organization of assuming an incident response role or responsibility or acquiring system access, when required by system changes, and at a frequency defined by the organization thereafter.
- **Organizational Assignments (Variables):**
    - time period defined by the organization
    - frequency defined by the organization

#### IR-2(b): Incident Response Training - b
- **Control Statement:** Review and update incident response training content at a frequency defined by the organization and following specific events defined by the organization.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization
    - specific events defined by the organization

#### IR-2(1): Incident Response Training | Simulated Events
- **Control Statement:** Incorporate simulated events into incident response training to facilitate the required response by personnel in crisis situations.
- **Organizational Assignments (Variables):**
    - None

#### IR-2(2): Incident Response Training | Automated Training Environments
- **Control Statement:** Provide an incident response training environment using automated mechanisms defined by the organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by the organization

### IR-3: Incident Response Testing

#### IR-3: Incident Response Testing
- **Control Statement:** Test the effectiveness of the incident response capability for the system at a frequency defined by the organization using tests defined by the organization.
- **Organizational Assignments (Variables):**
    - frequency defined by the organization
    - tests defined by the organization

#### IR-3(2): Incident Response Testing | Coordination with Related Plans
- **Control Statement:** Coordinate incident response testing with organizational elements responsible for related plans.
- **Organizational Assignments (Variables):**
    - None

### IR-4: Incident Handling

#### IR-4(a): Incident Handling - a
- **Control Statement:** Implement an incident handling capability for incidents that is consistent with the incident response plan and includes preparation, detection and analysis, containment, eradication, and recovery;
- **Organizational Assignments (Variables):**
    - None

#### IR-4(b): Incident Handling - b
- **Control Statement:** Coordinate incident handling activities with contingency planning activities;
- **Organizational Assignments (Variables):**
    - None

#### IR-4(c): Incident Handling - c
- **Control Statement:** Incorporate lessons learned from ongoing incident handling activities into incident response procedures, training, and testing, and implement the resulting changes accordingly.
- **Organizational Assignments (Variables):**
    - None

#### IR-4(d): Incident Handling - d
- **Control Statement:** Ensure the rigor, intensity, scope, and results of incident handling activities are comparable and predictable across the organization.
- **Organizational Assignments (Variables):**
    - None

#### IR-4(1): Incident Handling | Automated Incident Handling Processes
- **Control Statement:** Support the incident handling process using automated mechanisms defined by the organization.
- **Organizational Assignments (Variables):**
    - automated mechanisms defined by the organization

## PL: Planning

### PL-2: System Security and Privacy Plans

#### PL-2(a): System Security and Privacy Plans - a
- **Control Statement:** "Develop security and privacy plans for the system that: Are consistent with the organization’s enterprise architecture; Explicitly define the constituent system components; Describe the operational context of the system in terms of mission and business processes; Identify the individuals that fulfill system roles and responsibilities; Identify the information types processed, stored, and transmitted by the system; Provide the security categorization of the system, including supporting rationale; Describe any specific threats to the system that are of concern to the organization; Provide the results of a privacy risk assessment for systems processing personally identifiable information; Describe the operational environment for the system and any dependencies on or connections to other systems or system components; Provide an overview of the security and privacy requirements for the system; Identify any relevant control baselines or overlays, if applicable; Describe the controls in place or planned for meeting the security and privacy requirements, including a rationale for any tailoring decisions; Include risk determinations for security and privacy architecture and design decisions; Include security- and privacy-related activities affecting the system that require planning and coordination with organization-defined individuals or groups; and Are reviewed and approved by the authorizing official or designated representative prior to plan implementation."
- **Organizational Assignments (Variables):**
    - information types processed, stored, and transmitted by the system
    - specific threats to the system that are of concern to the organization
    - security- and privacy-related activities affecting the system that require planning and coordination with organization-defined individuals or groups

#### PL-2(b): System Security and Privacy Plans - b
- **Control Statement:** Distribute copies of the plans and communicate subsequent changes to the plans to organization-defined personnel or roles
- **Organizational Assignments (Variables):**
    - organization-defined personnel or roles

#### PL-2(c): System Security and Privacy Plans - c
- **Control Statement:** Review the plans organization-defined frequency.
- **Organizational Assignments (Variables):**
    - organization-defined frequency

#### PL-2(d): System Security and Privacy Plans - d
- **Control Statement:** Update the plans to address changes to the system and environment of operation or problems identified during plan implementation or control assessments.
- **Organizational Assignments (Variables):**
    - None

#### PL-2(e): System Security and Privacy Plans - e
- **Control Statement:** Protect the plans from unauthorized disclosure and modification.
- **Organizational Assignments (Variables):**
    - None

### PL-4: Rules of Behavior

#### PL-4(a): Rules of Behavior - a
- **Control Statement:** Establish and provide to individuals requiring access to the system, the rules that describe their responsibilities and expected behavior for information and system usage, security, and privacy.
- **Organizational Assignments (Variables):**
    - None

#### PL-4(b): Rules of Behavior - b
- **Control Statement:** Receive a documented acknowledgment from such individuals, indicating that they have read, understand, and agree to abide by the rules of behavior, before authorizing access to information and 1 the system.
- **Organizational Assignments (Variables):**
    - None

#### PL-4(c): Rules of Behavior - c
- **Control Statement:** Review and update the rules of behavior organization-defined frequency.
- **Organizational Assignments (Variables):**
    - organization-defined frequency

#### PL-4(d): Rules of Behavior - d
- **Control Statement:** Require individuals who have acknowledged a previous version of the rules of behavior to read and re-acknowledge at an organization-defined frequency when the rules are revised or updated.
- **Organizational Assignments (Variables):**
    - organization-defined frequency

#### PL-4(1)(a): Rules of Behavior | Social Media and External Site/application Usage Restrictions - a
- **Control Statement:** Include in the rules of behavior restrictions on the use of social media, social networking sites, and external sites or applications.
- **Organizational Assignments (Variables):**
    - None

## RA: Risk Assessment

### RA-1: Policy and Procedures

#### RA-1(a): Policy and Procedures - a
- **Control Statement:** Develop, document, and disseminate to organization-defined personnel or roles a risk assessment policy that addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance; is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines; and includes procedures to facilitate the implementation of the risk assessment policy and the associated risk assessment controls.
- **Organizational Assignments (Variables):**
    - organization-defined personnel or roles
    - applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### RA-1(b): Policy and Procedures - b
- **Control Statement:** Designate an organization-defined official to manage the development, documentation, and dissemination of the risk assessment policy and procedures.
- **Organizational Assignments (Variables):**
    - organization-defined official

#### RA-1(c): Policy and Procedures - c
- **Control Statement:** Review and update the current risk assessment policy at an organization-defined frequency and following organization-defined events, and review and update the procedures at an organization-defined frequency and following organization-defined events.
- **Organizational Assignments (Variables):**
    - organization-defined frequency (Policy)
    - organization-defined events (Policy)
    - organization-defined frequency (Procedures)
    - organization-defined events (Procedures)

### RA-2: Security Categorization

#### RA-2(a): Security Categorization - a
- **Control Statement:** Categorize the system and the information it processes, stores, and transmits.
- **Organizational Assignments (Variables):**
    - None

#### RA-2(b): Security Categorization - b
- **Control Statement:** Document the security categorization results, including supporting rationale, in the security plan for the system; and
- **Organizational Assignments (Variables):**
    - None

#### RA-2(c): Security Categorization - c
- **Control Statement:** Verify that the authorizing official or authorizing official designated representative reviews and approves the security categorization decision.
- **Organizational Assignments (Variables):**
    - None

### RA-3: Risk Assessment

#### RA-3(a): Risk Assessment - a
- **Control Statement:** Conduct a risk assessment, including identifying threats to and vulnerabilities in the system, determining the likelihood and magnitude of harm from unauthorized access, use, disclosure, disruption, modification, or destruction of the system, the information it processes, stores, or transmits, and any related information, and determining the likelihood and impact of adverse effects on individuals arising from the processing of personally identifiable information.
- **Organizational Assignments (Variables):**
    - None

#### RA-3(b): Risk Assessment - b
- **Control Statement:** Integrate risk assessment results and risk management decisions from the organization and mission or business process perspectives with system-level risk assessments.
- **Organizational Assignments (Variables):**
    - None

#### RA-3(c): Risk Assessment - c
- **Control Statement:** Document risk assessment results in security and privacy plans, risk assessment reports, and organization-defined documents.
- **Organizational Assignments (Variables):**
    - organization-defined documents

#### RA-3(d): Risk Assessment - d
- **Control Statement:** Review risk assessment results at an organization-defined frequency.
- **Organizational Assignments (Variables):**
    - organization-defined frequency

#### RA-3(f): Risk Assessment - f
- **Control Statement:** Update the risk assessment at an organization-defined frequency or when there are significant changes to the system, its environment of operation, or other conditions that may impact the security or privacy state of the system.
- **Organizational Assignments (Variables):**
    - organization-defined frequency

#### RA-3(1)(a): Risk Assessment | Supply Chain Risk Assessment - a
- **Control Statement:** Assess supply chain risks associated with organization-defined systems, system components, and system services.
- **Organizational Assignments (Variables):**
    - organization-defined systems, system components, and system services

## SC: System and Communications Protection

### SC-1: Policy and Procedures

#### SC-1(a): Policy and Procedures - a
- **Control Statement:** Develop, document, and disseminate to organization-defined personnel or roles organization-level, mission/business process-level, system-level system and communications protection policy that addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance, is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines, and includes procedures to facilitate the implementation of the system and communications protection policy and the associated system and communications protection controls.
- **Organizational Assignments (Variables):**
    - organization-defined personnel or roles
    - applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### SC-1(b): Policy and Procedures - b
- **Control Statement:** Designate an organization-defined official to manage the development, documentation, and dissemination of the system and communications protection policy and procedures.
- **Organizational Assignments (Variables):**
    - organization-defined official

#### SC-1(c): Policy and Procedures - c
- **Control Statement:** "Review and update the current system and communications protection policy at organization-defined frequency and following organization-defined events. Review and update the current system and communications protection procedures at organization-defined frequency and following organization-defined events."
- **Organizational Assignments (Variables):**
    - organization-defined frequency (Policy)
    - organization-defined events (Policy)
    - organization-defined frequency (Procedures)
    - organization-defined events (Procedures)

### SC-2: Separation of System and User Functionality

#### SC-2: Separation of System and User Functionality
- **Control Statement:** Separate user functionality, including user interface services, from system management functionality.
- **Organizational Assignments (Variables):**
    - None

### SC-3: Security Function Isolation

#### SC-3: Security Function Isolation
- **Control Statement:** Isolate security functions from nonsecurity functions.
- **Organizational Assignments (Variables):**
    - None

### SC-4: Information in Shared System Resources

#### SC-4: Information in Shared System Resources
- **Control Statement:** Prevent unauthorized and unintended information transfer via shared system resources.
- **Organizational Assignments (Variables):**
    - None

### SC-5: Denial-of-service Protection

#### SC-5(a): Denial-of-service Protection - a
- **Control Statement:** Protect against the effects of the following types of denial-of-service events: organization-defined types of denial-of-service events.
- **Organizational Assignments (Variables):**
    - organization-defined types of denial-of-service events

#### SC-5(b): Denial-of-service Protection - b
- **Control Statement:** Employ the following controls to achieve the denial-of-service objective: organization-defined controls by type of denial-of-service event
- **Organizational Assignments (Variables):**
    - organization-defined controls by type of denial-of-service event

### SC-7: Boundary Protection

#### SC-7(a): Boundary Protection - a
- **Control Statement:** Monitor and control communications at the external managed interfaces to the system and at key internal managed interfaces within the system.
- **Organizational Assignments (Variables):**
    - None

#### SC-7(b): Boundary Protection - b
- **Control Statement:** Implement subnetworks for publicly accessible system components that are physically or logically separated from internal organizational networks.
- **Organizational Assignments (Variables):**
    - None

#### SC-7(c): Boundary Protection - c
- **Control Statement:** Connect to external networks or systems only through managed interfaces consisting of boundary protection devices arranged in accordance with an organizational security and privacy architecture.
- **Organizational Assignments (Variables):**
    - None

#### SC-7(3): Boundary Protection | Access Points
- **Control Statement:** Limit the number of external network connections to the system.
- **Organizational Assignments (Variables):**
    - None

#### SC-7(4)(a): Boundary Protection | External Telecommunications Services - a
- **Control Statement:** Implement a managed interface for each external telecommunication service.
- **Organizational Assignments (Variables):**
    - None

## SI: System and Information Integrity

### SI-1: Policy and Procedures

#### SI-1(a): Policy and Procedures - a
- **Control Statement:** "Develop, document, and disseminate to defined personnel or roles at organization-level, mission/business process-level, system-level system and information integrity policy that Addresses purpose, scope, roles, responsibilities, management commitment, coordination among organizational entities, and compliance and Is consistent with applicable laws, executive orders, directives, regulations, policies, standards, and guidelines. Procedures to facilitate the implementation of the system and information integrity policy and the associated system and information integrity controls"
- **Organizational Assignments (Variables):**
    - defined personnel or roles
    - applicable laws, executive orders, directives, regulations, policies, standards, and guidelines

#### SI-1(b): Policy and Procedures - b
- **Control Statement:** Designate a defined official to manage the development, documentation, and dissemination of the system and information integrity policy and procedures
- **Organizational Assignments (Variables):**
    - defined official

#### SI-1(c): Policy and Procedures - c
- **Control Statement:** "Review and update the current system and information integrity: Policy defined frequency and following defined events. Procedures defined frequency and following defined events."
- **Organizational Assignments (Variables):**
    - defined frequency (Policy)
    - defined events (Policy)
    - defined frequency (Procedures)
    - defined events (Procedures)

### SI-2: Flaw Remediation

#### SI-2(a): Flaw Remediation - a
- **Control Statement:** Identify, report, and correct system flaws
- **Organizational Assignments (Variables):**
    - None

#### SI-2(b): Flaw Remediation - b
- **Control Statement:** Test software and firmware updates related to flaw remediation for effectiveness and potential side effects before installation
- **Organizational Assignments (Variables):**
    - None

#### SI-2(c): Flaw Remediation - c
- **Control Statement:** Install security-relevant software and firmware updates within [Assignment: organization-defined time period] of the release of the updates
- **Organizational Assignments (Variables):**
    - [Assignment: organization-defined time period]

#### SI-2(d): Flaw Remediation - d
- **Control Statement:** Incorporate flaw remediation into the organizational configuration management process.
- **Organizational Assignments (Variables):**
    - None

#### SI-2(2): Automated Flaw Remediation Status
- **Control Statement:** Determine if system components have applicable security-relevant software and firmware updates installed using [Assignment: organization-defined automated mechanisms] [Assignment: organization-defined frequency].
- **Organizational Assignments (Variables):**
    - [Assignment: organization-defined automated mechanisms]
    - [Assignment: organization-defined frequency]

#### SI-2(3)(a): Time to Remediate Flaws and Benchmarks for Corrective Actions - a
- **Control Statement:** Measure the time between flaw identification and flaw remediation
- **Organizational Assignments (Variables):**
    - None

#### SI-2(3)(b): Time to Remediate Flaws and Benchmarks for Corrective Actions - b
- **Control Statement:** Establish the following benchmarks for taking corrective actions
- **Organizational Assignments (Variables):**
    - None

### SI-3: Malicious Code Protection

#### SI-3(a): Malicious Code Protection - a
- **Control Statement:** Implement [Assignment (one or more): signature based, non-signature based] malicious code protection mechanisms at system entry and exit points to detect and eradicate malicious code
- **Organizational Assignments (Variables):**
    - [Assignment (one or more): signature based, non-signature based]

#### SI-3(b): Malicious Code Protection - b
- **Control Statement:** Automatically update malicious code protection mechanisms as new releases are available in accordance with organizational configuration management policy and procedures
- **Organizational Assignments (Variables):**
    - None

#### SI-3(c): Malicious Code Protection - c
- **Control Statement:** "Configure malicious code protection mechanisms to: Perform periodic scans of the system [Assignment: organization-defined frequency] and real-time scans of files from external sources at [Assignment (one or more): endpoint, network entry and exit points] as the files are downloaded, opened, or executed in accordance with organizational policy; and [Assignment (one or more): block malicious code, quarantine malicious code, take [Assignment: organization-defined action] ]; and send alert to [Assignment: organization-defined personnel or roles] in response to malicious code detection"
- **Organizational Assignments (Variables):**
    - [Assignment: organization-defined frequency]
    - [Assignment (one or more): endpoint, network entry and exit points]
    - [Assignment (one or more): block malicious code, quarantine malicious code, take [Assignment: organization-defined action] ]
    - [Assignment: organization-defined action]
    - [Assignment: organization-defined personnel or roles]

#### SI-3(d): Malicious Code Protection - d
- **Control Statement:** Address the receipt of false positives during malicious code detection and eradication and the resulting potential impact on the availability of the system.
- **Organizational Assignments (Variables):**
    - None

### SI-4: System Monitoring

#### SI-4(a): System Monitoring - a
- **Control Statement:** "Monitor the system to detect: Attacks and indicators of potential attacks in accordance with the following monitoring objectives: [Assignment: organization-defined monitoring objectives]; and Unauthorized local, network, and remote connections"
- **Organizational Assignments (Variables):**
    - [Assignment: organization-defined monitoring objectives]

#### SI-4(b): System Monitoring - b
- **Control Statement:** Identify unauthorized use of the system through the following techniques and methods: [Assignment: organization-defined techniques and methods]
- **Organizational Assignments (Variables):**
    - [Assignment: organization-defined techniques and methods]

#### SI-4(c): System Monitoring - c
- **Control Statement:** Invoke internal monitoring capabilities or deploy monitoring devices
- **Organizational Assignments (Variables):**
    - None

#### SI-4(d): System Monitoring - d
- **Control Statement:** Analyze detected events and anomalies
- **Organizational Assignments (Variables):**
    - None

#### SI-4(e): System Monitoring - e
- **Control Statement:** Adjust the level of system monitoring activity when there is a change in risk to organizational operations and assets, individuals, other organizations, or the Nation
- **Organizational Assignments (Variables):**
    - None

#### SI-4(f): System Monitoring - f
- **Control Statement:** Obtain legal opinion regarding system monitoring activities
- **Organizational Assignments (Variables):**
    - None

#### SI-4(g): System Monitoring - g
- **Control Statement:** Provide [Assignment: organization-defined system monitoring information] to [Assignment: organization-defined personnel or roles] [Assignment (one or more): as needed, [Assignment: organization-defined frequency]
- **Organizational Assignments (Variables):**
    - [Assignment: organization-defined system monitoring information]
    - [Assignment: organization-defined personnel or roles]
    - [Assignment (one or more): as needed, [Assignment: organization-defined frequency]

#### SI-4(1): System-wide Intrusion Detection System
- **Control Statement:** Connect and configure individual intrusion detection tools into a system-wide intrusion detection system.
- **Organizational Assignments (Variables):**
    - None

#### SI-4(2): Automated Tools and Mechanisms for Real-time Analysis
- **Control Statement:** Employ automated tools and mechanisms to support near real-time analysis of events.
- **Organizational Assignments (Variables):**
    - None

### SI-7: Software, Firmware, and Information Integrity

#### SI-7(a): Software, Firmware, and Information Integrity - a
- **Control Statement:** Employ integrity verification tools to detect unauthorized changes to the following software, firmware, and information: defined software, firmware, and information
- **Organizational Assignments (Variables):**
    - defined software, firmware, and information

#### SI-7(b): Software, Firmware, and Information Integrity - b
- **Control Statement:** Take the following actions when unauthorized changes to the software, firmware, and information are detected.
- **Organizational Assignments (Variables):**
    - None

#### SI-7(1): Integrity Checks
- **Control Statement:** Perform an integrity check of defined software, firmware, and information at startup, at defined transitional states or security-relevant events every [defined frequency]
- **Organizational Assignments (Variables):**
    - defined software, firmware, and information
    - defined transitional states or security-relevant events
    - [defined frequency]

#### SI-7(2): Automated Notifications of Integrity Violations
- **Control Statement:** Employ automated tools that provide notification to defined personnel or roles upon discovering discrepancies during integrity verification.
- **Organizational Assignments (Variables):**
    - defined personnel or roles

#### SI-7(5): Automated Response to Integrity Violations
- **Control Statement:** Automatically shut the system down, restart the system, implement defined controls when integrity violations are discovered.
- **Organizational Assignments (Variables):**
    - defined controls

#### SI-7(7): Integration of Detection and Response
- **Control Statement:** Incorporate the detection of the following unauthorized changes into the incident response capability. Define the security-relevant changes to the system.
- **Organizational Assignments (Variables):**
    - security-relevant changes to the system (to be defined)

#### SI-7(15): Code Authentication
- **Control Statement:** Implement cryptographic mechanisms to authenticate software or firmware components prior to installation. Define software or firmware components.
- **Organizational Assignments (Variables):**
    - software or firmware components (to be defined)

### SI-8: Spam Protection

#### SI-8(a): Spam Protection - a
- **Control Statement:** Employ spam protection mechanisms at system entry and exit points to detect and act on unsolicited messages.
- **Organizational Assignments (Variables):**
    - None

#### SI-8(b): Spam Protection - b
- **Control Statement:** Update spam protection mechanisms when new releases are available in accordance with the configuration management policy and procedures.
- **Organizational Assignments (Variables):**
    - None

#### SI-8(2): Automatic Updates
- **Control Statement:** Automatically update spam protection mechanisms
- **Organizational Assignments (Variables):**
    - None

### SI-10: Information Input Validation

#### SI-10: Information Input Validation
- **Control Statement:** Check the validity of the following information inputs that are defined for the system
- **Organizational Assignments (Variables):**
    - information inputs that are defined for the system
``````