#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p tools/bootstrap
java -jar tools/lib/ecj-3.36.0.jar --release 17 -encoding UTF-8 -nowarn -cp tools/lib/ecj-3.36.0.jar -d tools/bootstrap tools/Build.java
java -cp "tools/bootstrap:tools/lib/*" Build "$@"
