#!/usr/bin/env python3

from dotenv import dotenv_values
import requests
import json

def getToken(intraUID, intraSecret):
	data = {
	'grant_type': 'client_credentials',
	'client_id': intraUID,
	'client_secret': intraSecret
	}
	r = requests.post('https://api.intra.42.fr/oauth/token', data=data)
	return(r.json()["access_token"])

def revokeToken(intraToken):
	headers = {
	'Authorization': "Bearer " + intraToken,
	'Content-Type': 'application/json'
	}
	json = {
	"token": intraToken
	}
	r = requests.post('https://api.intra.42.fr/oauth/revoke', json=json, headers=headers)

def getAllPages(intraToken, intra_rate_limit, endpoint):
	last_page = False
	page_number = 1
	headers = {
	'Authorization': "Bearer " + intraToken,
	'Content-Type': 'application/json'
	}
	while not last_page:
		params = {
		"page": page_number
		}
		r = requests.get("https://api.intra.42.fr" + endpoint, headers=headers, params=params)
		my_json = r.content.decode('utf8')
		data = json.loads(my_json)
		print(json.dumps(data))
		try:
			if r.headers["X-Page"] >= r.headers["X-Total"]:
				last_page = True
			else:
				page_number += 1
		except:
			last_page = True

if __name__ == '__main__':
	config = dotenv_values(".env")
	intraUID = config["INTRA_UID"]
	intraSecret = config["INTRA_SECRET"]
	intraRateLimit = config["INTRA_RATE_LIMIT"]
	intraToken = getToken(intraUID, intraSecret)
	getAllPages(intraToken, intraRateLimit, "/v2/tags")
	revokeToken(intraToken)
