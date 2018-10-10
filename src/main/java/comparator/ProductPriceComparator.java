package comparator;

import java.util.Comparator;

import com.ssm.tmall.entity.Product;

/*
 * ProductPriceComparator 价格比较器,把 价格低 的放前面
 */
public class ProductPriceComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		// TODO Auto-generated method stub
		return (int) (p1.getPromotePrice() - p2.getPromotePrice());
	}

}
