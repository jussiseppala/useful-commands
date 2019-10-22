echo Script 2
echo Read value from AWS Parameter Store
SSM_PARAM_NAME=PROC_REPORTING_CALL
SSM_VALUE=`aws ssm get-parameters --with-decryption --names "${SSM_PARAM_NAME}" --region eu-west-1 --query 'Parameters[*].Value' --output text`
echo Parameter read successfully

find="ENTITY_TYPE"
replace="LEDGER_RECEIPT"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

echo Integration script completed! Still check status.


statusinfo=$(curl -X GET http://localhost:8080/integration/integration-status/LEDGER_RECEIPT)
if [ $statusinfo == 'In progress']
then
	echo Schedule running in one minute to be sure
	sudo at now + 1 minute -f ssm_integratecall.sh
else
	echo Integration done successfully
fi

echo Script completed!
