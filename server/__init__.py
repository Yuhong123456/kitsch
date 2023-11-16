from flask import Flask,jsonify,request
import json
from flask_cors import CORS
import requests
from time import sleep

import sqlite3
con = sqlite3.connect("server/database.sqlite",check_same_thread=False)

app = Flask(__name__)
CORS(app)



#cur.execute("""INSERT OR IGNORE INTO analysis VALUES (?,?)""",['a','b'])
#cur.execute("""UPDATE analysis SET persona=? WHERE chatId=?""",['a','b'])

chatid='Felix'
#To be or not to be, that is the question.
def ai_char(context,chatId):
    response = requests.post("http://127.0.0.1:3000/api/v1/prediction/3a8d534d-4fad-4a7e-bf22-3617ac488f89", json={'question':context})
    cur = con.cursor()
    r = json.loads(response.content.decode())
    cur.execute("""INSERT INTO analysis VALUES (?,?);""",[chatid,r['text']])
    con.commit()

@app.route("/get_analysis",methods=["GET"])
def get_char():
    cur = con.cursor()
    cur.execute("""SELECT persona from analysis where chatId=?""",[chatid])
    return jsonify({'message':cur.fetchone()[0]})

@app.route("/send_message_to_character_ai",methods=["POST"])
def ai_msg():
    print(request.get_data())
    form = json.loads(request.get_data().decode())
    
    response = requests.post("http://127.0.0.1:3000/api/v1/prediction/eb750089-c94e-40ac-9804-7ee3c88710e8", json={'question':form['message'],'chatId':chatid})
    
    r = json.loads(response.content.decode())
    ai_char(f"User: {form['message']} \n Chatbot: {r['text']}",chatid)
    return jsonify({'aiResponse':r['text']})




