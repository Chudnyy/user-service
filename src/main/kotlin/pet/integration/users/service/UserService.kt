package pet.integration.users.service

import org.springframework.stereotype.Service
import pet.integration.users.model.UserDto
import pet.integration.users.persistence.UserEntity.Companion.toDto
import pet.integration.users.persistence.UserRepository

@Service
internal class UserService(
    private val repository: UserRepository,
) {

    fun getAll(): List<UserDto> = repository.findAll().map { it.toDto() }
}