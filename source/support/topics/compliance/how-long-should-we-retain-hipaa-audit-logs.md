_Disclaimer: This material is provided for informational purposes only and not for the purpose of providing legal advice. Aptible is not a law firm. You should consult an attorney to obtain advice with respect to any particular issue or problem. Use of this site does not create an attorney-client relationship between you and Aptible._

### This is a gray area, but the safest strategy is to retain HIPAA audit logs for 6 years. 

The HIPAA Security Rule separates the requirement to implement audit logging from the requirement to retain documentation of your compliance program for 6 years.

The logging requirement [45 C.F.R. § 164.312(b)] requires that regulated entities "[i]mplement hardware, software, and/or procedural mechanisms that record and examine activity in information systems that contain or use electronic protected health information."

The retention requirement [45 C.F.R. 164.316(b)(1)(ii)] states, "[i]f an action, activity or assessment is required by [the Security Rule] to be documented, [you must] maintain a written (which may be electronic) record of the action, activity, or assessment."

HHS has not clarified whether audit logs represent an "action, activity, or assessment" that falls within the scope of the retention requirement. In practice, many covered entities interpret the retention requirement as only applying to policies, procedures, and other more traditional documentation. These entities may only retain audit logs for a year or two.

Some additional factors to consider:

- Cloud object storage such as Amazon S3 (which is available for use under an AWS business associate agreement) can make a long-term audit log rotation and retention policy more cost-feasible than other options, such as retaining audit logs in a live database. 
- Operational logs (e.g. non-audit app logs) do not have specific retention requirements under HIPAA, and can be retained/disposed of based on operational needs.
- HIPAA entitles individuals to receive an accounting of disclosures of their protected health information made in the 6 years prior to their request. Many routine disclosures are excluded, but if you choose to document non-exempt disclosures in your audit logs, you will need to retain those logs for 6 years anyways. Most Aptible customers document non-exempt disclosures separately from their audit logs.
