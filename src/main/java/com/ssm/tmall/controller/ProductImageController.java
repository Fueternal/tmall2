package com.ssm.tmall.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.tmall.entity.Product;
import com.ssm.tmall.entity.ProductImage;
import com.ssm.tmall.service.ProductImageService;
import com.ssm.tmall.service.ProductService;
import com.ssm.tmall.util.ImageUtil;
import com.ssm.tmall.util.UploadedImageFile;

@Controller
@RequestMapping("")
public class ProductImageController {
	
	@Autowired
	ProductImageService productImageService;
	@Autowired
	ProductService productService;
	
	@RequestMapping("admin_productImage_list")
	public String listProductImage(Model model, Integer productId) {
		Product p = productService.get(productId);
		List<ProductImage> listSingle = productImageService.list(productId, ProductImageService.type_single);
		List<ProductImage> listDetail = productImageService.list(productId, ProductImageService.type_detail);
		model.addAttribute("p", p);
		model.addAttribute("listSingle", listSingle);
		model.addAttribute("listDetail", listDetail);
		/*for (ProductImage productImage : listSingle) {
			System.out.println(productImage.getImageId()+"--"+productImage.getType());
		}*/
		return "admin/listProductImage";
	}
	
	@RequestMapping("admin_productImage_add")
	public String addProductImage(ProductImage productImage, HttpSession session, UploadedImageFile uploadedImageFile) throws Exception, IOException {
		productImageService.add(productImage);
		
		String fileName = productImage.getImageId() + ".jpg";	//图片的文件名
		String imageFolder;	//图片文件存储位置：路径名称
		String imageFolder_small = null;
		String imageFolder_middle = null;
		
		if (ProductImageService.type_single.equals(productImage.getType())) {
			imageFolder = session.getServletContext().getRealPath("img/productSingle");
			imageFolder_small = session.getServletContext().getRealPath("img/productSingle_small");
			imageFolder_middle = session.getServletContext().getRealPath("img/productSingle_middle");
		}else {
			imageFolder = session.getServletContext().getRealPath("img/productDetail");
		}
		
		File file = new File(imageFolder, fileName);	//在imageFolder路径下新建名为fileName的文件
		file.getParentFile().mkdirs();	//getParentFile()的作用是获得父目录，不然会生成一个fileName的文件夹，而不是文件
		
		uploadedImageFile.getImage().transferTo(file);
		BufferedImage img = ImageUtil.change2jpg(file);
		ImageIO.write(img, "jpg", file);
		if (ProductImageService.type_single.equals(productImage.getType())) {
			File f_small = new File(imageFolder_small, fileName);
			File f_middle = new File(imageFolder_middle, fileName);
			
			ImageUtil.resizeImage(file, 56, 56, f_small);
			ImageUtil.resizeImage(file, 217, 190, f_middle);
		}
		
		return "redirect:/admin_productImage_list?productId=" + productImage.getProductId();
	}
	
	@RequestMapping("admin_productImage_delete")
	public String deleteProductImage(Integer imageId, HttpSession session) {
		ProductImage productImage = productImageService.get(imageId);
		
		String fileName = productImage.getImageId() + ".jpg";
//		System.out.println("---------" + fileName);
		String imageFolder;
		String imageFolder_small = null;
		String imageFolder_middle = null;
		
		if (ProductImageService.type_single.equals(productImage.getType())) {
			imageFolder = session.getServletContext().getRealPath("img/productSingle");
			imageFolder_small = session.getServletContext().getRealPath("img/productSingle_small");
			imageFolder_middle = session.getServletContext().getRealPath("img/productSingle_middle");
			
			File file = new File(imageFolder, fileName);
			File f_small = new File(imageFolder_small, fileName);
			File f_middle = new File(imageFolder_middle, fileName);
			
			if (!file.exists()) {
				file.mkdir();
			}
			file.delete();
			f_small.delete();
			f_middle.delete();
		}else {
			imageFolder = session.getServletContext().getRealPath("img/productDetail");
			File file = new File(imageFolder, fileName);
			if (!file.exists()) {
				file.mkdir();
			}
			file.delete();
		}
		
		productImageService.delete(imageId);
		
		return "redirect:/admin_productImage_list?productId=" + productImage.getProductId();
	}
	
}
