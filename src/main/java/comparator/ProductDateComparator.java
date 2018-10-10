package comparator;

import java.util.Comparator;

import com.ssm.tmall.entity.Product;

/*
 * ProductDateComparator 新品比较器,把 创建日期 晚 的放前面
 */
public class ProductDateComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		// TODO Auto-generated method stub
		return p2.getCreateDate().compareTo(p1.getCreateDate());
	}

}
