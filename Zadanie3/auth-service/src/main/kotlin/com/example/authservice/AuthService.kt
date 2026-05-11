package com.example.authservice

import org.springframework.stereotype.Service

@Service
class AuthService {

    fun authorize(authRequest: AuthRequest): Boolean {
        return authRequest.username == "admin" && authRequest.password == "secret123"
    }
}
