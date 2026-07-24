package pet.integration.users.controller

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.mockito.kotlin.whenever
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.test.context.bean.override.mockito.MockitoBean
import org.springframework.test.web.servlet.client.RestTestClient
import pet.integration.users.AbstractBootTest
import pet.integration.users.model.UserDto
import pet.integration.users.service.UserService

internal class UserControllerTest(
    @param:Autowired private val userController: UserController,
) : AbstractBootTest() {

    @MockitoBean
    private lateinit var userService: UserService

    private val client = RestTestClient.bindToController(userController).build()

    @Test
    fun `should return all users`() {

        // Given
        val userList = listOf(
            UserDto("John Doe", "a@a.a"),
            UserDto("Jane Doe", "b@b.b"),
        )
        whenever(userService.getAll()).thenReturn(
            userList
        )

        // when
        val actual = client
            .get()
            .uri("$BASE_PATH/users/all")
            .exchange()
            .expectBody(Array<UserDto>::class.java)
            .returnResult()
            .responseBody

        // then
        assertThat(actual).containsExactlyInAnyOrderElementsOf(userList)
    }

}