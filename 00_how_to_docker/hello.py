from flask import Flask
app = Flask("Hello App")

@app.route('/')
def hello_world():
    return '<h1>Hello World</h1>'
