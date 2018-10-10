package com.ssm.tmall.util;

public class Page {
	
	private int start;	//每一页的开始位置
	private int count = 5;	//每页显示数量
	private int total;	//数据总数量
	private String param;	//参数
	
	public Page() {
		// TODO Auto-generated constructor stub
	}
	
	//getLast 计算出最后一页开始的数据条数
	public int getLast() {
		int last;
		if (total % count ==0) {
			last = total - count;
		}else {
			last = total - total % count;
		}
		
		return last;
	}
	
	//getTotalPage 根据 每页显示的数量count以及总共有多少条数据total，计算出总共有多少页
	public int getTotalPage() {
		int totalPage;
		if (total % count ==0) {
			totalPage = total / count;
		}else {
			totalPage = total / count + 1;
		}
		if (totalPage == 0) {
			totalPage = 1;
		}
		return totalPage;
	}
	
	//isHasPreviouse 判断是否有前一页
	public boolean isHasPreviouse() {
		if (start == 0) {
			return false;
		}
		return true;
	}
	
	//isHasNext 判断是否有后一页
	public boolean isHasNext() {
		if (getLast()==start) {
			return false;
		}
		return true;
	}

	
	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	@Override
	public String toString() {
		return "Page [start=" + start + ", count=" + count + ", total=" + total + ", getStart()=" + getStart()
        + ", getCount()=" + getCount() + ", isHasPreviouse()=" + isHasPreviouse() + ", isHasNext()="
        + isHasNext() + ", getTotalPage()=" + getTotalPage() + ", getLast()=" + getLast() + "]";
	}

}
