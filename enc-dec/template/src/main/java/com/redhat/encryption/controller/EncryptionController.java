package com.redhat.encryption.controller;

import com.redhat.encryption.dto.EncryptionRequest;
import com.redhat.encryption.dto.EncryptionResponse;
import com.redhat.encryption.dto.DecryptionRequest;
import com.redhat.encryption.dto.DecryptionResponse;
import com.redhat.encryption.service.EncryptionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/crypto")
@Tag(name = "Encryption Service", description = "APIs for encryption and decryption operations")
public class EncryptionController {

    @Autowired
    private EncryptionService encryptionService;

    @Operation(summary = "Encrypt text", description = "Encrypts the provided plain text using AES encryption")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Text encrypted successfully",
                content = { @Content(mediaType = "application/json",
                        schema = @Schema(implementation = EncryptionResponse.class)) }),
        @ApiResponse(responseCode = "400", description = "Invalid input",
                content = @Content),
        @ApiResponse(responseCode = "500", description = "Internal server error",
                content = @Content)
    })
    @PostMapping("/encrypt")
    public ResponseEntity<EncryptionResponse> encrypt(
            @Parameter(description = "Encryption request containing text to encrypt")
            @Valid @RequestBody EncryptionRequest request) {
        try {
            String encryptedText = encryptionService.encrypt(request.getText(), request.getKey());
            EncryptionResponse response = new EncryptionResponse(encryptedText, "AES");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @Operation(summary = "Decrypt text", description = "Decrypts the provided encrypted text using AES decryption")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Text decrypted successfully",
                content = { @Content(mediaType = "application/json",
                        schema = @Schema(implementation = DecryptionResponse.class)) }),
        @ApiResponse(responseCode = "400", description = "Invalid input",
                content = @Content),
        @ApiResponse(responseCode = "500", description = "Internal server error",
                content = @Content)
    })
    @PostMapping("/decrypt")
    public ResponseEntity<DecryptionResponse> decrypt(
            @Parameter(description = "Decryption request containing encrypted text to decrypt")
            @Valid @RequestBody DecryptionRequest request) {
        try {
            String decryptedText = encryptionService.decrypt(request.getEncryptedText(), request.getKey());
            DecryptionResponse response = new DecryptionResponse(decryptedText);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @Operation(summary = "Generate encryption key", description = "Generates a new AES encryption key")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Key generated successfully"),
        @ApiResponse(responseCode = "500", description = "Internal server error")
    })
    @GetMapping("/generate-key")
    public ResponseEntity<String> generateKey() {
        try {
            String key = encryptionService.generateKey();
            return ResponseEntity.ok(key);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
}