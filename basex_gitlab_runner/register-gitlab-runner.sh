#!/usr/bin/env bash
gitlab-runner register \
  --config /etc/gitlab-runner/config.toml \
  --url "https://gitlab.com/" \
  --executor "shell" \
  --description "basex-environment" \
  --tag-list "BaseX" \
  --run-untagged="false" \
  --locked="false" \
  --access-level="not_protected"
