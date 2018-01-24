package com.insigma.mvc.dao.sercatalogue.SER_MGMT_001_002;

import com.insigma.mvc.model.SerDepartment;

public interface SerDepartmentMapper {
    int deleteByPrimaryKey(String departmentId);

    int insert(SerDepartment record);

    int insertSelective(SerDepartment record);

    SerDepartment selectByPrimaryKey(String departmentId);

    int updateByPrimaryKeySelective(SerDepartment record);

    int updateByPrimaryKey(SerDepartment record);
}