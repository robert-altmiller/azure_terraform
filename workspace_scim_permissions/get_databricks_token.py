import requests, json, sys

def get_databricks_token(tenant_id, client_id, client_secret, resource_id):
    """get databricks token for a service principal"""
    
    token_url = f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"
    headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    }
    payload = {
        "grant_type": "client_credentials",
        "client_id": client_id,
        "client_secret": client_secret,
        "resource": resource_id
    }

    response = requests.post(token_url, headers=headers, data=payload)
    response_data = json.loads(response.text)
    if "access_token" in response_data:
        return response_data["access_token"]
    else: 
        raise Exception("Could not get access token")


if __name__ == "__main__":
    input_json = json.load(sys.stdin)
    tenant_id = input_json.get("tenant_id")
    client_id = input_json.get("client_id")
    client_secret = input_json.get("client_secret")
    resource_id = input_json.get("resource_id")
    
    token = get_databricks_token(tenant_id, client_id, client_secret, resource_id)
    json.dump({"token": token}, sys.stdout) # output the result as JSON
