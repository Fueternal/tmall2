package com.ssm.tmall.entity;

public class ProductProperty {
    private Integer productPropertyId;

    private Integer productId;

    private Integer propertyId;

    private String value;
    
    private Property property;	 //增加类别属性的关联

    public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public Integer getProductPropertyId() {
        return productPropertyId;
    }

    public void setProductPropertyId(Integer productPropertyId) {
        this.productPropertyId = productPropertyId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(Integer propertyId) {
        this.propertyId = propertyId;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }
}