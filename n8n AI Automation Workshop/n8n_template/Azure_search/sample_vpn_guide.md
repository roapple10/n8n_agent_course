# VPN Connection Guide

## How to connect to the Acme Corporation VPN

1. Install the GlobalProtect client from the internal software portal (software.acme.local).
2. Open GlobalProtect and enter the gateway address: vpn.acme.local
3. Log in with your Acme network username and password (same as your email login).
4. If prompted for two-factor authentication, approve the push notification on the Acme Authenticator app.
5. Once connected, the GlobalProtect icon in your system tray will turn green.

## Common VPN issues

- **"Connection failed" error**: Check your internet connection first. If stable, restart the GlobalProtect client.
- **MFA push not received**: Confirm your phone has data/wifi and the Acme Authenticator app is up to date.
- **VPN connects but internal sites unreachable**: Try disconnecting and reconnecting. If it persists, this is usually a DNS issue on the client side.
- **Repeated password prompts**: Your account password may have expired. Reset it at password.acme.local.

If none of the above resolves the issue, escalate to IT with a Jira ticket including your OS version and the exact error message.
