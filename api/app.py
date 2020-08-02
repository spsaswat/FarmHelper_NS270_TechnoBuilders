from flask import Flask, request, render_template, send_from_directory, jsonify, Response
import os
import json
import numpy as np
import pandas as pd
import pickle
import cv2
from tensorflow.keras import models,layers,optimizers
import jsonpickle
import base64

diseases=["Corn_(maize)__Cercospora_leaf_spot Gray_leaf_spot",
"Corn(maize)__Common_rust",
"Corn(maize)__Northern_Leaf_Blight",
"Corn(maize)__healthy",
"Potato_Early_blight",
"Potato_Late_blight",
"Potato_healthy",
"Tomato_Bacterial_spot",
"Tomato_Early_blight",
"Tomato_Late_blight",
"Tomato_Leaf_Mold",
"Tomato_Septoria_leaf_spot",
"Tomato_Spider_mites Two-spotted_spider_mite",
"Tomato_Target_Spot",
"Tomato__Tomato_Yellow_Leaf_Curl_Virus",
"Tomato_Tomato_mosaic_virus",
"Tomato_healthy"]



app = Flask(__name__)
APP_ROOT = os.path.dirname(os.path.abspath(__file__))

loaded_model = pickle.load(open('lgbm2.pkl', 'rb'))
model = pickle.load(open('model.pkl', 'rb'))
def convert(list):
  dict={}
  i=0
  for item in list:
    dict[item] = i
    i+=1
  return dict

l1 = ['ARHAR (TUR)', 'BAJRA', 'BANANA', 'BARLEY', 'CASTOR SEED',
       'CORIANDER', 'DRY CHILLIES', 'DRY GINGER', 'GARLIC', 'GRAM',
       'GROUNDNUT', 'HORSEGRAM', 'JOWAR', 'JUTE', 'KESARI', 'LINSEED',
       'MAIZE', 'MASOOR', 'MESTA', 'MOONG', 'ONION',
       'OTHER KHARIF PULSES', 'OTHER RABI PULSES',
       'PEAS & BEANS (PULSES)', 'POTATO', 'RAGI', 'RAPESEED &MUSTARD',
       'RICE', 'SAFFLOWER', 'SANNHAMP', 'SESAMUM', 'SMALL MILLETS',
       'SUGARCANE', 'SUNFLOWER', 'SWEET POTATO', 'TOBACCO', 'TURMERIC',
       'URAD', 'WHEAT']

l1 = convert(l1)

l2 = ['AUTUMN', 'KHARIF', 'RABI', 'SUMMER', 'TOTAL ', 'WHOLE YEAR',
       'WINTER']

l2 = convert(l2)

l3 = ['Araria', 'Arhasia', 'Arval', 'Aurangabad', 'Banka', 'Begusarai',
       'Bhagalpur', 'Bhanka', 'Bhojpur', 'Buxar', 'Darbhanga', 'Devghar',
       'Dumka', 'Gadhwa', 'Gaya', 'Giridih', 'Godda', 'Gopalganj',
       'Gumala', 'Hazaribagh', 'Jamui', 'Jehanabad', 'Kaimur (Bhabua)',
       'Katihar', 'Khagaria', 'Kishanganj', 'Lakhisarai', 'Lohardanga',
       'Madhepura', 'Madhubani', 'Munger', 'Muzaffarpur', 'Nalanda',
       'Nawada', 'Palamau', 'Pashchim Champaran', 'Patna',
       'Purba Champaran', 'Purnia', 'Ranchi', 'Rohtas', 'Saharsa',
       'Sahebganj', 'Samastipur', 'Saran', 'Sheikhpura', 'Sheohar',
       'Singhbhum', 'Singhbhur(west)', 'Sitamarhi', 'Siwan', 'Sumal',
       'Supaul', 'Vaishali', 'Zamui']

l3 = convert(l3)


@app.route('/',methods=['POST'])
def results():

    data = request.get_json(force=True)
    print(data)
    data['SEASON'] = float(l2[data['SEASON']])
    data['DISTRICT'] = float(l3[data['DISTRICT']])
    data['CROP'] = float(l1[data['CROP']])
    prediction = model.predict([np.array(list(data.values()))])
    print(np.array(list(data.values())))
    output = round(prediction[0],2)
    return jsonify(output)

@app.route('/dis',methods=['POST'])
def results2():

    data = request.get_json(force=True)
    print(data)
    data['disease'] = float(data['disease'])
    data['area_affected'] = float(data['area_affected'])
    data['stage'] = float(data['stage'])
    da = pd.DataFrame(list(data.values())).T
    da.columns = ['disease','area_affected','stage']
    x = loaded_model.predict(da)
    return jsonify(float(round(x[0],2)))

@app.route('/image', methods=['POST'])
def test():
    r = request
    im_bytes = base64.b64decode(r.data)
    im_arr = np.frombuffer(im_bytes, dtype=np.uint8)  # im_arr is one-dim Numpy array
    img = cv2.imdecode(im_arr, flags=cv2.IMREAD_COLOR)

    # do some fancy processing here....
    model1=models.load_model('plant_disease.h5', compile=True)
    
    img3 = cv2.cvtColor(img,cv2.COLOR_BGR2RGB)
    img3 = cv2.resize(img3,(224,224))
    img4 = np.reshape(img3,[1,224,224,3])
    img4=img4/255.0
    disease = model1.predict_classes(img4)
    prediction = disease[0]
    outp = diseases[prediction]
    print(diseases[prediction])

    # build a response dict to send back to client
    response = {'message': outp
                }
    # encode response using jsonpickle
    response_pickled = jsonpickle.encode(response)

    return Response(response=response_pickled, status=200, mimetype="application/json")

if __name__ == "__main__":
    #port = int(os.environ.get("PORT", 5000))
    app.run(debug=True)

