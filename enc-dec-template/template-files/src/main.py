from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional
import base64
from cryptography.fernet import Fernet
import hashlib
import os

app = FastAPI(
    title="${{ values.componentName | capitalize }} API",
    description="${{ values.description }}",
    version="1.0.0"
)

# Generate a key for Fernet encryption
key = Fernet.generate_key()
cipher_suite = Fernet(key)

class EncryptionRequest(BaseModel):
    text: str
    method: str = "base64"  # Default method
    secret_key: Optional[str] = None

class DecryptionRequest(BaseModel):
    encrypted_text: str
    method: str = "base64"  # Default method
    secret_key: Optional[str] = None

class EncryptionResponse(BaseModel):
    original_text: str
    encrypted_text: str
    method: str
    success: bool
    message: str

class DecryptionResponse(BaseModel):
    encrypted_text: str
    decrypted_text: str
    method: str
    success: bool
    message: str

@app.get("/")
async def root():
    return {
        "message": "${{ values.componentName | capitalize }} API",
        "version": "1.0.0",
        "endpoints": {
            "encrypt": "/encrypt",
            "decrypt": "/decrypt",
            "methods": "/methods",
            "docs": "/docs"
        }
    }

@app.get("/methods")
async def get_available_methods():
    """Get list of available encryption/decryption methods"""
    methods = []
    {% if values.enableBase64 %}
    methods.append({
        "name": "base64",
        "description": "Base64 encoding/decoding",
        "requires_key": False
    })
    {% endif %}
    {% if values.enableFernet %}
    methods.append({
        "name": "fernet",
        "description": "Fernet symmetric encryption",
        "requires_key": False
    })
    {% endif %}
    {% if values.enableAES %}
    methods.append({
        "name": "aes",
        "description": "AES encryption with custom key",
        "requires_key": True
    })
    {% endif %}
    return {"methods": methods}

@app.post("/encrypt", response_model=EncryptionResponse)
async def encrypt_text(request: EncryptionRequest):
    """Encrypt text using specified method"""
    try:
        method = request.method.lower()
        text = request.text
        
        {% if values.enableBase64 %}
        if method == "base64":
            # Base64 encoding
            encrypted_bytes = base64.b64encode(text.encode('utf-8'))
            encrypted_text = encrypted_bytes.decode('utf-8')
        {% endif %}
        
        {% if values.enableFernet %}
        elif method == "fernet":
            # Fernet encryption
            encrypted_bytes = cipher_suite.encrypt(text.encode('utf-8'))
            encrypted_text = encrypted_bytes.decode('utf-8')
        {% endif %}
        
        {% if values.enableAES %}
        elif method == "aes":
            # Simple AES-like encryption using custom key
            if not request.secret_key:
                raise HTTPException(status_code=400, detail="Secret key is required for AES encryption")
            
            # Create a simple key-based encryption
            key_hash = hashlib.sha256(request.secret_key.encode()).digest()
            encrypted_text = ""
            for i, char in enumerate(text):
                encrypted_char = chr(ord(char) ^ key_hash[i % len(key_hash)])
                encrypted_text += encrypted_char
            # Base64 encode the result
            encrypted_bytes = base64.b64encode(encrypted_text.encode('utf-8'))
            encrypted_text = encrypted_bytes.decode('utf-8')
        {% endif %}
        
        else:
            raise HTTPException(status_code=400, detail=f"Unsupported encryption method: {method}")
        
        return EncryptionResponse(
            original_text=text,
            encrypted_text=encrypted_text,
            method=method,
            success=True,
            message="Text encrypted successfully"
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Encryption failed: {str(e)}")

@app.post("/decrypt", response_model=DecryptionResponse)
async def decrypt_text(request: DecryptionRequest):
    """Decrypt text using specified method"""
    try:
        method = request.method.lower()
        encrypted_text = request.encrypted_text
        
        {% if values.enableBase64 %}
        if method == "base64":
            # Base64 decoding
            decrypted_bytes = base64.b64decode(encrypted_text.encode('utf-8'))
            decrypted_text = decrypted_bytes.decode('utf-8')
        {% endif %}
        
        {% if values.enableFernet %}
        elif method == "fernet":
            # Fernet decryption
            decrypted_bytes = cipher_suite.decrypt(encrypted_text.encode('utf-8'))
            decrypted_text = decrypted_bytes.decode('utf-8')
        {% endif %}
        
        {% if values.enableAES %}
        elif method == "aes":
            # Simple AES-like decryption using custom key
            if not request.secret_key:
                raise HTTPException(status_code=400, detail="Secret key is required for AES decryption")
            
            # First decode base64
            encrypted_bytes = base64.b64decode(encrypted_text.encode('utf-8'))
            encrypted_text = encrypted_bytes.decode('utf-8')
            
            # Then decrypt using the key
            key_hash = hashlib.sha256(request.secret_key.encode()).digest()
            decrypted_text = ""
            for i, char in enumerate(encrypted_text):
                decrypted_char = chr(ord(char) ^ key_hash[i % len(key_hash)])
                decrypted_text += decrypted_char
        {% endif %}
        
        else:
            raise HTTPException(status_code=400, detail=f"Unsupported decryption method: {method}")
        
        return DecryptionResponse(
            encrypted_text=encrypted_text,
            decrypted_text=decrypted_text,
            method=method,
            success=True,
            message="Text decrypted successfully"
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Decryption failed: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=${{ values.apiPort }})