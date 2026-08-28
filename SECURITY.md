# Security

Do not report exposed credentials in a public issue. Revoke the credential immediately, remove it from all Git history, and contact the repository maintainer privately.

This repository must not contain Pi `auth.json`, trust/session state, `.env` files, private keys, access tokens, or API keys. Run `./scripts/check.sh` and inspect staged changes before every release.
