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
  is '�ӿڹ���֮����������Ϣ��';
comment on column S_API_CHANNEL.channel_id
  is '����������Ϣ����,���ɹ���uuid';
comment on column S_API_CHANNEL.channel_code
  is '��������������QD+����';
comment on column S_API_CHANNEL.channel_name
  is '��������';
comment on column S_API_CHANNEL.channel_type
  is '��������';
comment on column S_API_CHANNEL.channel_describe
  is '��������';
comment on column S_API_CHANNEL.channel_icon
  is '����Сͼ��';
comment on column S_API_CHANNEL.valid
  is '�Ƿ���Ч';
comment on column S_API_CHANNEL.userid
  is '�����˱���';
comment on column S_API_CHANNEL.addtime
  is '����ʱ��';
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
  is '�ӿڹ���֮������ӿڹ�����';
comment on column S_API_CHANNEL_INTERFACE.channel_interface_id
  is '��������(uuid)';
comment on column S_API_CHANNEL_INTERFACE.channel_id
  is '�������';
comment on column S_API_CHANNEL_INTERFACE.interface_id
  is '�ӿڱ��';
comment on column S_API_CHANNEL_INTERFACE.appkey
  is '����key';
comment on column S_API_CHANNEL_INTERFACE.disabled
  is '�Ƿ����';
comment on column S_API_CHANNEL_INTERFACE.valid
  is '�Ƿ���Ч';
comment on column S_API_CHANNEL_INTERFACE.userid
  is '�����˱���';
comment on column S_API_CHANNEL_INTERFACE.addtime
  is '����ʱ��';

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
  is '�ӿڹ���-�ӿڻ�����Ϣ��';
comment on column S_API_INTERFACE.interface_id
  is '�ӿڻ�����Ϣ���(uuid)';
comment on column S_API_INTERFACE.interface_code
  is '�ӿڻ�����Ϣ�������ɹ���JK+����';
comment on column S_API_INTERFACE.interface_url
  is '�ӿڵ�ַ';
comment on column S_API_INTERFACE.interface_type
  is '�ӿ�����';
comment on column S_API_INTERFACE.interface_name
  is '�ӿ�����';
comment on column S_API_INTERFACE.isoffical
  is '�Ƿ���ʽ�ӿڷ���';
comment on column S_API_INTERFACE.interfacet_nework
  is '�ӿ�֧����������';
comment on column S_API_INTERFACE.interfacep_rotocol
  is '�ӿ�֧��Э��';
comment on column S_API_INTERFACE.valid
  is '�Ƿ���Ч';
comment on column S_API_INTERFACE.userid
  is '�����˱���';
comment on column S_API_INTERFACE.addtime
  is '����ʱ��';

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
  is '�ӿڹ���֮�ӿ���ӿ���ϸ������ϵ��';
comment on column S_API_INTERFACE_ASSOCIATE.interface_associate_id
  is '�ӿ���ӿ���ϸ�������(uuid)';
comment on column S_API_INTERFACE_ASSOCIATE.interface_id
  is '�ӿڻ�����Ϣ���';
comment on column S_API_INTERFACE_ASSOCIATE.interface_detail_id
  is '�ӿ���ϸ����(uuid)';

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
  is '�ӿڹ���֮�ӿ���ϸ������Ϣ';
comment on column S_API_INTERFACE_DETAIL.interface_detail_id
  is '�ӿ���ϸ����(uuid)';
comment on column S_API_INTERFACE_DETAIL.interface_detail_code
  is '�ӿ���ϸ����(���ɹ����Զ���)';
comment on column S_API_INTERFACE_DETAIL.interface_detail_name
  is '�ӿ���ϸ����';
comment on column S_API_INTERFACE_DETAIL.interface_detail_type
  is '�ӿ���ϸ���ͣ�����ҵ�񡢵�λҵ���籣ҵ�񡢾�ҵҵ�񡢹���ҵ��';
comment on column S_API_INTERFACE_DETAIL.interface_detail_url
  is '�ӿ���ϸ�����ַ(��Ե�ַ)';
comment on column S_API_INTERFACE_DETAIL.interface_detail_describe
  is '�ӿ���ϸ����';
comment on column S_API_INTERFACE_DETAIL.reqeust_contenttype
  is '��θ�ʽ';
comment on column S_API_INTERFACE_DETAIL.response_contenttype
  is '���θ�ʽ';
comment on column S_API_INTERFACE_DETAIL.valid
  is '�Ƿ���Ч';
comment on column S_API_INTERFACE_DETAIL.userid
  is '�����˱���';
comment on column S_API_INTERFACE_DETAIL.addtime
  is '����ʱ��';


spool off
