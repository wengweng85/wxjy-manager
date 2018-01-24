----------------------------------------------
-- Export file for user MYWEB@ORCL          --
-- Created by wengsh on 2017/11/30, 9:57:15 --
----------------------------------------------

set define off
spool api_channel.log

prompt
prompt Creating table S_API_CHANNEL
prompt ============================
prompt
create table S_API_CHANNEL
(
  channel_id       VARCHAR2(36) not null,
  channel_code     VARCHAR2(36),
  channel_name     VARCHAR2(100),
  channel_type     VARCHAR2(36),
  channel_describe VARCHAR2(100),
  channel_icon     VARCHAR2(100),
  valid            VARCHAR2(10),
  userid           VARCHAR2(100),
  addtime          DATE
)
;
comment on table S_API_CHANNEL
  is '接口管理之渠道基本信息表';
comment on column S_API_CHANNEL.channel_id
  is '渠道基本信息表编号,生成规则uuid';
comment on column S_API_CHANNEL.channel_code
  is '渠道编码编码规则QD+序列';
comment on column S_API_CHANNEL.channel_name
  is '渠道名称';
comment on column S_API_CHANNEL.channel_type
  is '渠道类型';
comment on column S_API_CHANNEL.channel_describe
  is '渠道描述';
comment on column S_API_CHANNEL.channel_icon
  is '渠道小图标';
comment on column S_API_CHANNEL.valid
  is '是否有效';
comment on column S_API_CHANNEL.userid
  is '经办人编码';
comment on column S_API_CHANNEL.addtime
  is '经办时间';
alter table S_API_CHANNEL
  add constraint PK_S_API_CHANNEL primary key (CHANNEL_ID);

prompt
prompt Creating table S_API_CHANNEL_INTERFACE
prompt ======================================
prompt
create table S_API_CHANNEL_INTERFACE
(
  channel_interface_id VARCHAR2(36),
  channel_id           VARCHAR2(36),
  interface_id         VARCHAR2(36),
  appkey               VARCHAR2(36),
  disabled             VARCHAR2(36),
  valid                VARCHAR2(10),
  userid               VARCHAR2(100),
  addtime              DATE
)
;
comment on table S_API_CHANNEL_INTERFACE
  is '接口管理之渠道与接口关联表';
comment on column S_API_CHANNEL_INTERFACE.channel_interface_id
  is '关联表编号(uuid)';
comment on column S_API_CHANNEL_INTERFACE.channel_id
  is '渠道编号';
comment on column S_API_CHANNEL_INTERFACE.interface_id
  is '接口编号';
comment on column S_API_CHANNEL_INTERFACE.appkey
  is '访问key';
comment on column S_API_CHANNEL_INTERFACE.disabled
  is '是否禁用';
comment on column S_API_CHANNEL_INTERFACE.valid
  is '是否有效';
comment on column S_API_CHANNEL_INTERFACE.userid
  is '经办人编码';
comment on column S_API_CHANNEL_INTERFACE.addtime
  is '经办时间';

prompt
prompt Creating table S_API_INTERFACE
prompt ==============================
prompt
create table S_API_INTERFACE
(
  interface_id       VARCHAR2(36),
  interface_code     VARCHAR2(100),
  interface_url      VARCHAR2(200),
  interface_type     VARCHAR2(10),
  interface_name     VARCHAR2(200),
  isoffical          VARCHAR2(10),
  interfacet_nework  VARCHAR2(10),
  interfacep_rotocol VARCHAR2(100),
  valid              VARCHAR2(10),
  userid             VARCHAR2(100),
  addtime            DATE
)
;
comment on table S_API_INTERFACE
  is '接口管理-接口基本信息表';
comment on column S_API_INTERFACE.interface_id
  is '接口基本信息编号(uuid)';
comment on column S_API_INTERFACE.interface_code
  is '接口基本信息编码生成规则JK+序列';
comment on column S_API_INTERFACE.interface_url
  is '接口地址';
comment on column S_API_INTERFACE.interface_type
  is '接口类型';
comment on column S_API_INTERFACE.interface_name
  is '接口名称';
comment on column S_API_INTERFACE.isoffical
  is '是否正式接口服务';
comment on column S_API_INTERFACE.interfacet_nework
  is '接口支持网络类型';
comment on column S_API_INTERFACE.interfacep_rotocol
  is '接口支持协议';
comment on column S_API_INTERFACE.valid
  is '是否有效';
comment on column S_API_INTERFACE.userid
  is '经办人编码';
comment on column S_API_INTERFACE.addtime
  is '经办时间';

prompt
prompt Creating table S_API_INTERFACE_ASSOCIATE
prompt ========================================
prompt
create table S_API_INTERFACE_ASSOCIATE
(
  interface_associate_id VARCHAR2(36),
  interface_id           VARCHAR2(36),
  interface_detail_id    VARCHAR2(36)
)
;
comment on table S_API_INTERFACE_ASSOCIATE
  is '接口管理之接口与接口明细关联关系表';
comment on column S_API_INTERFACE_ASSOCIATE.interface_associate_id
  is '接口与接口明细关联编号(uuid)';
comment on column S_API_INTERFACE_ASSOCIATE.interface_id
  is '接口基本信息编号';
comment on column S_API_INTERFACE_ASSOCIATE.interface_detail_id
  is '接口明细表编号(uuid)';

prompt
prompt Creating table S_API_INTERFACE_DETAIL
prompt =====================================
prompt
create table S_API_INTERFACE_DETAIL
(
  interface_detail_id       VARCHAR2(36),
  interface_detail_code     VARCHAR2(36),
  interface_detail_name     VARCHAR2(100),
  interface_detail_type     VARCHAR2(100),
  interface_detail_url      VARCHAR2(200),
  interface_detail_describe VARCHAR2(200),
  reqeust_contenttype       VARCHAR2(200),
  response_contenttype      VARCHAR2(200),
  valid                     VARCHAR2(10),
  userid                    VARCHAR2(100),
  addtime                   DATE
)
;
comment on table S_API_INTERFACE_DETAIL
  is '接口管理之接口明细基本信息';
comment on column S_API_INTERFACE_DETAIL.interface_detail_id
  is '接口明细表编号(uuid)';
comment on column S_API_INTERFACE_DETAIL.interface_detail_code
  is '接口明细编码(生成规则自定义)';
comment on column S_API_INTERFACE_DETAIL.interface_detail_name
  is '接口明细名称';
comment on column S_API_INTERFACE_DETAIL.interface_detail_type
  is '接口明细类型（个人业务、单位业务、社保业务、就业业务、公共业务）';
comment on column S_API_INTERFACE_DETAIL.interface_detail_url
  is '接口明细请求地址(相对地址)';
comment on column S_API_INTERFACE_DETAIL.interface_detail_describe
  is '接口明细描述';
comment on column S_API_INTERFACE_DETAIL.reqeust_contenttype
  is '入参格式';
comment on column S_API_INTERFACE_DETAIL.response_contenttype
  is '出参格式';
comment on column S_API_INTERFACE_DETAIL.valid
  is '是否有效';
comment on column S_API_INTERFACE_DETAIL.userid
  is '经办人编码';
comment on column S_API_INTERFACE_DETAIL.addtime
  is '经办时间';


spool off
