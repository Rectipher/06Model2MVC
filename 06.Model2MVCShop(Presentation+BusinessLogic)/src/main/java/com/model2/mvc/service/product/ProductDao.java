package com.model2.mvc.service.product;

import java.util.HashMap;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao {

    /**
     * Insert a new product.
     * @param productVO Product to insert
     * @throws Exception
     */
    public void insertProduct(Product productVO) throws Exception;

    /**
     * Find a product by its primary key (PROD_NO).
     * @param prodNo Product number
     * @return Product
     * @throws Exception
     */
    public Product findProduct(int prodNo) throws Exception;

    /**
     * Get a list of products with pagination and search filters.
     * Returns a map with:
     *   - "list"  : java.util.List<Product>
     *   - "count" : java.lang.Integer (total count)
     *
     * @param searchVO SearchVO with searchCondition, searchKeyword, page, pageUnit
     * @return HashMap with list + count
     * @throws Exception
     */
    public HashMap<String, Object> getProductList(Search searchVO) throws Exception;

    /**
     * Update product information.
     * @param productVO Product with updated values
     * @throws Exception
     */
    public void updateProduct(Product productVO) throws Exception;

}
