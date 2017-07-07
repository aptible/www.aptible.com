Enclave supports two distinct deployment strategies for [application
services][about-services]:


## Foreground services

If a service has any Endpoint associated with it, it is considered a
_foreground service_, and Enclave performs a **zero-downtime deploy** when
releasing it, using the following sequence of operations:

- Launch new containers.
- Wait for the new containers to pass a mandatory health check.
- Register the new containers with the Endpoint's load balancer. Wait for
  registration to complete.
- Deregister the old containers from the Endpoint's load balancer. Wait for
  deregistration to complete.
- Shutdown the old containers.


## Background services

If a service has no Endpoint associated with it, it is considered a _background
service_, and Enclave performs a **zero-overlap deploy** when releasing it,
using the following sequence of operations:

- Stop the old containers.
- Launch the new containers.


  [about-services]: /support/topics/enclave/about-services/
