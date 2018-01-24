package com.insigma.mvc.serviceimp.sercatalogue.SER_MGMT_001_001;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.insigma.mvc.service.sercatalogue.SER_MGMT_001_001.SerCatalogueService;

/**
 *服务目录管理service impl
 * @author wengsh
 *
 */
@Service
@Transactional
public class SerCatalogueServiceImpl implements SerCatalogueService {

	Log log = LogFactory.getLog(SerCatalogueServiceImpl.class);


}