import requests
import time

def find_owner_and_git_url(repo_name):
    # Search for the missing portion by sending a request to the GitHub API
    github_api_url = f"https://api.github.com/repos/{repo_name}"
    headers = {"Authorization": "Bearer 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"}
    
    # Make a request to the GitHub API
    response = requests.get(github_api_url, headers=headers)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the response JSON to get the owner (username or organization) and Git URL
        owner = response.json()["owner"]["login"]
        git_url = response.json()["clone_url"]
        return owner, git_url
    else:
        # Handle the case when the GitHub API request is unsuccessful
        print(f"Failed to get information for {repo_name}")
        return None, None

# Read repository names from repos.txt
with open("repos.txt", "r") as file:
    # Remove leading and trailing whitespaces, and ignore empty lines
    repo_names = [line.strip() for line in file if line.strip()]

# Dictionary to store repo_name: (owner, git_url) pairs
repo_info = {}

# Iterate through each repo name and find the corresponding owner and Git URL
for repo_name in repo_names:
    owner, git_url = find_owner_and_git_url(repo_name)
    if owner is not None and git_url is not None:
        repo_info[repo_name] = (owner, git_url)
    # Introduce a delay of 1 second between API requests to avoid rate limiting
    time.sleep(1)

# Print the result
for repo_name, (owner, git_url) in repo_info.items():
    print(f"Repo: {repo_name}, Owner: {owner}, Git URL: {git_url}")
