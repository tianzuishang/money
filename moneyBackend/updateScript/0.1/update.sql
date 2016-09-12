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
