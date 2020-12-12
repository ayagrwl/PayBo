from flask import Flask, jsonify, render_template, request
from database import db as DB
import json

app = Flask(__name__)


@app.route("/admin")
def hello():
    return render_template("index.html")


@app.route("/admin/<mcause>/<scause>")
def getDonations(mcause, scause):
    result = json.loads(DB.getDonations(mcause, scause))
    return jsonify(result)


@app.route("/events", methods=["GET"])
def getEvents():
    result = json.loads(DB.getEvents())
    return jsonify(result)


@app.route("/jsontest")
def testJson():
    result = [
        '{"name": "Ayush", "amount": 100.0, "cause": "Freedom", "tstamp": {"$date": 1607702543266}}',
        '{"name": "Harsh", "amount": 100.0, "cause": "", "tstamp": {"$date": 1607702632723}}',
        '{"name": "Mohit", "amount": 100.0, "cause": "", "tstamp": {"$date": 1607702664453}}',
    ]
    return jsonify(result)


@app.route("/donate", methods=["POST"])
def donate():
    print(request.data)
    data = request.json
    if data == None:
        print("Data Invalid")
    else:
        print("About to process")
        result = DB.donate(
            main_cause=data["cat"],
            sub_cause=data["subcat"],
            name=data["donor"],
            email=data["email"],
            amount=data["amount"],
            cause=data["cause"],
        )
    return "Hello World"


@app.route("/admin/aggreg", methods=["GET"])
def getAggregate():
    result = json.loads(DB.getAggregate())
    return jsonify(result)


@app.route("/admin/aggevent", methods=["GET"])
def getAggregEvents():
    result = json.loads(DB.getAggregEvents())
    return jsonify(result)


if __name__ == "__main__":
    app.run()
