#!/usr/bin/env sh

read -p "Campaign ID? " CAMPAIGN_ID

if [[ -z "$CAMPAIGN_ID" ]]; then
  exit
fi

echo "Sending campaign..."

DATA="{
  \"apikey\": \"$IDC_MAILCHIMP_APIKEY\",
  \"cid\": \"$CAMPAIGN_ID\"
}"

curl -s -X POST https://us10.api.mailchimp.com/2.0/campaigns/send.json -d "$DATA" > /dev/null

echo "Sending done..."
