---
title: Service Level Agreement
tracked_title: Service Level Agreement
description: "Aptible's default SLA."
posted: 2016-11-29
section: Legal
sub_section: Agreements
order: 1
---

Version 1.4 - November 2016

This Aptible Service Level Agreement (**"SLA"**) between Aptible, Inc. (**"Aptible"**, **"us"** or **"we"**) and users of the Aptible Services (**"you"**) governs the use of the Aptible Containerized Services under the provisions of the [Aptible Terms of Service](/legal/terms_of_service.html) (the **"Terms"**).

This SLA applies separately to each of your Dedicated Environments, as defined in the Terms. This SLA does not apply to shared environments.

Unless otherwise provided herein, this SLA is subject to the provisions of the Terms. Capitalized words and phrases have the meaning specified in the Terms. We reserve the right to change the terms of this SLA in accordance with the Terms.

### 1. Service Commitment: 99.95% Uptime
Aptible will use commercially reasonable efforts to make the Aptible Containerized Services available with a Monthly Uptime Percentage of at least 99.95% during any monthly billing cycle (the **"Service Commitment"**). Subject to the Aptible SLA Exclusions, if we do not meet the Service Commitment, you will be eligible to receive a Service Credit.

A Monthly Uptime Percentage of 99.95% means that we guarantee you will experience no more than 21.56 min/month of Unavailability.

### 2. Definitions
**"Aptible Containerized Services"** mean your apps and databases running on Aptible in Dedicated Environments.

**"Maintenance"** means scheduled Unavailability of the Containerized Services, as announced by us prior to the Containerized Services becoming Unavailable.

**"Monthly Uptime Percentage"** is calculated by subtracting from 100% the percentage of minutes during the month in which the Aptible Containerized Services were Unavailable. Monthly Uptime Percentage measurements exclude downtime resulting directly or indirectly from any Aptible SLA Exclusion.

**"Service Credit"** means a credit denominated in US dollars, calculated as set forth below, that we may credit back to an eligible account.

**"Unavailable"** and **"Unavailability"** mean, for app services and databases, when your service or database is not running or not reachable due to Aptible's fault. This excludes (a) containers that are unreachable or not running because the container's provisioned resources (RAM, CPU, disk, as applicable) are insufficient; and (b) members of a database cluster where the cluster as a whole is running and reachable.

### 3. Service Commitments and Service Credits
Service Credits are calculated as a percentage of the total charges due on your Enclave invoice for the monthly billing cycle in which the Unavailability occurred, applied proportionally to the Services that were Unavailable, in accordance with the schedule below:

- For Monthly Uptime Percentage less than 99.95% but equal to or greater than 99.0%, you will be eligible for a Service Credit of 10% of the charges attributable to the affected resources
- For Monthly Uptime Percentage less than 99.0%, you will be eligible for a Service Credit of 30% of the charges attributable to the affected resources

For example, if you have an app container that is Unavailable for 25 minutes, you would be eligible for a Service Credit for 10% of that container's usage for the month. 

We will apply any Service Credits only against future payments for the Services otherwise due from you. At our discretion, we may issue the Service Credit to the credit card you used to pay for the billing cycle in which the Unavailability occurred. Service Credits will not entitle you to any refund or other payment from Aptible. A Service Credit will be applicable and issued only if the credit amount for the applicable monthly billing cycle is greater than one dollar ($1 USD). Service Credits may not be transferred or applied to any other account.

### 4. Sole Remedy
Unless otherwise provided in the Terms, your sole and exclusive remedy for any unavailability, non-performance, or other failure by us to provide the Aptible Containerized Services is the receipt of a Service Credit (if eligible) in accordance with the terms of this SLA.

### 5. Credit Request and Payment Procedures
To receive a Service Credit, you must submit a claim by emailing support@aptible.com. To be eligible, the credit request must be received by us by the end of the second billing cycle after which the incident occurred and must include:

- the words "SLA Credit Request" in the subject line;
- the dates and times of each Unavailability incident that you are claiming;
- the account handle(s); and
- logs that document the errors and corroborate your claimed outage (any confidential or sensitive information in these logs should be removed or replaced with asterisks).

If the Monthly Uptime Percentage of such request is confirmed by us and is less than the Service Commitment, then we will issue the Service Credit to you within one billing cycle following the month in which your request is confirmed by us. Your failure to provide the request and other information as required above will disqualify you from receiving a Service Credit.

### 6. Aptible SLA Exclusions
The Service Commitment does not apply to any unavailability, suspension or termination of the Aptible Containerized Services, or any other Aptible Containerized Service performance issue:  

1. That results from a suspension or Remedial Action, as described in the Terms;
2. Caused by factors outside of our reasonable control, including any force majeure event, Internet access, or problems beyond the demarcation point of the Aptible network;  
3. That results from any actions or inactions of you or any third party;  
4. That results from the equipment, software or other technology of you or any third party (other than third party equipment within our direct control);  
5. That results from failures of Aptible Containerized Services not attributable to Unavailability; or   
6. That results from any Maintenance.

If availability is impacted by factors other than those used in our Monthly Uptime Percentage calculation, then we may issue a Service Credit considering such factors at our discretion.
