Aptible can serve a maintenance page when the app itself is not responding
(which results in a 502 error at NGiNX).

Set `MAINTENANCE_PAGE_URL` via the Aptible CLI until you can deploy
fixes or roll your application back to a working state.

`aptible config:set MAINTENANCE_PAGE_URL=[URL of static page]`
