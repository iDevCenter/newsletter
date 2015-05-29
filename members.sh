#!/usr/bin/env sh

PAGE=0

while true; do
  DATA="{
    \"apikey\": \"$IDC_MAILCHIMP_APIKEY\",
    \"id\": \"621e10fdc0\",
    \"opts\": {
      \"start\": $PAGE,
      \"limit\": 100
    }
  }"

  RESULT=$(curl -s --compressed -X POST https://us10.api.mailchimp.com/2.0/lists/members.json -d "$DATA")

  echo $RESULT | jq -e '.data[]' > /dev/null

  if [ $? -ne 0 ]; then
    break;
  fi

  echo $RESULT |
    jq -r '.data[].email'

  PAGE=$((PAGE + 1))
done
