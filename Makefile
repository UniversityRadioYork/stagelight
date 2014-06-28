PREFIX?=/usr/local

SCRIPTS=cfgstaging.sh\
	chkstaging.sh\
	lsstaging.sh\
	mkstaging.sh\
	rmstaging.sh\
	runstaging.sh\
	stagelight-panel.sh\
	stagelight.inc.sh\
	ulstaging.sh

install: ${SCRIPTS}
	install ${SCRIPTS} ${PREFIX}/bin
	
