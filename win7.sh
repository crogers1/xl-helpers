#!/bin/bash

xl create win7.conf
DOMID=`xl list | tail -n 1 | awk '{print $2}'`

xenstore-write /local/domain/$DOMID/hvmloader/seabios-legacy-load-roms 1
xenstore-write /local/domain/$DOMID/vm/slot "1"

xenstore-write /vm/8d85049a-9bdd-11e2-9e91-18037322eba8/slot "1"
xenstore-write /vm/8d85049a-9bdd-11e2-9e91-18037322eba8/name "Win7x32"
xenstore-write /vm/8d85049a-9bdd-11e2-9e91-18037322eba8/banner/domaincolor "yellow"

xenstore-write /local/domain/$DOMID/device/vkbd/0 ""
xenstore-write /local/domain/$DOMID/device/vkbd/0/backend "/local/domain/0/backend/vkbd/$DOMID/0"
xenstore-write /local/domain/$DOMID/device/vkbd/0/backend-id "0"
xenstore-write /local/domain/$DOMID/device/vkbd/0/protocol "native"
xenstore-write /local/domain/$DOMID/device/vkbd/0/state "1"
xenstore-chmod -r /local/domain/$DOMID/device/vkbd/0 n$DOMID r0

xenstore-write /local/domain/0/backend/vkbd/$DOMID/0 ""
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0 ""
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/frontend "/local/domain/$DOMID/device/vkbd/0"
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/frontend-id "$DOMID"
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/online "1"
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/state "1"
xenstore-chmod -r /local/domain/0/backend/vkbd/$DOMID/0 n0 r$DOMID

