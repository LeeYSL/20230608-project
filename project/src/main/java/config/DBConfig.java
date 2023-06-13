package config;

import java.beans.PropertyVetoException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
@EnableTransactionManagement //트랜젝션 적용
public class DBConfig {
	@Bean(destroyMethod="close") //객체 제거 시 호출 되는 메서드
	public DataSource dataSource() {
		ComboPooledDataSource ds = new ComboPooledDataSource(); //Connection pool 객체
		try {
			ds.setDriverClass("org.mariadb.jdbc.Driver");
			ds.setJdbcUrl("jdbc:mariadb://14.36.141.71:20000/gdudb33");
			ds.setUser("gdu33");
			ds.setPassword("0630");
			ds.setMaxPoolSize(20);
			ds.setMinPoolSize(3);
			ds.setInitialPoolSize(5);
			
		}catch (PropertyVetoException e) {
		e.printStackTrace();
		
		}
		return ds;
	}
	@Bean
	public TransactionManager transactionManager() { //트랜젝션 처리를 위한 객체
		return new DataSourceTransactionManager(dataSource());
		
	}
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(dataSource());
		bean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		return bean.getObject();
		
	}
	@Bean
	public SqlSessionTemplate sqlSessionTemplate() throws Exception{
		return new SqlSessionTemplate(sqlSessionFactory());
	}
	

}
