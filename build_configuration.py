#!/usr/bin/env python

BUILDS = {
    # tag name:                          template settings
    'debian-jessie':                     {'base_img': 'pklaus/epics_synapps:debian-jessie', 'cross_build': False},
    'resin-raspberry-pi-debian-jessie':  {'base_img': 'pklaus/epics_synapps:resin-raspberry-pi-debian-jessie', 'cross_build': True},
    'resin-raspberrypi3-debian-jessie':  {'base_img': 'pklaus/epics_synapps:resin-raspberrypi3-debian-jessie', 'cross_build': True},
}
