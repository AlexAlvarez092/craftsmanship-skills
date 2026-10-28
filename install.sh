#!/usr/bin/env bash
# Installs the software-quality skills and the always-on rule for Copilot CLI.
# Usage: ./install.sh [--project]   (--project installs the rule into ./.github/instructions)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${HOME}/.copilot/skills"
RULE_FILE="software-quality.instructions.md"

if [[ "${1:-}" == "--project" ]]; then
  RULE_DIR="$(pwd)/.github/instructions"
else
  RULE_DIR="${HOME}/.copilot/instructions"
fi

mkdir -p "$SKILLS_DIR" "$RULE_DIR"
for skill in "$ROOT"/skills/*/; do
  name="$(basename "$skill")"
  rm -rf "${SKILLS_DIR:?}/${name}"
  cp -R "$skill" "${SKILLS_DIR}/${name}"
  echo "skill installed: ${name}"
done
cp "$ROOT/rules/$RULE_FILE" "$RULE_DIR/$RULE_FILE"
echo "rule installed: $RULE_DIR/$RULE_FILE"
