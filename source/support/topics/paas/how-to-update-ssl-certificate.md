In the Aptible dashboard, find an app that has an endpoint with the certificate you want to update. Under the "Endpoints" tab, find the endpoint you want to update and click "Edit." Then, near the bottom of the page, choose "Add new certificate." Drag and drop or copy/paste your new certificate bundle and private key.

*Note:* Be sure your certificate bundle [includes all intermediate certificates](/support/topics/paas/how-to-order-certs/).

If this is the only endpoint you need to update, you are done. If you want to update additional endpoints, find their associated apps, choose the new certificate in the editor under the "Endpoints" tab for each app, then select "Save Endpoint." Repeat this for each endpoint.
