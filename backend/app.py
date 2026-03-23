from flask import Flask
from flask_jwt_extended import JWTManager
from config import Config
from db import init_db
from routes.auth import auth_bp
from routes.images import images_bp

app = Flask(__name__)
app.config.from_object(Config)

JWTManager(app)
init_db()

app.register_blueprint(auth_bp)
app.register_blueprint(images_bp)

if __name__ == '__main__':
    app.run(debug=True)
