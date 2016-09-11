var express = require('express');
var router = express.Router();
var userModel = require('../model/userModel');
var log = require('../utility/log.js');
var returnValue = require('../config/returnValue.js')



var hotNewslist = [
    {
        title: '外汇市场自律机制的基本情况,外汇市场自律机制的基本情况,外汇市场自律机制的基本情况',
        titleImageUrl: 'CMS5_G20306002Resource',
        //headline: true,
        subTitle: '热点关注',
        source: '外汇交易中心',
        publishTime: '2016-08-01'
    },
    // {
    //     title : "2016年7月份CFETS人民币汇率指数",
    //     headline: true,
    //     titleImageUrl: 'README.png',
    //     subTitle : "热点关注",
    //     source : "外汇交易中心",
    //     publishTime : "2016-08-01"
    // },
    // {
    //     title : "银行间市场技术标准工作组年会暨ISO 20022培训成功举行",
    //     titleImageUrl: '44D8AF4C-98F2-4742-9AE3-A55A5A74DA2F.png',
    //     headline: true,
    //     subTitle : "热点关注",
    //     source : "外汇交易中心",
    //     publishTime : "2016-07-26"
    // },
    // {
    //     title : "外汇掉期冲销业务正式启动 交易后处理基础设施不断完善",
    //     titleImageUrl: '26A9B79E-D324-45D9-818D-D44393B67C78.png',
    //     headline: true,
    //     subTitle : "热点关注",
    //     source : "外汇交易中心",
    //     publishTime : "2016-07-24"
    // },
    {
        title : "6月份人民币汇率指数小幅贬值",
        titleImageUrl: 'C350361C-41F7-4707-AEF8-419F2556B6E5.png',
        subTitle : "热点关注",
        source : "外汇交易中心",
        publishTime : "2016-07-10"
    },
    {
        title : "中国货币网移动版升级上线",
        titleImageUrl: '99E949AD-B0BB-4232-8B93-18C1650298E5.png',
        subTitle : "热点关注",
        source : "外汇交易中心",
        publishTime : "2016-07-01"
    },
    // {
    //     title : "外汇市场自律机制第二次工作会议在京召开",
    //     subTitle : "热点关注",
    //     source : "外汇交易中心",
    //     publishTime : "2016-06-01"
    // },
    // {
    //
    //     title : "中国人民银行欢迎中国外汇交易中心开展人民币对韩元直接交易",
    //     subTitle : "热点关注",
    //     source : "外汇交易中心",
    //     publishTime : "2016-05-25"
    // }
];


var announcementList = [
    {
        title: '关于同意更改会员名称的通知(建行伦敦)',
        subTitle: '公告与提示',
        source: '外汇交易中心',
        publishTime: '2016-08-01'
    },
    {
        title : "关于批准中国银行股份有限公司澳门分行成为银行间外汇市场货币掉期及期权会员的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-08-01"
    },
    {
        title : "关于批准中山农村商业银行股份有限公司成为银行间外汇市场会员的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-07-26"
    },
    {
        title : "关于批准天津金城银行股份有限公司成为外币拆借会员的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-07-24"
    },
    {
        title : "关于批准临安市农村信用合作联社成为外币拆借会员的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-07-10"
    },
    {
        title : "关于批准韩国产业银行青岛分行成为外币拆借会员的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-07-01"
    },
    {
        title : "关于批准江苏建湖农村商业银行股份有限公司成为银行间外汇市场会员的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-06-01"
    },
    {

        title : "关于印发《境外金融机构开展人民币购售业务交纳外汇风险准备金业务指南》的通知",
        subTitle : "公告与提示",
        source : "外汇交易中心",
        publishTime : "2016-05-25"
    }
];



var depositlist = [
    {
        title: '关于进一步扩大同业存单及大额存单发行主体范围的通知',
        subTitle: '同业存单',
        source: '外汇交易中心',
        publishTime: '2016-08-01'
    },
    {
        title : "关于扩大大额存单发行主体范围的通知",
        subTitle : "同业存单",
        source : "外汇交易中心",
        publishTime : "2016-07-26"
    },
    {
        title : "市场利率定价自律机制核心成员将于6月15日起发行首批大额存单",
        subTitle : "同业存单",
        source : "外汇交易中心",
        publishTime : "2016-07-24"
    },
    {
        title : "关于发布《大额存单管理实施细则》的公告",
        subTitle : "同业存单",
        source : "外汇交易中心",
        publishTime : "2016-07-10"
    },
    {
        title : "中国人民银行公告[2015]第13号",
        subTitle : "同业存单",
        source : "外汇交易中心",
        publishTime : "2016-07-01"
    },
    {
        title : "关于批准江苏建湖农村商业银行股份有限公司成为银行间外汇市场会员的通知",
        subTitle : "同业存单",
        source : "外汇交易中心",
        publishTime : "2016-06-01"
    },
    {

        title : "关于印发《境外金融机构开展人民币购售业务交纳外汇风险准备金业务指南》的通知",
        subTitle : "同业存单",
        source : "外汇交易中心",
        publishTime : "2016-05-25"
    }
];




var publishlist = [
    {
        title: '新增创金合信昭尊1号资产管理计划等承诺使用全国银行间同业拆借中心利率互换交易确认功能',
        subTitle: '发行市场',
        source: '外汇交易中心',
        publishTime: '2016-08-01'
    },
    {
        title : "关于证券公司、财务公司、信托公司等同业拆借市场成员披露2016年半年度财务报表情况的公告",
        subTitle : "发行市场",
        source : "外汇交易中心",
        publishTime : "2016-07-26"
    },
    {
        title : "2016年6月银行间债券市场做市业务情况",
        subTitle : "发行市场",
        source : "外汇交易中心",
        publishTime : "2016-07-24"
    },
    {
        title : "关于长沙银行进入利率互换市场的公告",
        subTitle : "发行市场",
        source : "外汇交易中心",
        publishTime : "2016-07-10"
    },
    {
        title : "关于新开发银行、澳大利亚西太平洋银行上海分行进入利率互换市场的公告",
        subTitle : "发行市场",
        source : "外汇交易中心",
        publishTime : "2016-07-01"
    },
    {
        title : "关于批准桂林银行股份有限公司成为外币拆借会员的通知",
        subTitle : "发行市场",
        source : "外汇交易中心",
        publishTime : "2016-06-01"
    },
    {

        title : "关于本币交易系统升级到2.6.0.9版本相关事宜的通知",
        subTitle : "发行市场",
        source : "外汇交易中心",
        publishTime : "2016-05-25"
    }
];


router.get('/publishlist', function(req, res){
    res.send({
        code: 0,
        data: publishlist
    });
})

router.get('/depositlist', function(req, res){
    res.send({
        code: 0,
        data: depositlist
    });
})

router.get('/announcementList', function(req, res){
    res.send({
        code: 0,
        data: announcementList
    });
});

router.get('/hotNewslist', function(req, res){
    res.send({
        code: 0,
        data: hotNewslist
    });
});


var benchmark = {
    "sectionTitles": ["人民币汇率中间价", "Shibor", "回购定盘利率", "人民币汇率指数"],
    "marketModels": [
        [
            {
                prdcImageUrl: "USD.jpg",
                prdcTitle: "美元/人民币",
                price: 6.6615,
                bp: 209.00
            },
            {
                prdcImageUrl: "EUR.jpg",
                prdcTitle: "欧元/人民币",
                price: 7.3816,
                bp: -105.00
            },
            {
                prdcImageUrl: "JPY.jpg",
                prdcTitle: "100日元/人民币",
                price: 6.5217,
                bp: -383.00
            },
            {
                prdcImageUrl: "hkd.jpg",
                prdcTitle: "港元/人民币",
                price: 0.85897,
                bp: 27.90
            },
            {
                prdcImageUrl: "GBP.jpg",
                prdcTitle: "英镑/人民币",
                price: 8.7116,
                bp: 31.00
            },
            {
                prdcImageUrl: "AUD.jpg",
                prdcTitle: "澳元/人民币",
                price: 5.0637,
                bp: 29.00
            }
        ],
        [



            {
                prdcTitle: "O/N",
                price: 2.0050,
                bp: 0.30
            },
            {
                prdcTitle: "1W",
                price: 2.3160,
                bp: -0.10
            },
            {
                prdcTitle: "2W",
                price: 2.6390,
                bp: 1.00
            },
            {
                prdcTitle: "1M",
                price: 2.7210,
                bp: 0.80
            },
            {
                prdcTitle: "3M",
                price: 2.8150,
                bp: 0.35
            },
            {
                prdcTitle: "6M",
                price: 2.9070,
                bp: 0.35
            },
            {
                prdcTitle: "9M",
                price: 2.9400,
                bp: 0.45
            },
            {
                prdcTitle: "1Y",
                price: 3.0260,
                bp: 0.20
            }
        ],
        [
            {
                prdcTitle: "FR001",
                price: 2.0000,
                bp: 0.00
            },
            {
                prdcTitle: "FR007",
                price: 2.4000,
                bp: 0.00
            },
            {
                prdcTitle: "FR014",
                price: 2.6000,
                bp: 2.00
            }
        ],
        [
            {
                prdcTitle: "人民币汇率指数",
                price: 94.72,
                bp: -0.62
            },
            {
                prdcTitle: "BIS人民币汇率指数",
                price: 95.37,
                bp: -0.73
            },
            {
                prdcTitle: "SDR人民币汇率指数",
                price: 95.72,
                bp: 0.27
            }
        ]
    ]
}

router.get('/getBenchmark', function(req, res){
    res.send({
        code: 0,
        data: benchmark
    });
});


var foreign = {
    "sectionTitles": ["人民币外汇即期报价                           买/卖报价"],
    "marketModels": [
        [
            {
                prdcTitle: "USD/CNY",
                compareTitle: "6.6609/6.6621"
            },
            {
                prdcTitle: "EUR/CNY",
                compareTitle: "7.3824/7.3842"
            },
            {
                prdcTitle: "100JPY/CNY",
                compareTitle: "6.5052/6.5073"
            },
            {
                prdcTitle: "HKD/CNY",
                compareTitle: "0.85869/0.85891"
            },
            {
                prdcTitle: "GBP/CNY",
                compareTitle: "8.7004/8.7034"
            },
            {
                prdcTitle: "AUD/CNY",
                compareTitle: "5.0858/5.0872"
            },
            {
                prdcTitle: "NZD/CNY",
                compareTitle: "4.7466/4.7481"
            },
            {
                prdcTitle: "SGD/CNY",
                compareTitle: "4.9429/4.9447"
            },
            {
                prdcTitle: "CHF/CNY",
                compareTitle: "6.7848/6.7876"
            },
            {
                prdcTitle: "CAD/CNY",
                compareTitle: "5.0616/5.0636"
            }
        ]
    ]
}

router.get('/getForeign', function(req, res){
    res.send({
        code: 0,
        data: foreign
    });
});



var rmb = {
    "sectionTitles": ["同业拆借行情", "质押式回购行情", "现券市场行情"],
    "marketModels": [
        [
            {
                prdcTitle: "IBO001",
                price: 2.5000,
                bp: 45.00
            },
            {
                prdcTitle: "IBO007",
                price: 2.4200,
                bp: 12.00
            },
            {
                prdcTitle: "IBO014",
                price: 2.6000,
                bp: -7.00
            },
            {
                prdcTitle: "IBO021",
                price: 2.5000,
                bp: 0.00
            }
        ],
        [
            {
                prdcTitle: "R001",
                price: 2.0500,
                bp: -5.00
            },
            {
                prdcTitle: "R007",
                price: 2.3500,
                bp: 3.00
            },
            {
                prdcTitle: "R014",
                price: 2.6000,
                bp: -5.00
            },
            {
                prdcTitle: "R021",
                price: 2.6500,
                bp: 0.00
            }
        ],
        [
            {
                prdcTitle: "16农发14",
                price: 100.23,
                bp: 2.2504
            },
            {
                prdcTitle: "16国开10",
                price: 100.19,
                bp: 3.1550
            },
            {
                prdcTitle: "16附息国债17",
                price: 99.92,
                bp:  2.7490
            },
            {
                prdcTitle: "16国开06",
                price: 100.25,
                bp: 2.8975
            },
            {
                prdcTitle: "15国开18",
                price: 104.28,
                bp:  3.1900
            },
            {
                prdcTitle: "16附息国债18",
                price: 99.96,
                bp:  2.1800
            }
        ]
    ]
}

router.get('/getRMB', function(req, res){
    res.send({
        code: 0,
        data: rmb
    });
});


router.get('/userSearch', function(req, res){
    userModel.getUserDtlsByDesc(req.query.searchDesc, req.query.page, function(err, data){
        var returnData = {};
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            returnData.code = 0;
            returnData.data = data;
        }
        res.send(returnData);
    })
});




router.get('/getUserContact', function(req, res){
    userModel.getUserContact(req.query.userSrno, function(err, data){
        var returnData = {};
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            returnData.code = 0;
            returnData.data = data;
        }
        res.send(returnData);
    })
})

router.post('/addUserToContact', function(req, res){
    console.log(req.body)
    userModel.addUserToContact(req.body.userSrno, req.body.contactUserSrno, function(err, data){
        var returnData = {};
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            returnData.code = 0;
            returnData.data = data;
        }
        res.send(returnData);
    })
})

router.post('/login', function(req, res){
    console.log(req.body)
    userModel.checkUserPassword(req.body.userID, req.body.userPassword, function(err, data){
        var returnData = {};
        if (err) {
            log.error(err, log.getFileNameAndLineNum(__filename));
            returnData.code = -1;
            returnData.msg = err;
        }else{
            console.log(data.length)
            if(data.length === 0){
                //验证不成功
                returnData.code = returnValue.returnCode.LOGIN_FAIL
            }else{
                returnData.code = returnValue.returnCode.LOGIN_SUCCESS
            }
            returnData.data = data;
        }
        console.log(returnData)
        res.send(returnData);
    })
})


var liveList = [
    {
        liveTitle: '外汇市场的操作心得外汇市场的操作心得',
        name: '王小野',
        faceImageName: 'tempFace.jpg',
        startTimeStamp: 1472997127+3600*24*3
    },
    {
        liveTitle: '我在本币市场这些年',
        name: '小董',
        faceImageName: 'tempFace3.jpg',
        startTimeStamp: 1472997127+3600*24*3
    },
    {
        liveTitle: '债券买卖中的技巧',
        name: '交易中心小助手',
        faceImageName: 'tempFace2.jpg',
        startTimeStamp: 1472997127+3600*24*3
    }
]

var  followList = [
    {
        faceImageName: 'tempFace.jpg',
        name: '王小野',
        entyDesc: '工商银行',
        headTitle: '首席外汇交易员',
        publishTimeStamp: 1472997127,
        content: '外汇交易就是一国货币与另一国货币进行交换。与其他金融市场不同，外汇市场没有具体地点，也没有中央交易所，而是通过银行、企业和个人间的电子网络进行交易。 "外汇交易"是同时买入一对货币组合中的一种货币而卖出另外一种货币',
        contentImageUrl: 'imagTemp.jpg',
        commentCount: 1234,
        likeCount: 123
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行',
        headTitle: '首席外汇交易员',
        publishTimeStamp: 1472997127,
        content: '外汇交易就是一国货币与另一国货币进行交换。与其他金融市场不同，外汇市场没有具体地点，也没有中央交易所，而是通过银行、企业和个人间的电子网络进行交易。 "外汇交易"是同时买入一对货币组合中的一种货币而卖出另外一种货币',
        contentImageUrl: 'imageTemp2.jpg',
        commentCount: 666,
        likeCount: 123
    },
    {
        faceImageName: 'tempFace3.jpg',
        name: '交易中心',
        entyDesc: '工商银行',
        headTitle: '首席外汇交易员',
        publishTimeStamp: 1472997127,
        content: '外汇交易就是一国货币与另一国货币进行交换。与其他金融市场不同，外汇市场没有具体地点，也没有中央交易所，而是通过银行、企业和个人间的电子网络进行交易。 "外汇交易"是同时买入一对货币组合中的一种货币而卖出另外一种货币',
        contentImageUrl: 'imageTemp3.jpg',
        commentCount: 66,
        likeCount: 888
    },
    {
        faceImageName: 'tempFace3.jpg',
        name: '交易中心',
        entyDesc: '工商银行',
        headTitle: '首席外汇交易员',
        publishTimeStamp: 1472997127,
        content: '外汇交易就是一国货币与另一国货币进行交换。与其他金融市场不同，外汇市场没有具体地点，也没有中央交易所，而是通过银行、企业和个人间的电子网络进行交易。 "外汇交易"是同时买入一对货币组合中的一种货币而卖出另外一种货币',
        contentImageUrl: 'imageTemp3.jpg',
        commentCount: 66,
        likeCount: 888
    },
    {
        faceImageName: 'tempFace3.jpg',
        name: '交易中心',
        entyDesc: '工商银行',
        headTitle: '首席外汇交易员',
        publishTimeStamp: 1472997127,
        content: '外汇交易就是一国货币与另一国货币进行交换。与其他金融市场不同，外汇市场没有具体地点，也没有中央交易所，而是通过银行、企业和个人间的电子网络进行交易。 "外汇交易"是同时买入一对货币组合中的一种货币而卖出另外一种货币',
        contentImageUrl: 'imageTemp3.jpg',
        commentCount: 66,
        likeCount: 888
    },
    {
        faceImageName: 'tempFace3.jpg',
        name: '交易中心',
        entyDesc: '工商银行',
        headTitle: '首席外汇交易员',
        publishTimeStamp: 1472997127,
        content: '外汇交易就是一国货币与另一国货币进行交换。与其他金融市场不同，外汇市场没有具体地点，也没有中央交易所，而是通过银行、企业和个人间的电子网络进行交易。 "外汇交易"是同时买入一对货币组合中的一种货币而卖出另外一种货币',
        contentImageUrl: 'imageTemp3.jpg',
        commentCount: 66,
        likeCount: 888
    }
]


router.get('/getNewsFeed', function(req, res){
    res.send({
        code: returnValue.returnCode.SUCCESS,
        data: {
            'hotNewslist': hotNewslist,
            'liveList': liveList,
            'followList': followList
        }
    });
})


var recommandPersonList = [
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
    {
        faceImageName: 'tempFace2.jpg',
        name: '小董',
        entyDesc: '工商银行'
    },
]

router.get('/getRecommandPersonList', function(req, res){
    res.send({
        code: returnValue.returnCode.SUCCESS,
        data: {
            'recommandPersonList': recommandPersonList
        }
    });
})



//导出router对象
module.exports = router;
