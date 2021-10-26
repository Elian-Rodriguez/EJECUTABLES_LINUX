#!/bin/sh

#Consulta si POSServerRest se encuentra activo
if `ps aux | grep java | grep WebFrontPOSServerRest >/dev/null`; then
   sh /home/NCRServices/ServiceStatus.sh
else
   systemctl start POSServerRest
   wf_start

fi
#
