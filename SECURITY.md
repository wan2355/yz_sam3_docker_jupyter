# Security Policy

## Supported Versions

This repository provides a Docker environment for running SAM3.

Security updates will generally follow updates of:

- Docker base images
- CUDA images
- Python dependencies
- SAM3 upstream repository

Users are encouraged to rebuild the Docker image periodically to ensure
that security patches from upstream images are applied.

---

## Reporting a Vulnerability

If you discover a security vulnerability related to this repository,
please open a GitHub issue.

For sensitive security reports, you may contact the repository maintainer
directly.

When reporting a vulnerability, please include:

- Description of the issue
- Steps to reproduce
- Possible impact
- Suggested fix (if available)

---

## Notes

This repository does **not distribute model weights**.

Model checkpoints are downloaded at runtime from
Hugging Face or other official sources.

Users should verify model licenses before use.
