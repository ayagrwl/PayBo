from flask import Flask, jsonify, render_template, request
from database import db as DB
import json

app = Flask(__name__)


@app.route("/")
def indexPage():
    return "Welcome to Paybo"


@app.route("/admin")
def hello():
    return render_template("index.html")


@app.route("/addEvent", methods=['GET', 'POST'])
def renderEventPage():
    if request.method == 'GET':
        return render_template("eventscreen.html")
    else:
        data = request.form
        try:
            DB.insertEvent(title=data["title"], description=data["description"],
                       name=data["orgname"], email=data["orgemail"], phone=data["orgphone"])
        except Exception as err:
            print(err)
        return render_template("index.html")


@app.route("/donatevent", methods=["POST"])
def donateEvent():
    data = request.json
    if data == None:
        print("Data Invalid")
        return "Hello"
    else:
        result = DB.donateEvent(
            title=data["title"], name=data["name"], email=data["email"], amount=data["amount"])
        
        return "Hello"


@ app.route("/init")
def initApp():
    DB.makeDummy()
    return "INIT DONE!"


@ app.route("/admin/<mcause>/<scause>")
def getDonations(mcause, scause):
    result=json.loads(DB.getDonations(mcause, scause))
    return jsonify(result)


@ app.route("/events", methods = ["GET"])
def getEvents():
    result=json.loads(DB.getEvents())
    return jsonify(result)


@ app.route("/jsontest")
def testJson():
    result=[
        '{"name": "Ayush", "amount": 100.0, "cause": "Freedom", "tstamp": {"$date": 1607702543266}}',
        '{"name": "Harsh", "amount": 100.0, "cause": "", "tstamp": {"$date": 1607702632723}}',
        '{"name": "Mohit", "amount": 100.0, "cause": "", "tstamp": {"$date": 1607702664453}}',
    ]
    return jsonify(result)


@ app.route("/donate", methods=["POST"])
def donate():
    print(request.data)
    data = request.json
    if data == None:
        print("Data Invalid")
        return 404
    else:
        print("About to process")
        result = DB.donate(
            main_cause = data["cat"],
            sub_cause = data["subcat"],
            name = data["donor"],
            email = data["email"],
            amount = data["amount"],
        )
        return "Hello"


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
