# pihole_whitelist_blacklist

Basic bash tool to add regex black list from https://github.com/mmotti/pihole-regex as well as the whitelist for false-positives from the regex filters, the commonly white listed Pi-hole domains from https://discourse.pi-hole.net/t/commonly-whitelisted-domains/212, and whitelist from https://github.com/anudeepND/whitelist

# THANKS!
This wouldn't be possible without https://github.com/mmotti, https://github.com/anudeepND, or the Pi-hole community as a whole -- Thanks for what you do!

## Pre-Reqs

wget is a pre-requesite for this tool.

## Usage

Clone repo, and change into the directory, run main.sh as sudo/root with your desired argument:

```
Usage
 add_whitelist : Add anudeepND whitelist, mmotti's whitelist for regex and commonly whitelistd Pi-hole domains
 remove_whitelist : Remove whitelist
 add_blacklist : Add mmotti regex blacklist
 remove_blacklist : Remove blacklist
 ```
