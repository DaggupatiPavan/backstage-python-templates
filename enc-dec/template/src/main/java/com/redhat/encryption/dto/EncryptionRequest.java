package com.redhat.encryption.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

@Schema(description = "Request object for text encryption")
public class EncryptionRequest {

    @Schema(description = "Plain text to encrypt", example = "Hello World!")
    @NotBlank(message = "Text cannot be blank")
    private String text;

    @Schema(description = "Base64 encoded encryption key", example = "YourBase64EncodedKeyHere")
    @NotBlank(message = "Key cannot be blank")
    private String key;

    public EncryptionRequest() {}

    public EncryptionRequest(String text, String key) {
        this.text = text;
        this.key = key;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}