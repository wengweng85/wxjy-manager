package com.insigma.mvc.dao.sercatalogue.SER_MGMT_001_001;

import com.insigma.mvc.model.SerCatalogue;

public interface SerCatalogueMapper {
    int deleteByPrimaryKey(String cataId);

    int insert(SerCatalogue record);

    int insertSelective(SerCatalogue record);

    SerCatalogue selectByPrimaryKey(String cataId);

    int updateByPrimaryKeySelective(SerCatalogue record);

    int updateByPrimaryKeyWithBLOBs(SerCatalogue record);

    int updateByPrimaryKey(SerCatalogue record);
}