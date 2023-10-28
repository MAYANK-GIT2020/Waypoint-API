@echo off
echo Log Analytic Agent Installation begining...
cd..
cd temp\
TIMEOUT /T 4
echo Extracting Package...
echo.
MMASetup-AMD64.exe /c  /t:"c:\temp"
TIMEOUT /T 4
cd..
cd temp\
setup.exe /qn NOAPM=1 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 OPINSIGHTS_WORKSPACE_ID="a8f1e72b-eeae-4e31-b884-4af6c7b26acc" OPINSIGHTS_WORKSPACE_KEY="Ra5dgxLUbUvSk/XOazy8gste74k/eeq7/azb7v2/9C4+8Sm3rfwEccjQihrLwSnvf94/KuIDTYSF+vt5Rs/n7w==" AcceptEndUserLicenseAgreement=1
echo Done
echo.
exit