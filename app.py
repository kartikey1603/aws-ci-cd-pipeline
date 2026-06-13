from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return {
        "status": "success",
        "message": "Hello World! Deployed successfully to Floci AWS EC2!",
        "environment": "Production-Emulated"
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)