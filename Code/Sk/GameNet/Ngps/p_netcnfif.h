/* SCE CONFIDENTIAL
 "PlayStation 2" Programmer Tool Runtime Library Release 2.5
 */
/* 
 *      Netcnf Interface Library
 *
 *                         Version 1.2
 *                         Shift-JIS
 *
 *      Copyright (C) 2002 Sony Computer Entertainment Inc.
 *                        All Rights Reserved.
 *
 *                         netcnfif.h
 *
 *       Version        Date            Design      Log
 *  --------------------------------------------------------------------
 *       1.1            2002.01.28      tetsu       First version
 *       1.2            2002.02.10      tetsu       Add SCE_NETCNFIF_CHECK_ADDITIONAL_AT
 *                                                  Add sceNETCNFIF_TOO_LONG_STR
 */

#ifndef __netcnfif_common_h_
#define __netcnfif_common_h_

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* Sifrpc �p */
#define SCE_NETCNFIF_SSIZE     (4096)       /* ����M����f�[�^�o�b�t�@�̃T�C�Y */
#define SCE_NETCNFIF_INTERFACE (0x80001101) /* ���N�G�X�g���ʎq */

/* Sifrpc �T�[�r�X�֐��p�ԍ� */
#define SCE_NETCNFIF_GET_COUNT           (0)   /* �l�b�g���[�N�ݒ�t�@�C���̐����擾 */
#define SCE_NETCNFIF_GET_LIST            (1)   /* �l�b�g���[�N�ݒ�t�@�C���̃��X�g���擾 */
#define SCE_NETCNFIF_LOAD_ENTRY          (2)   /* �l�b�g���[�N�ݒ�t�@�C���̓��e���擾 */
#define SCE_NETCNFIF_ADD_ENTRY           (3)   /* �l�b�g���[�N�ݒ�t�@�C���̒ǉ� */
#define SCE_NETCNFIF_EDIT_ENTRY          (4)   /* �l�b�g���[�N�ݒ�t�@�C���̕ҏW */
#define SCE_NETCNFIF_DELETE_ENTRY        (5)   /* �l�b�g���[�N�ݒ�t�@�C���̍폜 */
#define SCE_NETCNFIF_SET_LATEST_ENTRY    (6)   /* �l�b�g���[�N�ݒ�t�@�C���̃��X�g��ҏW */
#define SCE_NETCNFIF_DELETE_ALL          (7)   /* ���Ȃ��̃l�b�g���[�N�ݒ�t�@�C�����폜 */
#define SCE_NETCNFIF_CHECK_CAPACITY      (8)   /* �f�o�C�X�̎c��e�ʂ��`�F�b�N */
#define SCE_NETCNFIF_CHECK_ADDITIONAL_AT (9)   /* �ǉ� AT �R�}���h���`�F�b�N */
#define SCE_NETCNFIF_GET_ADDR            (100) /* IOP ���̎�M�̈�(sceNetcnfifData)�̃A�h���X���擾 */
#define SCE_NETCNFIF_ALLOC_WORKAREA      (101) /* IOP ���̃��[�N�G���A���m�� */
#define SCE_NETCNFIF_FREE_WORKAREA       (102) /* IOP ���̃��[�N�G���A����� */
#define SCE_NETCNFIF_SET_ENV             (103) /* IOP ���� sceNetCnfEnv �̈�� sceNetcnfifData �̓��e��ݒ� */

/* �G���[�R�[�h(-18 �܂ł� netcnf.irx �Ɠ���) */
#define sceNETCNFIF_NG               (-1)   /* ���̑��̃G���[ */
#define sceNETCNFIF_ALLOC_ERROR      (-2)   /* �������̊m�ۂɎ��s */
#define sceNETCNFIF_OPEN_ERROR       (-3)   /* �t�@�C�����J���Ȃ� */
#define sceNETCNFIF_READ_ERROR       (-4)   /* �ǂݍ��݂Ɏ��s */
#define sceNETCNFIF_WRITE_ERROR      (-5)   /* �������݂Ɏ��s */
#define sceNETCNFIF_SEEK_ERROR       (-6)   /* �t�@�C���T�C�Y�擾�Ɏ��s */
#define sceNETCNFIF_REMOVE_ERROR     (-7)   /* �폜�Ɏ��s */
#define sceNETCNFIF_ENTRY_NOT_FOUND  (-8)   /* �ݒ肪�Ȃ� */
#define sceNETCNFIF_INVALID_FNAME    (-9)   /* �ݒ�Ǘ��t�@�C���̃p�X�����s�� */
#define sceNETCNFIF_INVALID_TYPE     (-10)  /* ���Ȃ��̃l�b�g���[�N�ݒ�t�@�C���̎�ނ��s�� */
#define sceNETCNFIF_INVALID_USR_NAME (-11)  /* �ݒ薼���s�� */
#define sceNETCNFIF_TOO_MANY_ENTRIES (-12)  /* �ݒ萔���ő吔�ɒB���Ă��� */
#define sceNETCNFIF_ID_ERROR         (-13)  /* ID ���擾�ł��Ȃ� */
#define sceNETCNFIF_SYNTAX_ERROR     (-14)  /* �ݒ���e���s�� */
#define sceNETCNFIF_MAGIC_ERROR      (-15)  /* ���� "PlayStation 2" �ŕۑ����ꂽ�ݒ� */
#define sceNETCNFIF_CAPACITY_ERROR   (-16)  /* �f�o�C�X�̎c��e�ʂ�����Ȃ� */
#define sceNETCNFIF_UNKNOWN_DEVICE   (-17)  /* ���m�̃f�o�C�X���w�肳��Ă��� */
#define sceNETCNFIF_IO_ERROR         (-18)  /* IO �G���[ */
#define sceNETCNFIF_TOO_LONG_STR     (-19)  /* �w�肳�ꂽ�����񂪒������� */
#define sceNETCNFIF_NO_DATA          (-100) /* �f�[�^���ݒ肳��ĂȂ� */

/* Netcnf Interface �ɕK�v�ȃf�[�^ */
typedef struct sceNetcnfifArg{
    int data;               /* ���̑��̈���/���̑��̕Ԃ�l */
    int f_no_decode;        /* no_decode �t���O */
    int type;               /* ���Ȃ��̃l�b�g���[�N�ݒ�t�@�C���̎�� */
    int addr;               /* EE ���̎�M�̈�̃A�h���X/IOP ���A�h���X�̕Ԃ�l */
    char fname[256];        /* �ݒ�Ǘ��t�@�C���̃p�X��/�ǉ� AT �R�}���h */
    char usr_name[256];     /* �ݒ薼 */
    char new_usr_name[256]; /* �V�����ݒ薼 */
} sceNetcnfifArg_t;

enum
{
    sceNetcnfifArg_f_no_decode_off, /* f_no_decode ��ݒ肵�Ȃ� */
    sceNetcnfifArg_f_no_decode_on   /* f_no_decode ��ݒ肷�� */
};

enum
{
    sceNetcnfifArg_type_net, /* �g�ݍ��킹 */
    sceNetcnfifArg_type_ifc, /* �ڑ��v���o�C�_�ݒ� */
    sceNetcnfifArg_type_dev  /* �ڑ��@��ݒ� */
};

/* ���Ȃ��̃l�b�g���[�N�ݒ�t�@�C���̃��X�g */
typedef struct sceNetcnfifList{
    int type;           /* ���Ȃ��̃l�b�g���[�N�ݒ�t�@�C���̎�� */
    int stat;           /* �t�@�C���X�e�[�^�X */
    char sys_name[256]; /* �t�@�C���� */
    char usr_name[256]; /* �ݒ薼 */
    int p0[14];         /* �\��̈�0 */
} sceNetcnfifList_t __attribute__((aligned(64)));

/* ���Ȃ��̃l�b�g���[�N�ݒ�t�@�C���ɕۑ������f�[�^ */
typedef struct sceNetcnfifData{
    char attach_ifc[256];      /* �ڑ��v���o�C�_�ݒ�t�@�C����(net) */
    char attach_dev[256];      /* �ڑ��@��ݒ�t�@�C����(net) */
    char dhcp_host_name[256];  /* DHCP�p�z�X�g��(ifc) */
    char address[256];         /* IP�A�h���X(ifc) */
    char netmask[256];         /* �l�b�g�}�X�N(ifc) */
    char gateway[256];         /* �f�t�H���g���[�^(ifc) */
    char dns1_address[256];    /* �v���C�}��DNS(ifc) */
    char dns2_address[256];    /* �Z�J���_��DNS(ifc) */
    char phone_numbers1[256];  /* �ڑ���d�b�ԍ�1(ifc) */
    char phone_numbers2[256];  /* �ڑ���d�b�ԍ�2(ifc) */
    char phone_numbers3[256];  /* �ڑ���d�b�ԍ�3(ifc) */
    char auth_name[256];       /* ���[�UID(ifc) */
    char auth_key[256];        /* �p�X���[�h(ifc) */
    char peer_name[256];       /* �ڑ���̔F�ؖ�(ifc) */
    char vendor[256];          /* �x���_��(dev) */
    char product[256];         /* �v���_�N�g��(dev) */
    char chat_additional[256]; /* �ǉ�AT�R�}���h(dev) */
    char outside_number[256];  /* �O�����M�ԍ��ݒ�(�ԍ��ݒ蕔��)(dev) */
    char outside_delay[256];   /* �O�����M�ԍ��ݒ�(�x���ݒ蕔��)(dev) */
    int ifc_type;              /* �f�o�C�X���C���̎��(ifc) */
    int mtu;                   /* MTU�̐ݒ�(ifc) */
    int ifc_idle_timeout;      /* ����ؒf�ݒ�(ifc) */
    int dev_type;              /* �f�o�C�X���C���̎��(dev) */
    int phy_config;            /* �C�[�T�l�b�g�ڑ��@��̓��샂�[�h(dev) */
    int dialing_type;          /* �_�C�A�����@(dev) */
    int dev_idle_timeout;      /* ����ؒf�ݒ�(dev) */
    int p0;                    /* �\��̈�0 */
    unsigned char dhcp;        /* DHCP�g�p�E�s�g�p(ifc) */
    unsigned char dns1_nego;   /* DNS�T�[�o�A�h���X�������擾����E���Ȃ�(ifc) */
    unsigned char dns2_nego;   /* DNS�T�[�o�A�h���X�������擾����E���Ȃ�(ifc) */
    unsigned char f_auth;      /* �F�ؕ��@�̎w��L��(ifc) */
    unsigned char auth;        /* �F�ؕ��@(ifc) */
    unsigned char pppoe;       /* PPPoE�g�p�E�s�g�p(ifc) */
    unsigned char prc_nego;    /* PFC�l�S�V�G�[�V�����̋֎~(ifc) */
    unsigned char acc_nego;    /* ACFC�l�S�V�G�[�V�����̋֎~(ifc) */
    unsigned char accm_nego;   /* ACCM�l�S�V�G�[�V�����̋֎~(ifc) */
    unsigned char p1;          /* �\��̈�1 */
    unsigned char p2;          /* �\��̈�2 */
    unsigned char p3;          /* �\��̈�3 */
    int p4[5];                 /* �\��̈�4 */
} sceNetcnfifData_t __attribute__((aligned(64)));

enum
{
    sceNetcnfifData_type_no_set = -1, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_type_eth = 1,     /* type eth */
    sceNetcnfifData_type_ppp,         /* type ppp */
    sceNetcnfifData_type_nic          /* type nic */
};

enum
{
    sceNetcnfifData_mtu_no_set = -1,   /* �ݒ肵�Ȃ� */
    sceNetcnfifData_mtu_default = 1454 /* mtu 1454 */
};

enum
{
    sceNetcnfifData_idle_timeout_no_set = -1 /* �ݒ肵�Ȃ� */
};

enum
{
    sceNetcnfifData_phy_config_no_set = -1, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_phy_config_auto = 1,    /* phy_config auto */
    sceNetcnfifData_phy_config_10,          /* phy_config 10 */
    sceNetcnfifData_phy_config_10_FD,       /* phy_config 10_fd */
    sceNetcnfifData_phy_config_TX = 5,      /* phy_config tx */
    sceNetcnfifData_phy_config_TX_FD        /* phy_config tx_fd */
};

enum
{
    sceNetcnfifData_dialing_type_no_set = -1, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_dialing_type_tone = 0,    /* dialing_type tone */
    sceNetcnfifData_dialing_type_pulse        /* dialing_type pulse */
};

enum
{
    sceNetcnfifData_dhcp_no_set = 0xff, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_dhcp_no_use = 0,    /* -dhcp */
    sceNetcnfifData_dhcp_use            /* dhcp */
};

enum
{
    sceNetcnfifData_dns_nego_no_set = 0xff, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_dns_nego_on = 1         /* want.dns1_nego/want.dns2_nego */
};

enum
{
    sceNetcnfifData_f_auth_off, /* allow.auth chap/pap ��ݒ肵�Ȃ� */
    sceNetcnfifData_f_auth_on   /* allow.auth chap/pap ��ݒ肷�� */
};

enum
{
    sceNetcnfifData_auth_chap_pap = 4 /* allow.auth chap/pap */
};

enum
{
    sceNetcnfifData_pppoe_no_set = 0xff, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_pppoe_use = 1        /* pppoe */
};

enum
{
    sceNetcnfifData_prc_nego_no_set = 0xff, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_prc_nego_off = 0        /* -want.prc_nego */
};

enum
{
    sceNetcnfifData_acc_nego_no_set = 0xff, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_acc_nego_off = 0        /* -want.acc_nego */
};

enum
{
    sceNetcnfifData_accm_nego_no_set = 0xff, /* �ݒ肵�Ȃ� */
    sceNetcnfifData_accm_nego_off = 0        /* -want.accm_nego */
};

#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /*__netcnfif_common_h_ */
