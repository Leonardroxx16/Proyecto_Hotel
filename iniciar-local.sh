#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
bash compilar.sh
exec java -cp "target/tools:tools/lib/*" pe.limastay.tools.Launcher
