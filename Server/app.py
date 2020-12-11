from flask import Flask, jsonify, render_template, request
from database import db 
app = Flask(__name__)

@app.route('/admin')
def hello():
    return render_template("index.html")

@app.route('/donate', methods= ['POST'])
def donate():
    print(request)

if __name__ == "__main__":
    app.run()

