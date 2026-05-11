package com.example.authservice

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController



@RestController
@RequestMapping("/api/users")
class UserController(
    private val authService: AuthService
) {

    private val users = listOf(
        UserDto(1, "admin_test"),
        UserDto(2, "user_jankowalski"),
        UserDto(3, "guest_123")
    )

    @GetMapping
    fun getUsers(): List<UserDto> {
        return users
    }

    @PostMapping("/auth")
    fun authorize(@RequestBody authRequest: AuthRequest): String {
        val isAuthorized = authService.authorize(authRequest)
        return if (isAuthorized) {
            "Autoryzacja przebiegła pomyślnie!"
        } else {
            "Błąd autoryzacji. Zły użytkownik lub hasło."
        }
    }
}