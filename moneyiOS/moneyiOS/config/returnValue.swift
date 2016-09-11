//
//  returnValue.swift
//  moneyiOS
//
//  Created by wang jam on 8/29/16.
//  Copyright © 2016 jam wang. All rights reserved.
//

import Foundation



let ERROR = -1
let SUCCESS = 0
let LOGIN_SUCCESS = 1010
let LOGIN_FAIL = 1011

let REGISTER_SUCCESS = 1020
let REGISTER_FAIL = 1021


let errorMap = [
    SUCCESS: "",
    ERROR: "后台服务器错误",
    LOGIN_SUCCESS: "登录成功",
    LOGIN_FAIL: "用户名或密码错误",
    REGISTER_SUCCESS: "注册成功",
    REGISTER_FAIL: "注册失败"
]

