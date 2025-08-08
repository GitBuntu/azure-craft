#!/bin/bash

# Parameters with default values
POLICY_NAME=${1:-"require-multiple-tags-policy"}
DISPLAY_NAME=${2:-"Require Multiple Tags on Resource Groups"}
POLICY_TYPE=${3:-"Custom"}
MODE=${4:-"All"}
CATEGORY=${5:-"Tags"}
CREATED_BY=${6:-$(az account show --query user.name -o tsv)}

# Required tags array
declare -a REQUIRED_TAGS=("Compliance" "CostCenter" "DataSensitivity" "Environment" "Location" "Owner" "Project")

# Generate the description dynamically based on the required tags
TAGS_LIST=$(printf ", %s" "${REQUIRED_TAGS[@]}")
TAGS_LIST=${TAGS_LIST:2}  # Remove the leading ", "
DESCRIPTION="This policy ensures that all newly created or updated resource groups within this management group and its child subscriptions include a standardized set of governance tags. Specifically, it enforces the presence of the following tags: ${TAGS_LIST}. This helps maintain consistent tagging for cost management, security classification, accountability, and compliance tracking across all governed environments."

# Create the policy definition JSON
POLICY_DEFINITION=$(cat << EOF
{
  "properties": {
    "displayName": "$DISPLAY_NAME",
    "policyType": "$POLICY_TYPE",
    "mode": "$MODE",
    "description": "$DESCRIPTION"
    "metadata": {
      "category": "$CATEGORY",
      "createdBy": "$CREATED_BY",
      "createdOn": "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
    },
    "policyRule": {
      "if": {
        "anyOf": $(
          # Generate the tag conditions dynamically
          conditions=""
          for tag in "${REQUIRED_TAGS[@]}"; do
            conditions+="{
            \"field\": \"tags['$tag']\",
            \"exists\": \"false\"
          },"
          done
          # Remove the trailing comma and wrap in brackets
          conditions=$(echo "$conditions" | sed 's/,$//')
          echo "[$conditions]"
        )
          {
            "field": "tags['Environment']",
            "exists": "false"
          },
          {
            "field": "tags['Location']",
            "exists": "false"
          },
          {
            "field": "tags['Owner']",
            "exists": "false"
          },
          {
            "field": "tags['Project']",
            "exists": "false"
          }
        ]
      },
      "then": {
        "effect": "deny"
      }
    }
  }
}
EOF
)

# Create the policy definition
echo "Creating Azure Policy Definition..."
az policy definition create \
  --name "$POLICY_NAME" \
  --subscription "${7:-$(az account show --query id -o tsv)}" \
  --mode "$MODE" \
  --rules "$POLICY_DEFINITION"

echo "Policy definition created successfully!"