#!/bin/sh
echo "Launching the Octant process (as $(whoami) user):"
export PATH="/opt/gcloud/bin:$PATH"
/opt/octant --disable-open-browser --listener-addr 0.0.0.0:7777
