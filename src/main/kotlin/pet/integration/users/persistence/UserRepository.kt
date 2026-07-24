package pet.integration.users.persistence

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
internal interface UserRepository : JpaRepository<UserEntity, String> {
}