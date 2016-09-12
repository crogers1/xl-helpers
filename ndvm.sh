#!/bin/bash

xl create ndvm.cfg
DOMID=`xl list | tail -n 1 | awk '{print $2}'`
UUID=`xec-vm -n ndvm get uuid`

#inform networdaemon that a network backend has been started, xenmgr does this on statechange
dbus-send --system --dest='com.citrix.xenclient.networkdaemon' / com.citrix.xenclient.networkdaemon.ndvm_status string:$UUID int32:$DOMID uint32:1

xenstore-write /local/domain/$DOMID/platform/pae "true"
xenstore-write /local/domain/$DOMID/platform/apic "true"
xenstore-write /local/domain/$DOMID/platform/acpi "1"
xenstore-write /local/domain/$DOMID/platform/nx "true"

xenstore-write /local/domain/$DOMID/device/v4v/0/backend "/local/domain/0/backend/v4v/2/0"
xenstore-write /local/domain/$DOMID/device/v4v/0/backend-id "0"
xenstore-write /local/domain/$DOMID/device/v4v/0/state "1"

xenstore-write /local/domain/0/backend/v4v/$DOMID/0/frontend "/local/domain/$DOMID/device/v4v/0"
xenstore-write /local/domain/0/backend/v4v/$DOMID/0/frontend-id "$DOMID"
xenstore-write /local/domain/0/backend/v4v/$DOMID/0/state "0"
xenstore-write /local/domain/$DOMID/v4v-firewall-ready "1"

