---
title: Service Level Agreement
tracked_title: Service Level Agreement
description: "Enclave's service level agreement."
posted: 2017-08-14
section: Legal
sub_section: Agreements
order: 1
---
<!-- Reference Links -->
[Terms of Service]:/legal/terms-of-service

Version 1.5 - August 2017

This Aptible Service Level Agreement (**"SLA"**) between Aptible, Inc. (**"Aptible"**, **"us"** or **"we"**) and users of the Aptible Services (**"you"**) governs the use of the Enclave Containerized Services under the provisions of the [Aptible Terms of Service] (the **"Terms"**).

Unless otherwise provided herein, this SLA is subject to the provisions of the Terms.

This SLA applies separately to each of your Enclave Dedicated Environments, as defined in the Terms. This SLA does not apply to Shared Environments or Gridiron.

### 1. Enclave Service Commitment: 99.95% Uptime
Aptible will use commercially reasonable efforts to make your Enclave Containerized Services running in Dedicated Environments available with a Monthly Uptime Percentage of at least 99.95% during any monthly billing cycle (the **"Service Commitment"**). Subject to the SLA Exclusions, if we do not meet the Service Commitment, you will be eligible to receive a Service Credit.

A Monthly Uptime Percentage of 99.95% means that we guarantee you will experience no more than 21.56 min/month of Unavailability.

### 2. Definitions

**"Maintenance"** means scheduled Unavailability of the Containerized Services, as announced by us prior to the Containerized Services becoming Unavailable.

**"Monthly Uptime Percentage"** is calculated by subtracting from 100% the percentage of minutes during the month in which the Enclave Containerized Services were Unavailable. Monthly Uptime Percentage measurements exclude downtime resulting directly or indirectly from any SLA Exclusion.

**"Service Credit"** means a credit denominated in US dollars, calculated as set forth below, that we may credit back to an eligible account.

**"Unavailable"** and **"Unavailability"** mean, for app services and databases, when your service or database is not running or not reachable due to Aptible's fault. This excludes (a) containers that are unreachable or not running because the container's provisioned resources (RAM, CPU, disk, as applicable) are insufficient; and (b) members of a database cluster where the cluster as a whole is running and reachable.

### 3. Service Commitments and Service Credits
Service Credits are calculated as a percentage of the total charges due on your Enclave invoice for the monthly billing cycle in which the Unavailability occurred, applied proportionally to the Services that were Unavailable, in accordance with the schedule below:

- For Monthly Uptime Percentage less than 99.95% but equal to or greater than 99.0%, you will be eligible for a Service Credit of 10% of the charges attributable to the affected resources
- For Monthly Uptime Percentage less than 99.0%, you will be eligible for a Service Credit of 30% of the charges attributable to the affected resources

For example, if you have an app container that is Unavailable for 25 minutes, you would be eligible for a Service Credit for 10% of that container's usage for the month. 

We will apply any Service Credits only against future payments for the Services otherwise due from you. At our discretion, we may issue the Service Credit to the credit card you used to pay for the billing cycle in which the Unavailability occurred. Service Credits will not entitle you to any refund or other payment from Aptible. A Service Credit will be applicable and issued only if the credit amount for the applicable monthly billing cycle is greater than one dollar ($1 USD). Service Credits may not be transferred or applied to any other account.

### 4. Sole Remedy
Unless otherwise provided in the Terms, your sole and exclusive remedy for any unavailability, non-performance, or other failure by us to provide the  Services is the receipt of a Service Credit (if eligible) in accordance with the terms of this SLA.

### 5. Credit Request and Payment Procedures
To receive a Service Credit, you must submit a claim by emailing support@aptible.com. To be eligible, the credit request must be received by us by the end of the second billing cycle after which the incident occurred and must include:

- the words "SLA Credit Request" in the subject line;
- the dates and times of each Unavailability incident that you are claiming;
- the account handle(s); and
- logs that document the errors and corroborate your claimed outage (any confidential or sensitive information in these logs should be removed or replaced with asterisks).

If the Monthly Uptime Percentage of such request is confirmed by us and is less than the Service Commitment, then we will issue the Service Credit to you within one billing cycle following the month in which your request is confirmed by us. Your failure to provide the request and other information as required above will disqualify you from receiving a Service Credit.

### 6. SLA Exclusions
The Service Commitment does not apply to any Unavailability:  

1. That results from a suspension or Remedial Action, as described in the Terms;
2. Caused by factors outside of our reasonable control, including any force majeure event, Internet access, or problems beyond the demarcation point of the Aptible network;  
3. That results from any actions or inactions of you or any third party;  
4. That results from the equipment, software or other technology of you or any third party (other than third party equipment within our direct control);  
5. That results from failures of Enclave Containerized Services not attributable to Unavailability; or   
6. That results from any Maintenance.

If availability is impacted by factors other than those used in our Monthly Uptime Percentage calculation, then we may issue a Service Credit considering such factors at our discretion.
