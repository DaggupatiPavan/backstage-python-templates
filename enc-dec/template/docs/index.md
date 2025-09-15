# ${{values.app_name | title}}

${{values.description}}

## Overview

This is a Spring Boot microservice that provides REST APIs for:
- Text encryption using AES algorithm
- Text decryption using AES algorithm  
- AES key generation

## Features

- **Secure Encryption**: Uses AES-256 encryption
- **RESTful APIs**: Well-documented REST endpoints
- **Swagger Integration**: Interactive API documentation
- **Health Checks**: Kubernetes-ready health endpoints
- **Production Ready**: Includes monitoring and observability

## API Endpoints

### Encryption
- `POST /api/v1/crypto/encrypt` - Encrypt plain text
- `POST /api/v1/crypto/decrypt` - Decrypt encrypted text
- `GET /api/v1/crypto/generate-key` - Generate new encryption key

### Health & Monitoring
- `GET /actuator/health` - Health check endpoint
- `GET /actuator/info` - Application information
- `GET /actuator/metrics` - Application metrics

## Documentation

- **Swagger UI**: Available at `/swagger-ui.html`
- **API Docs**: Available at `/api-docs`

## Quick Start

### Local Development

```bash
# Build the application
mvn clean package

# Run the application
mvn spring-boot:run

# Or run the JAR
java -jar target/${{values.app_name}}-1.0.0.jar
```

### Docker

```bash
# Build Docker image
docker build -t ${{values.app_name}}:latest .

# Run container
docker run -p ${{values.http_port}}:${{values.http_port}} ${{values.app_name}}:latest
```

### Kubernetes Deployment

```bash
# Deploy using kubectl
kubectl apply -f k8s/

# Deploy using Helm
helm install ${{values.app_name}} charts/${{values.app_name}}
```

## Usage Examples

### Generate Key
```bash
curl -X GET "http://localhost:${{values.http_port}}/api/v1/crypto/generate-key"
```

### Encrypt Text
```bash
curl -X POST "http://localhost:${{values.http_port}}/api/v1/crypto/encrypt" \
  -H "Content-Type: application/json" \
  -d '{
    "text": "Hello World!",
    "key": "your-base64-encoded-key"
  }'
```

### Decrypt Text
```bash
curl -X POST "http://localhost:${{values.http_port}}/api/v1/crypto/decrypt" \
  -H "Content-Type: application/json" \
  -d '{
    "encryptedText": "encrypted-base64-text",
    "key": "your-base64-encoded-key"
  }'
```

## Security Considerations

- Keys are not stored by the service
- Use HTTPS in production
- Rotate encryption keys regularly
- Monitor API usage for anomalies
- Implement rate limiting for production

## Configuration

### Environment Variables

- `SPRING_PROFILES_ACTIVE`: Set active Spring profile (dev/prod)
- `SERVER_PORT`: Application server port

### Application Properties

See `application.yml` for full configuration options.

## Monitoring

The service includes:
- Health checks for Kubernetes
- Metrics endpoint for Prometheus
- Structured logging
- Request/response tracing

## Development

### Prerequisites

- Java 17+
- Maven 3.6+
- Docker (optional)

### Building

```bash
mvn clean compile
mvn test
mvn package
```

### Testing

```bash
# Run unit tests
mvn test

# Run integration tests
mvn verify
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the Apache 2.0 License.