package comparator;

import java.util.Comparator;

import com.ssm.tmall.entity.Product;

/*
 * ProductSaleCountComparator 销量比较器,把 销量高 的放前面
 */
public class ProductSaleCountComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		// TODO Auto-generated method stub
		return p2.getSaleCount() - p1.getSaleCount();
	}

}
