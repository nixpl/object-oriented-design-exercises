package pl.uj.task3

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import jakarta.annotation.PostConstruct

@Service
class EagerAuthService {
    private val logger = LoggerFactory.getLogger(EagerAuthService::class.java)

    @PostConstruct
    fun init() {
        logger.info(">>> EAGER Singleton: Initialized during application startup! <<<")
    }

    fun authorize(username: String, password: String): Boolean {
        return username == "admin" && password == "admin123"
    }
}
