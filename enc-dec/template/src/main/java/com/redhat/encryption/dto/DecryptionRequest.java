package com.redhat.encryption.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;

@Schema(description = "Request object for text decryption")
public class DecryptionRequest {

    @Schema(description = "Encrypted text in Base64 format", example = "U2FsdGVkX1+vupppZksvRf5pq5g5XjFRIipRkwB0K14=")
    @NotBlank(message = "Encrypted text cannot be blank")
    private String encryptedText;

    @Schema(description = "Base64 encoded decryption key", example = "YourBase64EncodedKeyHere")
    @NotBlank(message = "Key cannot be blank")
    private String key;

    public DecryptionRequest() {}

    public DecryptionRequest(String encryptedText, String key) {
        this.encryptedText = encryptedText;
        this.key = key;
    }

    public String getEncryptedText() {
        return encryptedText;
    }

    public void setEncryptedText(String encryptedText) {
        this.encryptedText = encryptedText;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}