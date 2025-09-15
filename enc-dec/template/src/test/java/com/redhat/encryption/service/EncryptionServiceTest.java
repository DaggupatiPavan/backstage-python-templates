package com.redhat.encryption.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class EncryptionServiceTest {

    private EncryptionService encryptionService;

    @BeforeEach
    void setUp() {
        encryptionService = new EncryptionService();
    }

    @Test
    void testGenerateKey() throws Exception {
        String key = encryptionService.generateKey();
        assertNotNull(key);
        assertFalse(key.isEmpty());
    }

    @Test
    void testEncryptDecrypt() throws Exception {
        String originalText = "Hello World!";
        String key = encryptionService.generateKey();
        
        String encryptedText = encryptionService.encrypt(originalText, key);
        assertNotNull(encryptedText);
        assertNotEquals(originalText, encryptedText);
        
        String decryptedText = encryptionService.decrypt(encryptedText, key);
        assertEquals(originalText, decryptedText);
    }

    @Test
    void testDecryptWithWrongKey() {
        assertThrows(Exception.class, () -> {
            String originalText = "Hello World!";
            String key1 = encryptionService.generateKey();
            String key2 = encryptionService.generateKey();
            
            String encryptedText = encryptionService.encrypt(originalText, key1);
            encryptionService.decrypt(encryptedText, key2);
        });
    }
}