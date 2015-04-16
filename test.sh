#!/usr/bin/env sh

read -p "Campaign ID? " CAMPAIGN_ID

if [[ -z "$CAMPAIGN_ID" ]]; then
  exit
fi

echo "Sending test campaign..."

DATA="{
  \"apikey\": \"$IDC_MAILCHIMP_APIKEY\",
  \"cid\": \"$CAMPAIGN_ID\",
  \"test_emails\": [ \"info@idevcenter.com\" ]
}"

curl -s -X POST https://us10.api.mailchimp.com/2.0/campaigns/send-test.json -d "$DATA" > /dev/null

echo "Sending test done..."
