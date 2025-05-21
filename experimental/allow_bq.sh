#!/bin/bash

#### Use this script at your own risk. The author assumes no responsibility for any damages or losses incurred through its use.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}" || exit

# shellcheck source=experimental/config.env.sample
source "${SCRIPT_DIR}"/config.env

aw_folder=$(gcloud resource-manager folders list --organization="${ORGANIZATION_ID}" | grep StellarEngine-"${PREFIX}" | awk '{print $3}')
echo 'constraint: constraints/gcp.restrictServiceUsage' > tmp_aw_policy.yaml
gcloud resource-manager org-policies describe constraints/gcp.restrictServiceUsage --folder="${aw_folder}" --format='yaml(listPolicy.allowedValues)' >> tmp_aw_policy.yaml
{
  echo "  - bigquery.googleapis.com"
  echo "  - bigqueryconnection.googleapis.com"
  echo "  - bigquerydatapolicy.googleapis.com"
  echo "  - bigquerydatatransfer.googleapis.com"
  echo "  - bigquerymigration.googleapis.com"
  echo "  - bigqueryreservation.googleapis.com"
  echo "  - bigquerystorage.googleapis.com"

} >> tmp_aw_policy.yaml

gcloud resource-manager org-policies set-policy tmp_aw_policy.yaml --folder="${aw_folder}"