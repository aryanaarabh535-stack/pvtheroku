# Heroku deploy

## Config vars
Required: API_ID, API_HASH, BOT_TOKEN
Optional: PLATFORM_NAME, MAX_CONCURRENCY, GLOBAL_MAX_CONNECTIONS, DATA_DIR, proxies

```bash
heroku create your-app
heroku config:set API_ID=... API_HASH=... BOT_TOKEN=...
git init && git add . && git commit -m "heroku"
heroku git:remote -a your-app
git push heroku main
heroku ps:scale web=1
heroku logs --tail
```

Dyno FS is ephemeral — sessions under DATA_DIR reset on restart. Use external storage or a VPS for durable data.

OTP: in-app Telegram messages and email extractors accept 5- and 6-digit login codes; 6-digit preferred when both appear.
