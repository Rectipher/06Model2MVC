package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDao")
public class ProductDaoImpl implements ProductDao {

    // Mapper namespace must match <mapper namespace="..."> in ProductMapper.xml
    private static final String NS = "com.model2.mvc.service.product.ProductMapper.";

    // Expect a bean named "sqlSession" (SqlSessionTemplate) wired in context-mybatis.xml:
    // <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
    //   <constructor-arg ref="sqlSessionFactory"/>
    // </bean>
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSession sqlSession;
    public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
    
    public ProductDaoImpl() {
        // default
    }

    @Override
    public void insertProduct(Product productVO) throws Exception {
        sqlSession.insert(NS + "insertProduct", productVO);
    }

    @Override
    public Product findProduct(int prodNo) throws Exception {
        return sqlSession.selectOne(NS + "findProduct", prodNo);
    }

    @Override
    public HashMap<String, Object> getProductList(Search searchVO) throws Exception {
        // list + count (kept identical to your JDBC DAO contract)
        List<Product> list = sqlSession.selectList(NS + "getProductList", searchVO);
        Integer totalCount = sqlSession.selectOne(NS + "getTotalCount", searchVO);

        HashMap<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("count", totalCount == null ? Integer.valueOf(0) : totalCount);
        return map;
    }

    @Override
    public void updateProduct(Product productVO) throws Exception {
        sqlSession.update(NS + "updateProduct", productVO);
    }

	
}
