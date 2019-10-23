echo Script 1
echo Read value from AWS Parameter Store
SSM_PARAM_NAME=PROC_REPORTING_CALL
SSM_VALUE=`aws ssm get-parameters --with-decryption --names "${SSM_PARAM_NAME}" --region eu-west-1 --query 'Parameters[*].Value' --output text`
echo Parameter read successfully

echo Continue integration if needed

find="ENTITY_TYPE"
replace="INVOICE"
result=${SSM_VALUE//$find/$replace}
echo $replace
curl -d "$result" -H "Content-Type: application/json" -X GET http://localhost:8080/integration/integrate-notfinished

echo Script completed!
