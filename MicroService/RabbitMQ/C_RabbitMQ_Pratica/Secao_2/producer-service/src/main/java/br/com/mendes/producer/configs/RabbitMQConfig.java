package br.com.mendes.producer.configs;

import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {

    public static final String EXG_NAME_MARKETPLACE = "marketplace.direct";
    public static final String QUEUE_PRODUCT_LOG = "product.log";
    public static final String RK_PRODUCT_LOG = "product.log";

    @Bean
    public Queue queueProductLog() {
        return new Queue(QUEUE_PRODUCT_LOG, false, false, false);
    }

    @Bean
    public DirectExchange directExchange() {
        return new DirectExchange(EXG_NAME_MARKETPLACE, false, false); // Corrigido aqui!
    }

    @Bean
    public Binding binding() {
        return BindingBuilder
                .bind(queueProductLog())
                .to(directExchange())
                .with(RK_PRODUCT_LOG);
    }

}
