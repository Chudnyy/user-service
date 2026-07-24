package pet.integration.users.service

import org.assertj.core.api.Assertions.assertThat
import org.springframework.beans.factory.annotation.Autowired
import pet.integration.users.AbstractBootTest
import pet.integration.users.model.UserDto
import pet.integration.users.persistence.UserEntity
import pet.integration.users.persistence.UserRepository
import java.time.Instant
import kotlin.test.Test

internal class UserServiceTest(
    @param:Autowired private val userService: UserService,
    @param:Autowired private val userRepository: UserRepository
) : AbstractBootTest() {

    @Test
    fun `get all users`() {
        userRepository.saveAll(
            listOf(
                UserEntity("a@a.a", "John", "Dou", Instant.now()),
                UserEntity("b@b.b", "Jane", "Dou", Instant.now())
            )
        )

        // When
        val users = userService.getAll()

        assertThat(users).hasSize(2)
            .containsExactlyInAnyOrderElementsOf(
                listOf(
                    UserDto("John Dou", "a@a.a"),
                    UserDto("Jane Dou", "b@b.b")
                )
            )
    }

}