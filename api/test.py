import requests
import json
URL = "https://sihapiv3.herokuapp.com/"
import cv2
import base64


# without disease
PARAMS = {'DISTRICT':'Araria', 'YEAR':2020, 'CROP':'BAJRA', 'AREA':1000, 'SEASON':'SUMMER'}
r = requests.post(URL, data = json.dumps(PARAMS))
print(r.json()) 


# with disease
PARAMS = {'disease':10.0,'area_affected':0.75,'stage':1.0}
r = requests.post('https://sihapiv3.herokuapp.com/dis', data = json.dumps(PARAMS))
print(r.json()) 


# base 64 image
content_type = 'image/jpeg'
headers = {'content-type': content_type}
img = cv2.imread('c.jpg')
_, im_arr = cv2.imencode('.jpg', img)  # im_arr: image in Numpy one-dim array format.
im_bytes = im_arr.tobytes()
im_b64 = base64.b64encode(im_bytes)
response = requests.post("https://sihapiv3.herokuapp.com/image", data=im_b64, headers=headers)
print(json.loads(response.text))

