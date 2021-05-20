# ======================================
# First Stage: Get mvd_epics source code
# ======================================
FROM debian:10-slim AS fetch-repo
RUN apt-get update && apt-get install -y git
WORKDIR /var/cache
RUN git clone git://jspc29.x-matter.uni-frankfurt.de/projects/mvd_epics.git \
 && cd mvd_epics \
 && rm -rf .git


# ===========================
# Final Build Stage with IOCs
# ===========================
FROM pklaus/epics_contapps:1-0-1 AS final

COPY --from=fetch-repo --chown=scs:users /var/cache/mvd_epics /epics/iocs/mvd_epics

WORKDIR /epics/iocs/mvd_epics

RUN set -x \
 && for IOC in AGILENT_34411A ALARMS BALZERS_PKG020 DAQ_SETTINGS FLOW_METER HAMEG_HMP4030 HUBER_COOLING MKS_910_DualTrans PT100_BOARD VACOM_MVC3; do \
      cd $IOC; \
      make \
        'EPICS_BASE=/epics/base' \
        'EPICS_ROOT=/epics' \
        'MODULES=/epics/modules' \
        'SUPPORT=$(MODULES)' \
        'SNCSEQ=$(SUPPORT)/sncseq-2-2-8' \
        'CALC=$(SUPPORT)/calc-R3-7-4' \
        'ASYN=$(SUPPORT)/asyn-R4-38' \
        'STREAM=$(SUPPORT)/StreamDevice-2-8-13' \
        ; \
      cd ..; \
    done
