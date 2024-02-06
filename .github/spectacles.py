import requests
import time
import os
import sys

# Define API key and IDs
api_key = os.getenv("SPECTACLES_API_KEY")
org_id = "WstGk40UEDhElCWTYiZ9"  # Your organization ID
project_id = "okvva4n8RCwCWv84IzmD"  # Your project ID
suite_id = "ZTnRFH3OqE0We4bqlD3y"  # Your suite ID
commit = os.getenv("GIT_COMMIT")

# Set the API key in header
headers = {"Authorization": f"Bearer {api_key}", "Content-Type": "application/json"}

# Create a run
create_run_url = "https://app.spectacles.dev/api/v1/runs"
payload = {
    "org_id": org_id,
    "suite_id": suite_id,
    "project_id": project_id,
    "commit": commit,
}
create_run_response = requests.post(url=create_run_url, headers=headers, json=payload)
create_run_response.raise_for_status()
run_id = create_run_response.json()["run_id"]

run_status = "queued"
run_url = (
    f"https://app.spectacles.dev/api/v1/org/{org_id}/proj/{project_id}/run/{run_id}"
)

print(
    f"Find run details at: https://app.spectacles.dev/org/{org_id}/proj/{project_id}/run/{run_id}"
)

while run_status not in ["cancelled", "error", "passed", "failed"]:

    # Naively wait for 15 seconds to check
    time.sleep(15)

    # Get the run's results
    run_response = requests.get(url=run_url, headers=headers)

    run_status = run_response.json()["status"]

if run_status != "passed":
    sys.exit(100)
