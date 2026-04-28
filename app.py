from flask import Flask, jsonify
import socket

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({
        "mensaje": "Bienvenido a la API interna de Netflix v2.0",
        "estado": "Funcionando",
        "hostname": socket.gethostname()
    })

@app.route('/health')
def health():
    # Esta ruta la usará CloudWatch o el Balanceador para monitoreo
    return jsonify({"status": "UP"}), 200

if __name__ == '__main__':
    # Escucha en todas las interfaces en el puerto 5000
    app.run(host='0.0.0.0', port=5000)
