_Disclaimer: This material is provided for informational purposes only and not for the purpose of providing legal advice. Aptible is not a law firm. You should consult an attorney to obtain advice with respect to any particular issue or problem. Use of this site does not create an attorney-client relationship between you and Aptible._

### Disclosure + Opt-In

Yes, you can send individuals their own PHI through unencrypted emails, SMS messages, and other electronic communications if:

1. You advise the individual of the risk that the information in the communication could be read by a third party, and  
2. The individual still prefers the unencrypted communication.

The HIPAA Privacy Rule gives individuals the right to request access to their PHI. In 2013, HHS explained that when an individual requests access to an electronic record, covered entities are required to provide access in the electronic form and format requested by the individual, including unencrypted email:

> We clarify that covered entities are permitted to send individuals unencrypted emails if they have advised the individual of the risk, and the individual still prefers the unencrypted email. We disagree that the "duty to warn" individuals of risks associated with unencrypted email would be unduly burdensome on covered entities and believe this is a necessary step in protecting the protected health information. We do not expect covered entities to educate individuals about encryption technology and the information security. Rather, we merely expect the covered entity to notify the individual that there may be some level of risk that the information in the email could be read by a third party. If individuals are notified of the risks and still prefer unencrypted email, the individual has the right to receive protected health information in that way, and covered entities are not responsible for unauthorized access of protected health information while in transmission to the individual based on the individual’s request. Further, covered entities are not responsible for safeguarding information once delivered to the individual.

[HIPAA/HITECH Final Omnibus Rule](https://www.gpo.gov/fdsys/pkg/FR-2013-01-25/pdf/2013-01073.pdf), January 25, 2013, p. 5634 

This guidance specifically discussed email, but the same rationale applies to SMS, and other forms of electronic communication. Similarly, the rationale applies to recurring communications, not just responses to specific requests by individuals. 

### What if I'm a HIPAA business associate?
Review the privacy provisions of your BAAs to confirm that you are permitted to use PHI to communicate with individuals. Many BAAs implement [HHS's suggestion](http://www.hhs.gov/hipaa/for-professionals/covered-entities/sample-business-associate-agreement-provisions/index.html) to permit the vendor business associate to use or disclose protected health information in order to provide services referenced in some other agreement, such as a Terms of Service. Be clear with your customers about how your product works and how you communicate with end users. 

### App Design Considerations
If you are implementing a feature to send unencrypted messages to an individual with their PHI, keep these six points in mind:

**1. Make your disclosure simple and clear**  
For example:

>[Email/text messaging] allows us to communicate with you more efficiently and provide you with better service. At the same time, we recognize that [email/text messaging] is not a completely secure means of communication because these messages can be addressed to the wrong person or accessed improperly while in storage or during transmission.

**2. Use a true opt-in**  
For example: 
> If you would like us to send you [email/text messages] that contain your health information, please select "Yes."

You can require an answer, and even display a warning if the user doesn't opt-in. Never pre-select "yes" for them.

**3. Confirm user-provided information**  
If possible, send a confirmation email or SMS and require the user to validate their email address or phone number before sending PHI.

**4. Keep records**  
Keep an audit record of the user's opt-in, either in your database or logging system. Make sure your business continuity plan includes making and testing backups. Make sure you can explain which version of the disclosure and opt-in the user agreed to, and how you authenticated their identity.

**5. Degrade gracefully**  
Have a plan for if the user doesn't opt-in. Be careful to make sure users understand they are not required to authorize the use of unencrypted email or text messaging, and that a decision not to opt-in will not affect their health care in any way. Never penalize a user for not opting in.

If your service absolutely requires sending PHI over unencrypted email or text messaging to work, be sure to emphasize that they can still choose not to use your service:

> You are not required to authorize the use of [email/text messages], however if you choose not to authorize us to send you health information over [email/text messages], we may not be able to serve you.

If this is the case, be sure to thoroughly document the rationale in your HIPAA policies.

**6. Be prepared to handle replies**  
Remember that if a user replies to your email or SMS with a message containing PHI, any system that receives the reply needs to be able to handle PHI. Be careful with your reply-to addresses.

### Do I need a BAA with my messaging vendor?
HHS has not addressed whether a email and SMS providers who facilitate such transmissions are HIPAA business associates, but HHS's [narrow view of the "conduit exception" for transmission services](http://www.hhs.gov/hipaa/for-professionals/special-topics/cloud-computing/index.html) and the need for most providers to store your messages for logging purposes mean that in most cases you will need to put a business associate agreement in place. 

Some providers offer BAAs readily (e.g., [Mailgun](https://www.rackspace.com/information/legal/Mailgun-BAA), [Google G Suite](https://gsuite.google.com/terms/2015/1/hipaa_baa.html), [Zendesk](https://support.zendesk.com/hc/en-us/articles/210178838-Advanced-Security-Data-at-Rest-Encryption-Enhanced-Disaster-Recovery-and-HIPAA-Compliance-Enterprise-Add-on-)). Others may offer special configuration instructions, but will try to avoid accepting liability (e.g. [Twilio](https://support.twilio.com/hc/en-us/articles/223136467-Ensuring-HIPAA-compliancy-with-Twilio-made-applications)). In either case, you should consult an attorney if you have questions about potential legal risk.

### What about push notifications?
Push notifications are often sent over encrypted protocols, but check with your provider. You may still need a business associate agreement if you are sending PHI in the notification.

### Do I need an opt-in if I'm sending emails that don't contain PHI?
It is not clear. Protected Health Information, or PHI, is the combination of individually identifiable information (such as an email address, phone number, or device identifier) and health information. HHS has not clarified whether an email address used in a healthcare context constitutes PHI. Many healthcare providers do send routine transactional and marketing emails to users without collecting an opt-in. If you do so, take care to limit the personalized content of the communications and consider consulting an attorney.

### Can I send PHI in an unencrypted communication to someone other than the individual, such as a healthcare provider?
Probably not. The transmission security standards in the HIPAA Security Rule still apply, and it will rarely be reasonable or appropriate to send PHI over unencrypted channels when safer options exist, such as in-app messaging. HHS has been clear that sending an individual their own PHI is one of the rare exceptions. Again, consult an attorney if you have specific legal questions.
