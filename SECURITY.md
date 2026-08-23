# Security Policy

## Supported versions

This repository follows the currently published AcodeX release. Security fixes
are expected to target the latest version only.

## Reporting a vulnerability

Please do not disclose suspected vulnerabilities in a public issue.

Report the vulnerability privately through GitHub's **Security** tab by using
**Report a vulnerability**, when private vulnerability reporting is available.
If that option is unavailable, contact the original maintainer through the
contact information in `plugin.json`.

Include:

- the affected version;
- clear reproduction steps;
- the expected and observed behavior;
- the security impact;
- any suggested mitigation.

Do not include real API keys, passwords, tokens, or personal data. Use test
credentials and redact sensitive terminal output.

## Security considerations

AcodeX connects Acode to a terminal backend and can execute commands with the
permissions of that backend. Review commands before execution, bind the backend
only to trusted interfaces, and do not expose its port to untrusted networks.

The optional AI features send prompts to the configured model provider. Never
paste secrets into prompts, and store provider API keys only in the plugin's
intended settings.
