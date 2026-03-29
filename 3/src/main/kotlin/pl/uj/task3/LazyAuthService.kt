package pl.uj.task3

import org.slf4j.LoggerFactory
import org.springframework.context.annotation.Lazy
import org.springframework.stereotype.Service
import jakarta.annotation.PostConstruct

@Service
@Lazy
class LazyAuthService {
    private val logger = LoggerFactory.getLogger(LazyAuthService::class.java)

    @PostConstruct
    fun init() {
        logger.info(">>> LAZY Singleton: Initialized just now! <<<")
    }

    fun authorize(username: String, password: String): Boolean {
        return username == "admin" && password == "admin123"
    }
}
