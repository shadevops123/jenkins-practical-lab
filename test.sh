#!/bin/bash
set -e

echo "Running application checks..."

test -f index.html
grep -q "Jenkins CI/CD Lab" index.html

echo "All tests passed."
