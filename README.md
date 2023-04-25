# addon-nebula
Home Assistant addon for Defined.net dnclient

This is still a heavy work in progress and hasn't really be thoroughly tested.

For the most basic of documentation if you want to try it out:
- Install the `defined` folder in your local `/addons` folder
- Install the local addon from the 'addons store'
- If this is your first time enrolling, then under the 'configuration' tab, set the enrollement key from the defined.net console
- Start the addon
- Check the log to make sure everything worked as expected

## Note:
- This started as a ripoff of mr-ransel's nebula addon, which in itself was largely a ripoff of frenck's wireguard add-on apparently. This was as a starting point then I built out the behavior I wanted.
- Since the overlay network is "inside the container" this plugin uses the free version of https://github.com/snail007/goproxy to proxy ports 22, 8123, and 22222 to the host.  This differens from mr-ransel which just relied on Nebula's "unsafe routes"
- After the initial enrollement, the config files will be stored in the proper locations.  Subsquent starts of the addon will not use the enrollement key again.  You can clear it out of the configuration if you desire.
- The versions of `dnclient` and `goproxy` are hard coded URLs.  You could update them if you want more recent versions. These were the most recent version at the time I did this.