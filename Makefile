PREFIX?=/usr/local

SCRIPTS=bashstaging.sh\
	cfgstaging.sh\
	chkstaging.sh\
	lsstaging.sh\
	mkstaging.sh\
	numstaging.sh\
	rmstaging.sh\
	runstaging.sh\
	stagelight-panel.sh\
	stagelight.inc.sh\
	ulstaging.sh

install: ${SCRIPTS}
	install ${SCRIPTS} ${PREFIX}/bin
	
