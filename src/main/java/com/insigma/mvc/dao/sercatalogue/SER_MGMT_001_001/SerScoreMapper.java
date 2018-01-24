package com.insigma.mvc.dao.sercatalogue.SER_MGMT_001_001;

import com.insigma.mvc.model.SerScore;

public interface SerScoreMapper {
    int deleteByPrimaryKey(String scoreId);

    int insert(SerScore record);

    int insertSelective(SerScore record);

    SerScore selectByPrimaryKey(String scoreId);

    int updateByPrimaryKeySelective(SerScore record);

    int updateByPrimaryKey(SerScore record);
}