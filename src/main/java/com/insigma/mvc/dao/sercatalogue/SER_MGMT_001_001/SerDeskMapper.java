package com.insigma.mvc.dao.sercatalogue.SER_MGMT_001_001;

import com.insigma.mvc.model.SerDesk;

public interface SerDeskMapper {
    int insert(SerDesk record);

    int insertSelective(SerDesk record);
}