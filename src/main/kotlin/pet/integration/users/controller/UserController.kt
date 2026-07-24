package pet.integration.users.controller

import pet.integration.users.model.UserDto
import io.swagger.v3.oas.annotations.Operation
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import pet.integration.users.service.UserService

@RestController
@RequestMapping("$BASE_PATH/users")
internal class UserController(
    private val userService: UserService,
) {

    @GetMapping("/all")
    @Operation(summary = "Get all users")
    fun getUsers(): List<UserDto> = userService.getAll()

}