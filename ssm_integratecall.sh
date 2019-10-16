echo Read value from AWS Parameter Store
SSM_PARAM_NAME=PROC_REPORTING_CALL
SSM_VALUE=`aws ssm get-parameters --with-decryption --names "${SSM_PARAM_NAME}" --region eu-west-1 --query 'Parameters[*].Value' --output text`
echo Parameter read successfully

find="ENTITY_TYPE"
replace="FISCAL_YEAR"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

replace="LEDGER_ACCOUNT"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

replace="DIMENSION"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

replace="INVOICE"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

replace="LEDGER_RECEIPT"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

replace="BUSINESS_PARTNER"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate

echo Script completed!
