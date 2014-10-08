/**
* config.js
* @fileOverview 微信墙管理模块配置
* @author Tim
* @version 1.0
* @date 2014-05-15
* @remark 实现微信墙管理所有用到的模块js配置
*/
require.config({
    paths: {
        list: CONFIG.URL.staticAll + "/app/wall/list",  //微信墙->列表
        set: CONFIG.URL.staticAll + "/app/wall/set",  //微信墙->基本设置
        setSuper: CONFIG.URL.staticAll + "/app/wall/super",  //微信墙->高级设置
        content: CONFIG.URL.staticAll + "/app/wall/content.js?v=1",  //微信墙->内容管理
        roster: CONFIG.URL.staticAll + "/app/wall/roster",  //微信墙->名单管理
        interact: CONFIG.URL.staticAll + "/app/wall/interact",  //微信墙->大屏设置->互动大屏幕
        lottery: CONFIG.URL.staticAll + "/app/wall/lottery",  //微信墙->大屏设置->抽奖设置
        vote: CONFIG.URL.staticAll + "/app/wall/vote",  //微信墙->大屏设置->投票设置
        photos: CONFIG.URL.staticAll + "/app/wall/photos",  //微信墙->大屏设置->图片墙设置
        statistics: CONFIG.URL.staticAll + "/app/wall/statistics",  //微信墙->统计管理
        big_screen_frame: CONFIG.URL.staticAll + "/app/wall/big_screen_frame",  //微信墙->大屏框架
        big_screen_picture: CONFIG.URL.staticAll + "/app/wall/big_screen_picture.js?v=201405301137",  //微信墙->大屏图片墙
        big_screen_lottery: CONFIG.URL.staticAll + "/app/wall/big_screen_lottery",  //微信墙->大屏抽奖
        big_screen_vote: CONFIG.URL.staticAll + "/app/wall/big_screen_vote",  //微信墙->大屏投票
        big_screen_checkin: CONFIG.URL.staticAll + "/app/wall/big_screen_checkin",  //微信墙->大屏签到
        big_screen_topic: CONFIG.URL.staticAll + "/app/wall/big_screen_topic",  //微信墙->大屏讨论
        jsonData: CONFIG.URL.staticAll + "/app/wall/jsonData",  //微信墙->大屏测试数据
        buy: CONFIG.URL.staticAll + "/app/wall/buy"
    }
});

