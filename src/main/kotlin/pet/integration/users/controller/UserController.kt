package pet.integration.users.controller

import pet.integration.users.model.UserDto
import pet.integration.users.service.UserInMemoryService
import io.swagger.v3.oas.annotations.Operation
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("$BASE_PATH/users")
internal class UserController(
    private val userInMemoryService: UserInMemoryService,
) {

    @GetMapping("/all")
    @Operation(summary = "Get all users")
    fun getUsers(): List<UserDto> = userInMemoryService.getAll()

}