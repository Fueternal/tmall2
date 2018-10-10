package comparator;

import java.util.Comparator;

import com.ssm.tmall.entity.Product;

/*
 * ProductReviewComparator 人气比较器, 把 评价数量 多的放前面
 */
public class ProductReviewComparator implements Comparator<Product> {

	@Override
	public int compare(Product p1, Product p2) {
		// TODO Auto-generated method stub
		return p2.getReviewCount() - p1.getReviewCount();
	}

}
