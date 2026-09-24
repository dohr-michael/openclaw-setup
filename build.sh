#!/bin/bash

VERSION=2026.9.6

podman build \
  --build-arg OPENCLAW_VERSION=$VERSION \
  -t openclaw-browser:$VERSION \
  -f Dockerfile.browser .

# Remplace ancienne version par $VERSION dans /home/michael/.config/containers/systemd/openclaw.container
# Image=localhost/openclaw-browser:${VERSION}
sed -i -E \
  's|^Image=localhost/openclaw-browser:[^[:space:]]+|Image=localhost/openclaw-browser:'"$VERSION"'|' \
  /home/michael/.config/containers/systemd/openclaw.container


systemctl --user daemon-reload
systemctl --user restart openclaw.service

