#!/bin/bash

function ts {
  echo [`date '+%b %d %X'`]
}

echo "$(ts) Starting the server in 5 seconds..."
/bin/Xeoma/xeoma -- -service -log -startdelay 5
