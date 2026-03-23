from flask import Blueprint, request, send_file, jsonify
from flask_jwt_extended import jwt_required
from rembg import remove
from PIL import Image
from io import BytesIO

images_bp = Blueprint('images', __name__)


@images_bp.route('/remove-background', methods=['POST'])
@jwt_required()
def remove_background():
    if 'file' not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files['file']
    img = Image.open(file.stream)
    output = remove(img)
    byte_io = BytesIO()
    output.save(byte_io, format='PNG')
    byte_io.seek(0)
    return send_file(byte_io, mimetype='image/png')
