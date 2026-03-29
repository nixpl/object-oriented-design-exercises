package pl.uj.task3

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api")
class ApiController {

    @GetMapping("/data")
    fun getData(): List<String> {
        return listOf("Dog", "Cat", "Elephant", "Tiger", "Lion")
    }

    @PostMapping("/login")
    fun login(@RequestBody request: AuthRequest): ResponseEntity<Map<String, String>> {
        val response = mapOf(
            "status" to "RECEIVED",
            "username" to request.username
        )
        return ResponseEntity.ok(response)
    }
}
