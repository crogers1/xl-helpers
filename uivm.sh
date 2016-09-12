#!/bin/bash

viptables -A -j ACCEPT
viptables --delete 2

xl create uivm.cfg
DOMID=`xl list | tail -n 1 | awk '{print $2}'`

xenstore-write /local/domain/$DOMID/device/vkbd/0 ""
xenstore-write /local/domain/$DOMID/device/vkbd/0/backend "/local/domain/0/backend/vkbd/$DOMID/0"
xenstore-write /local/domain/$DOMID/device/vkbd/0/backend-id "0"
xenstore-write /local/domain/$DOMID/device/vkbd/0/protocol "native"
xenstore-write /local/domain/$DOMID/device/vkbd/0/state "1"
xenstore-chmod -r /local/domain/$DOMID/device/vkbd/0 n$DOMID r0


xenstore-write /local/domain/0/backend/vkbd/$DOMID/0 ""
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/frontend "/local/domain/$DOMID/device/vkbd/0"
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/frontend-id "$DOMID"
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/online "1"
xenstore-write /local/domain/0/backend/vkbd/$DOMID/0/state "1"
xenstore-chmod -r /local/domain/0/backend/vkbd/$DOMID/0 n0 r$DOMID

