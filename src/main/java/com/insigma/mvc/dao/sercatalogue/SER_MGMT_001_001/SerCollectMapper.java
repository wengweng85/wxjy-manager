package com.insigma.mvc.dao.sercatalogue.SER_MGMT_001_001;

import com.insigma.mvc.model.SerCollect;

public interface SerCollectMapper {
    int deleteByPrimaryKey(String collectId);

    int insert(SerCollect record);

    int insertSelective(SerCollect record);

    SerCollect selectByPrimaryKey(String collectId);

    int updateByPrimaryKeySelective(SerCollect record);

    int updateByPrimaryKey(SerCollect record);
}