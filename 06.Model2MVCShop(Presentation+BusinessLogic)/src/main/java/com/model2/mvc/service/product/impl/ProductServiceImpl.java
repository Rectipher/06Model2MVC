package com.model2.mvc.service.product.impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.ProductDao;

@Service("productService")
public class ProductServiceImpl implements ProductService {

    @Autowired
    @Qualifier("productDao")
    private ProductDao productDao;

    public ProductServiceImpl() {
        // default
    }

    @Override
    public Product insertProduct(Product productVO) throws Exception {
        productDao.insertProduct(productVO);
        return productVO;
    }

    @Override
    public Product findProduct(int prodNo) throws Exception {
        return productDao.findProduct(prodNo);
    }

    @Override
    public HashMap<String, Object> getProductList(Search searchVO) throws Exception {
        return productDao.getProductList(searchVO);
    }

    @Override
    public Product updateProduct(Product productVO) throws Exception {
        productDao.updateProduct(productVO);
        return productVO;
    }
}
