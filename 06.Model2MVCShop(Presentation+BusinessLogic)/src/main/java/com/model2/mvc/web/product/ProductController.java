package com.model2.mvc.web.product;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;

	public ProductController() {
		// default
	}

	// POST /addProduct.do  -> PRG redirect to detail
	@RequestMapping(value="/addProduct.do", method=RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product) throws Exception {
		
		if (product.getManuDate() != null) {
	        String md = product.getManuDate().replaceAll("[^0-9]", "");
	        product.setManuDate(md);
	    }

		
		productService.insertProduct(product);
		// assume prodNo set by DAO/sequence during insert
		return new ModelAndView("redirect:/getProduct.do?prodNo=" + product.getProdNo());
	}

	// GET /getProduct.do  -> /product/getProduct.jsp
	@RequestMapping(value="/getProduct.do", method=RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo) throws Exception {
		Product product = productService.findProduct(prodNo);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/product/getProduct.jsp");
		mv.addObject("product", product);
		return mv;
	}

	
	
	
	// GET /updateProductView.do  -> list page (no prodNo) OR pre-load a product (with prodNo)
	@RequestMapping(value="/updateProductView.do", method=RequestMethod.GET)
	public ModelAndView updateProductView(@ModelAttribute("searchVO") Search searchVO,
	                                      @RequestParam(value="prodNo", required=false) Integer prodNo) throws Exception {

	    ModelAndView mv = new ModelAndView();

	    if (prodNo == null) {
	        // 1) 메뉴 클릭: 목록/관리 화면
	        HashMap<String, Object> map = productService.getProductList(searchVO); // JSP uses map.list, map.totalCount
	        mv.setViewName("/product/updateProductView.jsp");
	        mv.addObject("map", map);
	        mv.addObject("searchVO", searchVO);
	    } else {
	        // 2) 특정 상품 ‘수정’ 버튼 등에서 진입: 선택 상품도 같이 내려줌
	        Product product = productService.findProduct(prodNo);
	        HashMap<String, Object> map = productService.getProductList(searchVO);
	        mv.setViewName("/product/updateProductView.jsp");
	        mv.addObject("product", product);
	        mv.addObject("map", map);
	        mv.addObject("searchVO", searchVO);
	    }
	    return mv;
	}

	
	
	
	// Step: Load the product and show update page
	@RequestMapping(value="/updateProductPageView.do", method=RequestMethod.GET)
	public ModelAndView updateProductPageView(@RequestParam("prodNo") int prodNo) throws Exception {
	    Product product = productService.findProduct(prodNo);

	    ModelAndView mv = new ModelAndView("/product/updateProduct.jsp");
	    mv.addObject("product", product);
	    return mv;
	}
	
	
	
	
	// POST /updateProduct.do  -> PRG redirect to detail
	@RequestMapping(value="/updateProduct.do", method=RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product) throws Exception {
		productService.updateProduct(product);
		return new ModelAndView("redirect:/getProduct.do?prodNo=" + product.getProdNo());
	}

	
	
	// GET /listProduct.do  -> /product/listProduct.jsp
	@RequestMapping(value="/listProduct.do", method=RequestMethod.GET)
	public ModelAndView listProduct(@ModelAttribute("searchVO") Search searchVO) throws Exception {

	    // --- ensure safe page defaults ---
	    int page = searchVO.getPage() <= 0 ? 1 : searchVO.getPage();
	    int pageSize = searchVO.getPageSize() > 0 ? searchVO.getPageSize() : 10;

	    // --- compute row bounds ---
	    searchVO.setStartRowNum((page - 1) * pageSize + 1);
	    searchVO.setEndRowNum(page * pageSize);

	    // --- call service ---
	    HashMap<String, Object> map = productService.getProductList(searchVO);

	    // --- forward to JSP ---
	    ModelAndView mv = new ModelAndView("/product/listProduct.jsp");
	    mv.addObject("map", map);
	    mv.addObject("searchVO", searchVO);

	    return mv;
	}

	
	
	
	
	
}

