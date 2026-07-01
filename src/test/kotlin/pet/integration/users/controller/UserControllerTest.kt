package pet.integration.users.controller

import org.assertj.core.api.Assertions.assertThat
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.web.servlet.client.RestTestClient
import pet.integration.users.model.UserDto

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
internal class UserControllerTest(
    @param:Autowired private val userController: UserController,
) {

    private val client = RestTestClient.bindToController(userController).build()

    @Test
    fun `should return all users`() {
        // when
        val actual = client
            .get()
            .uri("$BASE_PATH/users/all")
            .exchange()
            .expectBody(Array<UserDto>::class.java)
            .returnResult()
            .responseBody

        // then
        assertThat(actual).hasSize(2).containsExactlyInAnyOrderElementsOf(
            listOf(
                UserDto("John Dou", "a@a.a"),
                UserDto("Jane Doe", "b@b.b"),
            )
        )
    }

}