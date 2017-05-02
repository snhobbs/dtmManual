#!/bin/bash
pdflatex triggerManual
sleep 2
biber triggerManual
sleep 2
makeglossaries triggerManual
sleep 2
pdflatex triggerManual
sleep 5
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=smallTriggerManual.pdf triggerManual.pdf
