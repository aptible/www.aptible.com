When you expose an app to the Internet using a public Aptible endpoint, you will likely receive traffic from sources other than your intended users. Some of this traffic may make requests for non-existent or non-sensical resources. This is normal on the Internet, and there are various reasons it might happen:

- An attacker is [fingerprinting you](http://security.stackexchange.com/questions/37839/strange-get-requests-to-my-apache-web-server)
- An attacker is [probing you for vulnerabilities](http://serverfault.com/questions/215074/strange-stuff-in-apache-log)
- A spammer is trying to get you to visit a site
- Someone has cached an ELB IP address that AWS has reused for another load balancer

In general, these activities are not likely to result in adverse impact to you or your data and can be ignored. That said, we always advise customers to take a proactive security posture that includes secure code development practices, regular security assessment of your apps, and regular patching.