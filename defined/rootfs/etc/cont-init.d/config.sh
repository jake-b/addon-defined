#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Nebula
# Creates the interface configuration
# ==============================================================================

declare enrollment_code
declare defined_root_dir

defined_root_dir='/config/defined'

if ! bashio::fs.directory_exists ${defined_root_dir}; then
    mkdir -p ${defined_root_dir} ||
        bashio::exit.nok "Could not create defined.net storage folder!"
fi

if ! bashio::fs.directory_exists "/etc/defined"; then
    ln -s ${defined_root_dir} /etc/defined ||
        bashio::exit.nok 'Could not /etc/defined storage folder symlink!'
fi

if ! bashio::fs.file_exists "${defined_root_dir}/dnclient.yml"; then
    if ! bashio::config.has_value 'enrollment_code'; then
        bashio::exit.nok 'dnclient.yaml does not exist and you need to set an enrollment_code for this node in the addon config.'
    fi
    enrollment_code=$(bashio::config 'enrollment_code')
    bashio::log.notice "Starting dnclient for enrollment."
    /usr/bin/dnclient run &
    sleep 5
    bashio::log.notice "Attempting to enroll ${enrollment_code}"
    /usr/bin/dnclient enroll -code ${enrollment_code}
    bashio::log.notice "Stopping dnclient..."
    kill $!
    sleep 5
else
    bashio::log.notice "dnclient.yml exists.  Skipping enrollment."
fi

# Set the iptables rules necessary for traffic forwarding between other devices on the network
defined_interface_name=defined1
host_interface_name=eth0
iptables -A FORWARD -i "${defined_interface_name}" -j ACCEPT
iptables -A FORWARD -o "${defined_interface_name}" -j ACCEPT
iptables -t nat -A POSTROUTING -o "${host_interface_name}" -j MASQUERADE

## Things we'll need
# Nebula config yaml
# Host Key
# Host Certificate
# CA Certificate




## Development stages
# First just point at a folder for nebula config and files named host.key, host.crt, and ca.crt
  # This could be either a lighthouse or regular node
# Second, allow this to stand itself up as a lighthouse, (or signing regular node I guess)
  # Requires User to config as either a signer, or non-signer (can still be either rlighthouse)
  # Generates Nebula certs and config from basic UI decisions (probably a template + yq to mutate values)
  # if config.yaml (vs generated_config.yaml) exists, use it instead of any generated values

# Ideal state:
# Can be either a signing or non-signing node, as either a lighthouse or non-lighthouse (leveraging dynamic DNS)
# In all signer-configurations can handle exporting certs to other network nodes, as well as incrementing IP management

# Configuration modes:
  # Lighthouse, or no
  # Signer of other nodes, or no
  # Provide your own config, or use a generated config