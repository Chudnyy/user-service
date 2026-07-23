package pet.integration.users.config

import org.h2.tools.Server
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.flyway.autoconfigure.FlywayMigrationStrategy
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.DependsOn
import org.springframework.context.annotation.Profile
import pet.integration.users.common.H2_PROFILE

@Configuration
@Profile(H2_PROFILE)
internal class H2ServerConfig {

    @Value("\${spring.datasource.server.port:9092}")
    private lateinit var serverPort: String

    @Bean
    fun h2TcpNetworkServer() : Server {
        return Server.createTcpServer("-tcp", "-tcpAllowOthers", "-tcpPort", serverPort, "-ifNotExists").start()
    }

    @Bean
    @DependsOn("h2TcpNetworkServer")
    fun flywayMigrationStrategy(): FlywayMigrationStrategy {
        return FlywayMigrationStrategy { flyway ->
            flyway.repair()
            flyway.migrate()
        }
    }
}