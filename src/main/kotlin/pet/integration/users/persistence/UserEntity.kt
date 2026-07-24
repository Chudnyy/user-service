package pet.integration.users.persistence

import jakarta.persistence.Entity
import jakarta.persistence.Id
import pet.integration.users.model.UserDto
import java.time.Instant

@Entity(name = UserEntity.TABLE_NAME)
internal data class UserEntity(
    @Id val email: String,
    val firstName: String,
    val lastName: String,
    val sysCreateTs: Instant
) {
    companion object {
        internal const val TABLE_NAME = "users"

        fun UserEntity.toDto() = UserDto("$firstName $lastName", email)
    }
}
