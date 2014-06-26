PREFIX?=/usr/local

SCRIPTS=chkstaging.sh\
	lsstaging.sh\
	mkstaging.sh\
	rmstaging.sh\
	runstaging.sh\
	stagelight-panel.sh\
	stagelight.inc.sh

install: ${SCRIPTS}
	install ${SCRIPTS} ${PREFIX}/bin
	
