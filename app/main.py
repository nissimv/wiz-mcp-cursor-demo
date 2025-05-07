import requests
import yaml

def fetch_data():
    response = requests.get("http://example.com/api")
    print(response.text)

if __name__ == "__main__":
    fetch_data()
