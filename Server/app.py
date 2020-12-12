from flask import Flask, jsonify, render_template, request
from database import db as DB
app = Flask(__name__)

@app.route('/admin')
def hello():
    return render_template("index.html")

@app.route('/donate', methods= ['POST'])
def donate():
    print(request.data)
    data = request.json
    if data == None:
        print("Data Invalid")
    else:
        print("About to process")
        # result = DB.donate(main_cause=data['cat'], sub_cause=data['subcat'], name=data['donor'], amount=data['amount'], cause=data['cause'])
    return "Hello World"    

if __name__ == "__main__":
    app.run()

