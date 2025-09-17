# RHDH Encryption/Decryption API Template

This is a Red Hat Developer Hub (RHDH) template for creating encryption/decryption API services. The template generates a complete Python FastAPI application with Docker support and Swagger UI documentation.

## 🚀 Features

### **Template Features:**
- **Configurable Encryption Methods**: Choose which encryption methods to include (Base64, Fernet, AES)
- **Customizable Parameters**: Port numbers, image names, container names
- **Docker Support**: Complete Docker and Docker Compose configuration
- **Swagger UI**: Interactive API documentation
- **RHDH Integration**: Automatic catalog registration
- **Git Integration**: Creates repository with generated code

### **Generated Application Features:**
- **RESTful API**: Clean and intuitive endpoints
- **Multiple Encryption Methods**: Base64, Fernet, AES-like encryption
- **No-Code Friendly**: Simple JSON requests and responses
- **Interactive Documentation**: Swagger UI at `/docs`
- **Container Ready**: Docker and Docker Compose support

## 📋 Prerequisites

- Red Hat Developer Hub instance
- Access to create templates in RHDH
- Git repository access (GitHub, GitLab, or Bitbucket)
- Docker (for running the generated application)

## 🛠️ Installation in RHDH

### 1. **Add Template to RHDH**

Copy the template files to your RHDH templates directory or register the template through the RHDH UI:

```yaml
# template.yaml (already included in this template)
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
metadata:
  name: enc-dec-api-template
  title: Encryption/Decryption API Template
  # ... rest of the configuration
```

### 2. **Register Template**

In your RHDH `app-config.yaml`, add the template:

```yaml
scaffolder:
  # ... existing configuration
  catalog:
    providers:
      # ... existing providers
      # Add this template to your catalog
```

## 🎯 Using the Template

### 1. **Navigate to Templates**

In RHDH, go to **Create** → **Templates** and select "Encryption/Decryption API Template".

### 2. **Configure Parameters**

Fill in the required parameters:

#### **Project Information**
- **Name**: Unique name for your component (e.g., `my-enc-dec-api`)
- **Owner**: Owner of the component (user or group)
- **Description**: Description of the component
- **Destination**: Target repository URL

#### **API Configuration**
- **API Port**: Port number for the API service (default: 8000)
- **Docker Port**: Port number for Docker container (default: 8000)
- **Docker Image Name**: Name for the Docker image (default: enc-dec-api)
- **Container Name**: Name for the Docker container (default: enc-dec-api)

#### **Encryption Methods**
- **Enable Base64**: Include Base64 encoding/decoding (default: true)
- **Enable Fernet**: Include Fernet symmetric encryption (default: true)
- **Enable AES**: Include AES-like encryption (default: true)

#### **Additional Features**
- **Include Tests**: Add basic test files (default: false)
- **Include CI/CD**: Add basic CI/CD configuration (default: false)
- **Include Monitoring**: Add basic monitoring configuration (default: false)

### 3. **Generate Project**

Click **Create** to generate the project. RHDH will:
1. Create a new repository with the generated code
2. Register the component in the RHDH catalog
3. Provide links to the repository and catalog entry

## 📁 Generated Project Structure

```
{{ componentName }}/
├── main.py              # FastAPI application with encryption/decryption
├── requirements.txt     # Python dependencies
├── Dockerfile          # Docker configuration
├── docker-compose.yml  # Docker Compose configuration
├── catalog-info.yaml   # RHDH catalog registration
├── .gitignore         # Git ignore file
└── README.md          # Project documentation
```

## 🚀 Running the Generated Application

### **Using Docker Compose (Recommended)**

```bash
cd {{ componentName }}
docker-compose up --build
```

Access the application at:
- **API**: `http://localhost:8000`
- **Swagger UI**: `http://localhost:8000/docs`

### **Using Docker**

```bash
cd {{ componentName }}
docker build -t {{ imageName }} .
docker run -p {{ dockerPort }}:{{ apiPort }} {{ imageName }}
```

### **Running Locally**

```bash
cd {{ componentName }}
pip install -r requirements.txt
python main.py
```

## 🔌 API Endpoints

The generated application provides the following endpoints:

### **GET /** 
Root endpoint with API information

### **GET /methods**
Get list of available encryption/decryption methods

### **POST /encrypt**
Encrypt text using specified method

**Request:**
```json
{
  "text": "Hello World",
  "method": "base64",
  "secret_key": "optional-key-for-aes"
}
```

### **POST /decrypt**
Decrypt text using specified method

**Request:**
```json
{
  "encrypted_text": "SGVsbG8gV29ybGQ=",
  "method": "base64",
  "secret_key": "optional-key-for-aes"
}
```

## 🔐 Encryption Methods

### **Base64**
- Simple encoding/decoding
- No key required
- Use case: Basic encoding

### **Fernet**
- Symmetric encryption
- Auto-generated key
- Use case: Secure encryption

### **AES**
- Custom key-based encryption
- Requires secret key
- Use case: Custom encryption

## 📊 RHDH Integration

### **Catalog Registration**
The template automatically registers the component in RHDH with:
- Component metadata
- Owner information
- API documentation links
- Tags and annotations

### **API Documentation**
- Swagger UI accessible through RHDH
- Interactive API testing
- Request/response schemas

## 🔧 Customization

### **Adding New Encryption Methods**

1. Update the template parameters in `template.yaml`
2. Modify the `main.py` template to include new methods
3. Update the documentation

### **Extending the Template**

You can extend this template by:
- Adding more encryption algorithms
- Including authentication/authorization
- Adding monitoring and logging
- Including CI/CD pipelines
- Adding database integration

## 🛡️ Security Considerations

- This is a demo template for educational purposes
- For production use, consider:
  - Proper key management
  - Rate limiting
  - Authentication/authorization
  - HTTPS configuration
  - Error handling and logging

## 📝 Example Usage in RHDH

### **Creating a New Project**

1. Go to RHDH → Create → Templates
2. Select "Encryption/Decryption API Template"
3. Fill in the parameters:
   - Name: `my-secure-api`
   - Owner: `my-team`
   - Description: `Secure encryption API for internal services`
   - Destination: `github.com/my-org/my-secure-api`
4. Click "Create"

### **Result**
- New repository created at `github.com/my-org/my-secure-api`
- Component registered in RHDH catalog
- Ready to run with Docker Compose

## 🤝 Contributing

To contribute improvements to this template:

1. Fork the template repository
2. Make your changes
3. Test the template
4. Submit a pull request

## 📄 License

This template is licensed under the MIT License - feel free to use and modify for your projects.

## 🆘 Support

For issues or questions about this template:
- Check the generated project documentation
- Review the RHDH documentation
- Contact your platform team