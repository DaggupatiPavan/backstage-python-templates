package com.redhat.encryption.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Response object for text encryption")
public class EncryptionResponse {

    @Schema(description = "Encrypted text in Base64 format", example = "U2FsdGVkX1+vupppZksvRf5pq5g5XjFRIipRkwB0K14=")
    private String encryptedText;

    @Schema(description = "Encryption algorithm used", example = "AES")
    private String algorithm;

    public EncryptionResponse() {}

    public EncryptionResponse(String encryptedText, String algorithm) {
        this.encryptedText = encryptedText;
        this.algorithm = algorithm;
    }

    public String getEncryptedText() {
        return encryptedText;
    }

    public void setEncryptedText(String encryptedText) {
        this.encryptedText = encryptedText;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }
}