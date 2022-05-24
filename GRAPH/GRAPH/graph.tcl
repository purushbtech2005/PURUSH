
exec xgraph  NFCCS-delay.tr CCPRCLA-delay.tr DPCM-delay.tr CAFREP-delay.tr -x NODES -y delay(ms)  -t AVG-DELAY -bg white  -geometry 800*500 &

exec xgraph  NFCCS-thr.tr CCPRCLA-thr.tr DPCM-thr.tr CAFREP-thr.tr -x NODES -y thr(kbps)  -t THROUGHPUT -bg white  -geometry 800*500 &

exec xgraph  NFCCS-drop.tr CCPRCLA-drop.tr DPCM-drop.tr CAFREP-drop.tr -x NODES -y drop(%)  -t DROP-RATIO -bg white  -geometry 800*500 &

exec xgraph  NFCCS-delay-vs-time.tr CCPRCLA-delay-vs-time.tr DPCM-delay-vs-time.tr CAFREP-delay-vs-time.tr -x TIME -y delay(ms)  -t AVG-DELAY-vs-time -bg white  -geometry 800*500 &

exec xgraph  NFCCS-thr-vs-time.tr CCPRCLA-thr-vs-time.tr DPCM-thr-vs-time.tr CAFREP-thr-vs-time.tr -x TIME -y thr(kbps)  -t THROUGHPUT-vs-time -bg white  -geometry 800*500 &
