#!/usr/bin/env bash
gitlab-runner register \
  --config /etc/gitlab-runner/config.toml \
  --url "https://gitlab.com/" \
  --executor "shell" \
  --description "existdb4x-environment" \
  --tag-list "existdb4x,eXgit" \
  --run-untagged="false" \
  --locked="false" \
  --access-level="not_protected"
