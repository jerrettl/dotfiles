#!/bin/bash

# Flashes the active window.

# Requires transset-df and a composite manager, like xcompmgr.
# In this case, we're using compton.

transset-df -a -m 0
sleep .3
transset-df -a -x 1
