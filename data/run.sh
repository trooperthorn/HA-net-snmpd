#!/usr/bin/with-contenv bashio

CONFIG="/etc/snmp/snmpd.conf"

{
	echo "syslocation $(bashio::config 'location')"
	echo "syscontact $(bashio::config 'name') <$(bashio::config 'email')>"
        echo "sysServices    72"
	echo "CreateUser $(bashio::config 'snmpv3user') SHA $(bashio::config 'snmpv3pass') AES $(bashio::config 'snmpv3pass')"
	echo "rouser $(bashio::config 'snmpv3user') priv .1"

} > "${CONFIG}"

bashio::log.info "Starting SNMP server..."

exec /usr/sbin/snmpd \
	-c "${CONFIG}" \
	-f \
	< /dev/null
