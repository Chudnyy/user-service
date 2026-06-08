package pet.integration.users.service

import pet.integration.users.model.UserDto
import org.springframework.stereotype.Service

@Service
internal class UserInMemoryService {

    private val users = mapOf(
        "a@a.a" to UserDto("John Dou", "a@a.a"),
        "b@b.b" to UserDto("Jane Doe", "b@b.b"),
    )

    fun getAll(): List<UserDto> = users.values.toList()

}