package pl.uj.task3

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api")
class ApiController {

    @GetMapping("/data")
    fun getData(): List<String> {
        return listOf("Dog", "Cat", "Elephant", "Tiger", "Lion")
    }
}
