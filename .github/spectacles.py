import requests
import os

# Define API key and IDs
api_key = os.getenv("SPECTACLES_API_KEY")
org_id = "WstGk40UEDhElCWTYiZ9"
project_id = "okvva4n8RCwCWv84IzmD"
suite_id = "ZTnRFH3OqE0We4bqlD3y"
commit = os.getenv("GITHUB_SHA")

# Set the API key in header
headers = {"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"}

# Create a run
create_run_url = "https://app.spectacles.dev/api/v1/runs"
payload = {
    "org_id": org_id,
    "suite_id": suite_id,
    "project_id": project_id,
    "commit": commit,
    "webhooks": {
        "type": "github",
        "commit": commit,
        "repo": os.getenv("GITHUB_REPOSITORY"),
    },
}
create_run_response = requests.post(url=create_run_url, headers=headers, json=payload)
create_run_response.raise_for_status()
