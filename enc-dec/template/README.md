# ${{values.app_name | title}}

${{values.description}}

## Quick Start

This Spring Boot microservice provides secure encryption and decryption capabilities through REST APIs.

### Running Locally

```bash
mvn spring-boot:run
```

### Access Points

- **Application**: http://localhost:${{values.http_port}}
- **Swagger UI**: http://localhost:${{values.http_port}}/swagger-ui.html
- **Health Check**: http://localhost:${{values.http_port}}/actuator/health

## API Usage

### 1. Generate Key
```bash
curl -X GET http://localhost:${{values.http_port}}/api/v1/crypto/generate-key
```

### 2. Encrypt Text
```bash
curl -X POST http://localhost:${{values.http_port}}/api/v1/crypto/encrypt \
  -H "Content-Type: application/json" \
  -d '{"text": "Hello World!", "key": "YOUR_KEY_HERE"}'
```

### 3. Decrypt Text
```bash
curl -X POST http://localhost:${{values.http_port}}/api/v1/crypto/decrypt \
  -H "Content-Type: application/json" \
  -d '{"encryptedText": "ENCRYPTED_TEXT", "key": "YOUR_KEY_HERE"}'
```

## Documentation

Full documentation is available in the `/docs` directory and via Swagger UI.

## Deployment

- **Kubernetes**: See `/k8s` directory
- **Helm**: See `/charts` directory  
- **Docker**: `docker build -t ${{values.app_name}} .`

## Development

- **Java 17**
- **Spring Boot 3.2**
- **Maven**

Run tests: `mvn test`