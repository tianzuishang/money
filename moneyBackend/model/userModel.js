var conn = require('./utility');

exports.getUserCount = function(callback){
	var sql = 'select count(*) as count from user_base_info';
	conn.executeSql(sql, [], callback);
}


exports.getUserCache = function(req ,callback){
    conn.redisHget(req.hash, req.key, callback);
}


exports.getUserDtlsByDesc = function(searchDesc, page, callback){
	if(page === undefined){
		page = 1;
	}

	var rowBegin = (page-1)*20;
	var rowEnd = page*20;

	var sql = 'select a.*, b.EMA_ENTY_DESC from trdx_user_dtls a, trdx_entity_master b ' +
			 	'where a.UDT_ENTY_SRNO = b.EMA_ENTY_SRNO and ' +
				'(a.UDT_USER_DESC like \'%'+searchDesc+'%\' or b.EMA_ENTY_DESC like \'%'+searchDesc+'%\') ' +
				' limit ?, ?';

	conn.executeSql(sql, [rowBegin, rowEnd], callback);
}

exports.addUserToContact = function(userSrno, contactUserSrno, callback) {
	var sql = 'insert trdx_user_contact(user_srno, contact_user_srno) ' +
	' values(?, ?) '

	conn.executeSql(sql, [userSrno, contactUserSrno], callback);
}


exports.getUserContact = function(userSrno, callback){
	var sql = 'select b.* from trdx_user_contact a, trdx_user_dtls b where a.user_srno = ? ' +
	' and a.contact_user_srno = b.udt_user_srno'

	conn.executeSql(sql, [userSrno], callback);

}


exports.checkUserPassword = function(userID, userPassword, callback) {
	var sql = 'select b.*, c.* from trdx_user_sesn_dtls a, trdx_user_dtls b, trdx_entity_master c ' +
	' where a.usd_user_user_id = ? and a.usd_password = ? ' +
	' and a.usd_user_srno = b.udt_user_srno and b.UDT_ENTY_SRNO = c.EMA_ENTY_SRNO'
	conn.executeSql(sql, [userID, userPassword], callback)
}
