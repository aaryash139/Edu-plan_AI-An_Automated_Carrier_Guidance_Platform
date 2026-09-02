package com.edupath.config;

import org.apache.catalina.Context;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;

@Configuration
public class JspConfig {

    @Bean
    public WebServerFactoryCustomizer<TomcatServletWebServerFactory> jspTomcatCustomizer() {
        return factory -> factory.addContextCustomizers((Context context) -> {
            File docBase = new File("src/main/webapp");
            if (docBase.exists()) {
                context.setDocBase(docBase.getAbsolutePath());
            }
        });
    }
}
