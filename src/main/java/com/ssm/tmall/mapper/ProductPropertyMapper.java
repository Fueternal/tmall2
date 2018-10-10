package com.ssm.tmall.mapper;

import com.ssm.tmall.entity.ProductProperty;
import com.ssm.tmall.entity.ProductPropertyExample;
import java.util.List;

public interface ProductPropertyMapper {
    int deleteByPrimaryKey(Integer productPropertyId);

    int insert(ProductProperty record);

    int insertSelective(ProductProperty record);

    List<ProductProperty> selectByExample(ProductPropertyExample example);

    ProductProperty selectByPrimaryKey(Integer productPropertyId);

    int updateByPrimaryKeySelective(ProductProperty record);

    int updateByPrimaryKey(ProductProperty record);
}