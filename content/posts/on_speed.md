---
title: On Speed
excerpt: "When I say the terms \"IT Operations\" and \"Software Development\" together, what decade do you think of? Probably the 90s or at least early 2000s."
author_name: Chas Ballew
author_email: chas@aptible.com
author_id: chas
posted: 2014-06-01
section: Blog
---

When I say the terms "IT Operations" and "Software Development" together, what decade do you think of?

Probably the 90s or at least early 2000s. For a long time those terms reflected the separation, often physical, between the places where software was made and the places where software was implemented or consumed. Now the locus of development and operations have shifted to a common location: Software is developed on the Internet, using the Internet; software is consumed and operated on the Internet, over the Internet.

The software deployment cycle, the time from development to deployment and operation, has shrunk to days, hours, and in some cases even minutes. A service that thousands (or millions) of people are using simultaneously can be updated while running, with a fix we came up with 30 minutes ago and tested 30 seconds ago, and appear to continue to function seamlessly. That kind of resiliency and speed is incredibly powerful, and is a key component of [strategy that aims for rapid disruption](http://techcrunch.com/2014/02/11/thrive-capital-founder-josh-kushner-on-the-power-of-oscar/).

Paul Graham thinks the key advantage of a startup is speed. Fast development cycles are rocket fuel, and they're cheaper than the rocket fuel VCs provide.

<br>
## How to go fast
<br>
If you agree that speed is powerful, there are two ways to get it. The first is to have your development team build and maintain your deployment and production processes and operations, i.e., DevOps. This approach works when you have a high ratio of engineering resources to complexity. Namely, when you have incredible engineers, lots of engineers, or almost no complexity.

The second choice is to use an abstracted, standardized deployment process, i.e., a platform. Some are referring to highly abstracted infrastructure management as [NoOps](http://www.pcworld.com/article/252264/noops_debate_grows_heated.html).

Both come with tradeoffs. DevOps strategies are expensive and hard to implement well. For most organizations, developers and engineers are a constrained resource. Platforms like Heroku, on the other hand, are generic and [make technical decisions accordingly](http://artsy.github.io/blog/2013/02/17/impact-of-heroku-routing-mesh-and-random-routing/).

There is an increasing amount of interest in more [flexible, customizable PaaS](https://www.openshift.com/blogs/its-2014-and-paas-is-eating-the-world). IDC expects the cloud services market to [triple in the next three years](http://www.idc.com/getdoc.jsp?containerId=prUS24298013) because the cost savings are so compelling. Projects like [Flynn](flynn.io), [Deis](deis.io), [OpenStack](openstack.org), and [Cloud Foundry](cloudfoundry.org) reflect this growing interest.

For organizations in many industries (healthcare is just one), a high-security, high-compliance PaaS is a compelling next step, enabling a relatively small team of engineers to punch far above their weight class.

<br>
## Enter Aptible
<br>
Aptible is two powerful things combined: a deployment platform and a set of integrated compliance tools. We use the platform to empower low transaction costs and lower fixed costs for rapid, iterative deployment of code. We use the compliance tools to empower the ability to operate in a regulated environment.

These are both domains where, to get the level of functionality and assurance we provide by default, you would have previously needed to hire several employees, or deal with contractors and consultants.

How much work does Aptible need to save you to make financial sense? How many wasted hours of service coordination and standardization, building and/or tweaking your config management systems, and evaluating infrastructure changes does Aptible have to help you avoid to make it worth it for your company?

For many small and midsize companies, the math is compelling. A single employee salaried at $100k/year costs ~$8,333/month, probably closer to $10-15k/month once benefits, office space, and other associated costs are included. $15k/month for a year is ~$20/hour, calculated 24/7.

We cost less than $3.50/hour for a full Production Account.

If you think Aptible can, on average, do the work of a single operations engineer, you are immediately getting more than 5x your value back in time saved per dollar spent, just on operations. More likely is that we'll save you the work of several employees.

(None of that is counting the value of the regulatory compliance work we do for you. That value, and the resulting increase in confidence and trust your customers will have in you, is what we call "Continuous Compliance." It will be the subject of our next post.)
