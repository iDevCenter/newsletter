#!/usr/bin/env sh

read -p "Issue number? " ISSUE_NO

if [[ -z "$ISSUE_NO" ]]; then
  exit
fi

./build.sh

echo "Creating campaign..."

HTML=$(cat build/index.html)
HTML=$(echo "$HTML" | sed 's/\"/\\"/g' | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g')

DATA="{
  \"apikey\": \"$IDC_MAILCHIMP_APIKEY\",
  \"type\": \"regular\",
  \"options\": {
    \"list_id\": \"621e10fdc0\",
    \"subject\": \"iDevCenter Newsletter #$ISSUE_NO\",
    \"from_email\": \"newsletter@idevcenter.com\",
    \"from_name\": \"iDevCenter Newsletter\",
    \"inline_css\": true
  },
  \"content\": {
    \"html\": \"$HTML\"
  }
}"

CAMPAIGN=$(curl -s -X POST https://us10.api.mailchimp.com/2.0/campaigns/create.json -d "$DATA")
CAMPAIGN_ID=$(echo $CAMPAIGN | jq -r '.id')
CAMPAIGN_ARCHIVE_URL=$(echo $CAMPAIGN | jq -r '.archive_url_long')

echo "Campaign ID: \"$CAMPAIGN_ID\""
echo "Campaign Archive URL: \"$CAMPAIGN_ARCHIVE_URL\""

echo "Creating campaign done."
