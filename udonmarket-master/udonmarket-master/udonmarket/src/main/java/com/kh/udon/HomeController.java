package com.kh.udon;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.udon.product.model.service.ProductService;
import com.kh.udon.product.model.vo.ProductDTO;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
    @Autowired
    private ProductService service;
    
	@GetMapping("/")
	public String home(Model model) {

	    /*
	     *     인기상품 10개씩 나눠서 총 20개
	     */
	    
	    List<ProductDTO> products1 = service.oneToTen();
	    List<ProductDTO> products2 = service.elevenToTwenty();
	    
	    model.addAttribute("products1", products1);
	    model.addAttribute("products2", products2);
	  
	    log.debug("product1 = {}" , products1);
	    log.debug("product2 = {}" , products2);
	    
		return "forward:/index.jsp";
	}
	
}
