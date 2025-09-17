# ${{ values.componentName | capitalize }}

${{ values.description }}

## Features

- **Multiple Encryption Methods**: 
  {%- if values.enableBase64 %} Base64{% endif %}
  {%- if values.enableFernet %}{% if values.enableBase64 %}, {% endif %} Fernet{% endif %}
  {%- if values.enableAES %}{% if values.enableBase64 or values.enableFernet %}, {% endif %} AES-like{% endif %}
- **RESTful API**: Clean and intuitive API endpoints
- **Swagger UI**: Interactive API documentation at `/docs`
- **Docker Support**: Easy containerization and deployment
- **No-Code Friendly**: Simple JSON requests and responses

## Quick Start

### Using Docker Compose (Recommended)

1. Navigate to the project directory
2. Run with Docker Compose:

```bash
docker-compose up --build
```

3. Access the API at `http://localhost:${{ values.dockerPort }}`
4. View Swagger UI at `http://localhost:${{ values.dockerPort }}/docs`

### Using Docker

1. Build the Docker image:
```bash
docker build -t ${{ values.imageName }} .
```

2. Run the container:
```bash
docker run -p ${{ values.dockerPort }}:${{ values.apiPort }} ${{ values.imageName }}
```

### Running Locally

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the application:
```bash
python main.py
```

## API Endpoints

### Base URL: `http://localhost:${{ values.dockerPort }}`

#### GET `/`
Root endpoint with API information.

#### GET `/methods`
Get list of available encryption/decryption methods.

#### POST `/encrypt`
Encrypt text using specified method.

**Request Body:**
```json
{
  "text": "Hello World",
  "method": "base64",
  "secret_key": "optional-key-for-aes"
}
```

**Response:**
```json
{
  "original_text": "Hello World",
  "encrypted_text": "SGVsbG8gV29ybGQ=",
  "method": "base64",
  "success": true,
  "message": "Text encrypted successfully"
}
```

#### POST `/decrypt`
Decrypt text using specified method.

**Request Body:**
```json
{
  "encrypted_text": "SGVsbG8gV29ybGQ=",
  "method": "base64",
  "secret_key": "optional-key-for-aes"
}
```

**Response:**
```json
{
  "encrypted_text": "SGVsbG8gV29ybGQ=",
  "decrypted_text": "Hello World",
  "method": "base64",
  "success": true,
  "message": "Text decrypted successfully"
}
```

## Encryption Methods

{% if values.enableBase64 %}
### Base64
- **Description**: Simple base64 encoding/decoding
- **Requires Key**: No
- **Use Case**: Basic encoding, not secure encryption
{% endif %}

{% if values.enableFernet %}
### Fernet
- **Description**: Symmetric encryption using Fernet
- **Requires Key**: No (auto-generated)
- **Use Case**: Secure encryption for sensitive data
{% endif %}

{% if values.enableAES %}
### AES
- **Description**: Simple AES-like encryption with custom key
- **Requires Key**: Yes
- **Use Case**: Custom key-based encryption
{% endif %}

## Example Usage with curl

### Encrypt with Base64
```bash
curl -X POST "http://localhost:${{ values.dockerPort }}/encrypt" \
     -H "Content-Type: application/json" \
     -d '{"text": "Hello World", "method": "base64"}'
```

### Decrypt with Base64
```bash
curl -X POST "http://localhost:${{ values.dockerPort }}/decrypt" \
     -H "Content-Type: application/json" \
     -d '{"encrypted_text": "SGVsbG8gV29ybGQ=", "method": "base64"}'
```

{% if values.enableAES %}
### Encrypt with AES
```bash
curl -X POST "http://localhost:${{ values.dockerPort }}/encrypt" \
     -H "Content-Type: application/json" \
     -d '{"text": "Secret Message", "method": "aes", "secret_key": "my-secret-key"}'
```
{% endif %}

## Swagger UI

Access the interactive API documentation at:
- **Local**: `http://localhost:${{ values.dockerPort }}/docs`
- **Docker**: `http://localhost:${{ values.dockerPort }}/docs`

The Swagger UI provides:
- Interactive API testing
- Request/response schemas
- Try-it-out functionality
- Detailed endpoint documentation

## Development

### Project Structure
```
{{ values.componentName }}/
├── main.py              # FastAPI application
├── requirements.txt     # Python dependencies
├── Dockerfile          # Docker configuration
├── docker-compose.yml  # Docker Compose configuration
└── README.md          # This file
```

## Security Notes

- This is a demo application for educational purposes
- For production use, consider:
  - Using proper key management
  - Implementing rate limiting
  - Adding authentication/authorization
  - Using HTTPS
  - Proper error handling and logging

## Owner

**Owner**: ${{ values.owner }}

## License

MIT License - feel free to use and modify for your projects.