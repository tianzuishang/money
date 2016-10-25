ALTER TABLE `cfets_test`.`trdx_user_dtls`
ADD COLUMN `UDT_USER_SIGN` VARCHAR(255) NULL AFTER `UDT_USER_FACE`;



CREATE TABLE `trdx_user_follow_base_info` (
  `ufb_user_srno` varchar(100) NOT NULL,
  `ufb_followed_user_srno` varchar(100) NOT NULL,
  `ufb_follow_timestamp` bigint(20) NOT NULL,
  PRIMARY KEY (`ufb_user_srno`,`ufb_followed_user_srno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


ALTER TABLE `cfets_test`.`trdx_user_dtls`
ADD COLUMN `UDT_USER_FOLLOW_COUNT` INT NULL DEFAULT 0 AFTER `UDT_USER_SIGN`;

ALTER TABLE `cfets_test`.`trdx_user_dtls`
ADD COLUMN `UDT_USER_FANS_COUNT` INT NULL DEFAULT 0 AFTER `UDT_USER_FOLLOW_COUNT`;

#26
ALTER TABLE `cfets_test`.`trdx_user_dtls`
ADD COLUMN `UDT_USER_DEVICE_TOKEN` VARCHAR(100) NULL AFTER `UDT_USER_FANS_COUNT`;


#29
CREATE TABLE `trdx_private_message_info` (
  `tpm_msg_id` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '后台编码',
  `tpm_sender_user_id` varchar(100) CHARACTER SET utf8 NOT NULL,
  `tpm_receive_user_id` varchar(100) CHARACTER SET utf8 NOT NULL,
  `tpm_message_content` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tpm_send_timestamp` bigint(20) NOT NULL,
  `tpm_datetime` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `tpm_msg_type` int(11) DEFAULT NULL,
  `tpm_datapath` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL,
  `tpm_voice_time` int(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tpm_msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
