package com.libqa.testsupport;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EntityScan(basePackages = "com.libqa.web.domain")
@EnableJpaRepositories(basePackages = "com.libqa.web.repository")
@Import({DataSourceAutoConfiguration.class, HibernateJpaAutoConfiguration.class})
abstract class RepositoryTestConfiguration {
}
