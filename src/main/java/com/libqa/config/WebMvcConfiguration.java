package com.libqa.config;

import com.github.jknack.handlebars.helper.StringHelpers;
import com.github.jknack.handlebars.springmvc.HandlebarsViewResolver;
import com.libqa.application.helper.HandlebarsHelper;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.BooleanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.config.annotation.*;

import javax.sql.DataSource;

import static com.libqa.application.util.LibqaConstant.ErrorPagePath.*;

@Configuration
@EnableWebMvc
@Slf4j
public class WebMvcConfiguration extends WebMvcConfigurerAdapter {
    @Value("${libqa.viewResolver.cached}")
    private String viewResolverCached;

    @Override
    public void addInterceptors(final InterceptorRegistry resistry) {
        resistry.addInterceptor(new LoginUserHandlerInterceptor()).addPathPatterns("/", "/*", "/**", "/*/**");
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Bean
    public HandlebarsViewResolver viewResolver() throws Exception {
        HandlebarsViewResolver viewResolver = new HandlebarsViewResolver();
        viewResolver.setOrder(1);
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        viewResolver.setCache(BooleanUtils.toBoolean(viewResolverCached));
        viewResolver.registerHelpers(new HandlebarsHelper());
        viewResolver.registerHelpers(StringHelpers.class);
        return viewResolver;
    }

    @Bean
    public EmbeddedServletContainerCustomizer containerCustomizer() {
        return container -> {
            ErrorPage error401Page = new ErrorPage(HttpStatus.UNAUTHORIZED, ERROR_401);
            ErrorPage error403Page = new ErrorPage(HttpStatus.FORBIDDEN, ERROR_403);
            ErrorPage error404Page = new ErrorPage(HttpStatus.NOT_FOUND, ERROR_404);
            ErrorPage error500Page = new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, ERROR_500);
            container.addErrorPages(error401Page, error403Page, error404Page, error500Page);
        };
    }

    @Bean
    @ConfigurationProperties("spring.datasource")
    public DataSource dataSource() {
        return DataSourceBuilder.create().build();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resource/**").addResourceLocations("/resource/");
    }


}
