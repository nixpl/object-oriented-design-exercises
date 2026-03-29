package pl.uj.task3

import org.springframework.context.annotation.Lazy
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api")
class ApiController(
    private val eagerAuthService: EagerAuthService,
    @Lazy private val lazyAuthService: LazyAuthService
) {

    @GetMapping("/data")
    fun getData(): List<String> {
        return listOf("Dog", "Cat", "Elephant", "Tiger", "Lion")
    }

    @PostMapping("/login")
    fun login(
        @RequestBody request: AuthRequest,
        @RequestParam(defaultValue = "eager") type: String
    ): ResponseEntity<Map<String, String>> {
        val isAuthorized = if (type == "lazy") {
            lazyAuthService.authorize(request.username, request.password)
        } else {
            eagerAuthService.authorize(request.username, request.password)
        }

        return if (isAuthorized) {
            ResponseEntity.ok(mapOf("status" to "SUCCESS", "message" to "Logged in successfully!"))
        } else {
            ResponseEntity.status(401).body(mapOf("status" to "ERROR", "message" to "Invalid username or password."))
        }
    }
}
