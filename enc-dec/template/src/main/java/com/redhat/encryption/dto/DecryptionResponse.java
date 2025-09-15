package com.redhat.encryption.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Response object for text decryption")
public class DecryptionResponse {

    @Schema(description = "Decrypted plain text", example = "Hello World!")
    private String plainText;

    public DecryptionResponse() {}

    public DecryptionResponse(String plainText) {
        this.plainText = plainText;
    }

    public String getPlainText() {
        return plainText;
    }

    public void setPlainText(String plainText) {
        this.plainText = plainText;
    }
}