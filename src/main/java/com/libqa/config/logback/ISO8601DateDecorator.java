package com.libqa.config.logback;

import com.fasterxml.jackson.databind.MappingJsonFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.ISO8601DateFormat;
import net.logstash.logback.decorate.JsonFactoryDecorator;

/**
 * Created by bakas.
 *
 * @author eunsebi
 * @since 2017-03-04
 */
public class ISO8601DateDecorator implements JsonFactoryDecorator {

    @Override
    public MappingJsonFactory decorate(MappingJsonFactory factory) {

        ObjectMapper codec = factory.getCodec();
        codec.setDateFormat(new ISO8601DateFormat());

        return factory;
    }

}
