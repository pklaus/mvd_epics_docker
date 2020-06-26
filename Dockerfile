FROM pklaus/epics_synapps:debian-jessie

MAINTAINER Philipp Klaus <philipp.l.klaus@web.de>

RUN apt-get update \
 && apt-get install --no-install-recommends -yq \
  git \
 && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt

WORKDIR /epics/iocs

RUN git clone git://jspc29.x-matter.uni-frankfurt.de/projects/mvd_epics.git

WORKDIR /epics/iocs/mvd_epics

RUN set -x \
 && for IOC in AGILENT_34411A BALZERS_PKG020 FLOW_METER HAMEG_HMP4030 HUBER_COOLING PT100_BOARD VACOM_MVC3; do \
    cd $IOC; make EPICS_BASE=/epics/base EPICS_ROOT=/epics MODULES=/epics/modules; cd ..; \
    done