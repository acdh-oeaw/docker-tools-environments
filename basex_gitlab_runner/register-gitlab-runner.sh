#!/usr/bin/env bash
gitlab-runner register \
  --config /etc/gitlab-runner/config.toml \
  --builds-dir /opt/basex/webapp --custom_build_dir-enabled \
  --url "https://gitlab.com/" \
  --executor "shell" \
  --description "basex-environment" \
  --tag-list "BaseX" \
  --run-untagged="false" \
  --locked="false" \
  --access-level="not_protected"
