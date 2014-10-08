/**
* big_screen_frame.js
* @fileOverview 微信墙->大屏框架
* @author Tim
* @version 1.0
* @date 2014-05-15
* @remark 实现微信墙的大屏框架
*/

define(['bootstrap', 'utils', 'swiper', 'touch','polling', 'swiperHashnav'], function (bootstrap, utils, swiper, touch, polling, swiperHashnav) {
    var global = window.$CONFIG || {};
    var bigScreenFrame = {
        // 初始化
        init: function (options) {
            var that = this;
            that.opt = $.extend(true, {}, options || {});


            window.tap = "click";
            if (document.hasOwnProperty && document.hasOwnProperty("ontouchend")) {
                window.tap = "tap";
            }

            that.initSwiper();

            that.bindEvent();

            //定时拉取QR信息
            that.myQrTimer = setInterval(function () {
                that.getQRCode();
            }, that.qrCodeSpeed);

            that.scroll();
        },
        initSwiper: function () {
            var that = this;
            window.myFrameSwiper = new Swiper('.swiper-container', {
                pagination: '.pagination',
                paginationClickable: true,
                touchRatio: 0.6,
                speed: 500,
                hashNav: true,
                onFirstInit: function (swiper) {
                    //当面板第一次初始化完成后执行的函数
                    var activeIndex = swiper.activeIndex;
                    //设置当前的page
                    global['act'] = that.menuData[activeIndex].pageName;
                },
                onSlideChangeStart: function (swiper) {
                    
                    //当面板切换过来开始时的回调函数
                    var activeIndex = swiper.activeIndex;
                    //设置当前的page
                    global['act'] = that.menuData[activeIndex].pageName;

                    //if (window.$CONFIG['act'] != "vote") {
                    //    window.$CONFIG['voteid'] = null;
                    //}

                    that.getTmp(activeIndex);


                    if (that.vote && that.vote.againInit) { that.vote.againInit(); }
                    if (that.share && that.share.againInit) { that.share.againInit(); }

                    //菜单切换
                    $("#menuBox .btn-toolbar .btn-group").eq(activeIndex).addClass("btn-group-active").siblings().removeClass("btn-group-active");
                },
                onSlideChangeEnd: function (swiper) {
                    //当面板切换过来结束时的回调函数

                },
                onSlidePrev: function (swiper) {
                    //当切换到上一个面板时的回调函数
                },
                onSlideNext: function (swiper) {
                    //当切换到下一个面板时的回调函数
                },
                onTouchStart: function (swiper) {
                    //当触控开始时触发的函数
                },
                onTouchEnd: function (swiper) {
                    //当触控结束时触发的函数
                }
            });

            that.getTmp(0);

        },
        bindEvent: function () {
            var that = this;
            //底部菜单
            $("#menuBox").on(window.tap, ".btn-group", function () {
                var menuType = $(this).data("menu");
                var menuIndex = $(this).index();
                $(this).addClass("btn-group-active").siblings().removeClass("btn-group-active");

                if (menuType == "full") {

                    if ($(this).attr("title") == "全屏显示") {
                        $(this).attr("title", "退出全屏");
                        that.gotoFullscreen();

                    } else {
                        $(this).attr("title", "全屏显示");
                        that.exitFullscreen();
                    }

                    if (/.net/.test(navigator.userAgent.toLowerCase()) || /msie/.test(navigator.userAgent.toLowerCase())) {
                        require(['dialogTools'], function (dialogTools) {
                            $.dialog.tips({
                                status: "info",
                                content: '友情提示：为了更好的体验，请按“F11”进入或退出全屏显示'
                            });
                        });
                    } else {
                        that.gotoFullscreen();
                    }
                } else {
                    window.myFrameSwiper.swipeTo(menuIndex);
                }
            });

            //二维码放大
            $("body").on(window.tap, ".img-qrcode", function () {
                var qrBox = $(this).parent();

                var qrData = {
                    url:CONFIG.URL.file + $(this).data("qrurl"),
                    code: $(this).data("qrcode"),
                    count: '0'
                };

                if (that.qrIsShow) {
                    that.qrIsShow = 0;
                    $(".qr-code-box").fadeOut();
                } else {
                    that.qrIsShow = 1;
                    $(".qr-code-box").fadeIn();
                    
                    //拉取加入人数
                    that.getJoinNum();
                }

            });

            //关闭二维码弹框
            $("body").on(window.tap, ".qr-code-box .close", function () {
                that.qrIsShow = 0;
                $(".qr-code-box").fadeOut();
            });

            //菜单效果
            $("#menuBox").on("mouseover", function () {
                $(this).find(".menu-btn-arrow").show();
            }).on("mouseout", function () {
                //$(this).find(".menu-btn-arrow").hide();
            });
            
            //菜单显示隐藏
            $(".menu-btn-arrow").on(window.tap, function (e) {

                if ($(this).data("type") == "show") {
                    $(this).data("type", "hide");
                    $(this).attr("title", "收起菜单");

                    $("#menuBox").animate({ "bottom": "0px" });
                    $(this).removeClass("menu-arrow-up").addClass("menu-arrow-bottom");

                    //重新绑定
                    $("#menuBox").on("mouseover", function () {
                        $(this).find(".menu-btn-arrow").show();
                    }).on("mouseout", function () {
                        //$(this).find(".menu-btn-arrow").hide();
                    });
                } else {
                    $(this).data("type", "show");
                    $(this).attr("title", "展开菜单");

                    $("#menuBox").animate({ "bottom": "-76px" });
                    $(this).removeClass("menu-arrow-bottom").addClass("menu-arrow-up");
                    $("#menuBox").off("mouseout");
                }
            });

            $(".menu-btn-arrow").trigger("click");
        },
        getTmp: function (index) {
            var that = this;

            if (!$(".swiper-slide-parent").eq(index).children().length) {
                utils.ajax({
                    url: that.menuData[index].tmpUrl,
                    type: 'get',
                    dataType: "html",
                    context: $(".swiper-slide-parent").eq(index), //当前上下文，防止多次提交
                    success: function (data) {
                        if (data) {
                            $(".swiper-slide-parent").eq(index).html(data);

                            that.getQRCode(); //加载qrCode

                            //异步加载对应模块JS
                            //require(['big_screen_' + that.menuData[index].typeName], function (module) {
                            //    module.init(that);
                            //});

                            //异步加载对应模块JS  解决ipad全屏下加载失效问题
                            var eleRandomId = (new Date()).getTime() + parseInt(Math.random() * 100000);
                            require([CONFIG.URL.staticAll + "/app/wall/big_screen_" + that.menuData[index].typeName + ".js?v=" + eleRandomId], function (module) {

                                that[that.menuData[index].pageName] = module;
                                that[that.menuData[index].pageName].init(that);

                                if (!that.polling) {
                                    //创建轮询
                                    that.polling = new polling(CONFIG.URL.wallApp + "/connect");

                                    //1.初始化轮询
                                    that.polling.init({
                                        ext: "{wallid:'{0}'}".format(global['wallid']),
                                        success: function (json) {
                                            if (json.successful) {

                                                that.polling.addSuccess(function (message) {

                                                    if (message) {
                                                        switch (message.type) {
                                                            case "chat":
                                                                if (that.chat && that.chat.pollCallback) { that.chat.pollCallback(message); }
                                                                break;
                                                            case "picture":
                                                                if (that.picture && that.picture.pollCallback) { that.picture.pollCallback(message); }
                                                                if (that.chat && that.chat.pollCallback) { that.chat.pollCallback(message); }
                                                                break;
                                                            case "qd":
                                                                if (that.qd && that.qd.pollCallback) { that.qd.pollCallback(message); }
                                                                break;
                                                            case "vote":
                                                                //if (that.vote && that.vote.pollCallback) { that.vote.pollCallback(message); }
                                                                break;
                                                            case "share":
                                                                //if (that.share && that.share.pollCallback) { that.share.pollCallback(message); }
                                                                break;
                                                        }
                                                    }
                                                });
                                                //2.开始轮询
                                                that.polling.subscribe();
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    }
                });
            }
        },
        qrCodeSpeed:600000,
        getQRCode: function () {
            //获取QR数据
            utils.ajax({
                url: '/ajax/GetRequestQrImage',
                data: {
                    WallId: global["wallid"]
                },
                context: $(".alert-dismissable"),
                success: function (data) {
                    
                    if (data.successful) {
                        if (data.code > 0) {

                            $(".img-qrcode").data("qrcode", "#" + global.qrcode);
                            $(".img-qrcode").data("qrurl", CONFIG.URL.file + data.data);


                            $(".qr-code-box .qr-img").attr("src", CONFIG.URL.file + data.data);
                            $(".qr-code-box .wechat-no").html("#" + global.qrcode);
                            $(".img-qrcode").attr("src", CONFIG.URL.file + data.data);

                            if (data.data == "") {
                                data.data = CONFIG.URL.staticImg + "/wall/screen/qrcode.png";
                                $(".qr-code-box .qr-img").attr("src", data.data);
                                $(".img-qrcode").attr("src", data.data);
                            }

                        } else {
                            $.dialog.tips({
                                status: "warnning",
                                content: '服务器正忙！'
                            });
                        }
                    }
                }
            });
        },
        getJoinNum: function () {
            
            //获取QR数据
            utils.ajax({
                url: '/ajax/GetRoomUserCount',
                data: {
                    WallId: global["wallid"]
                },
                context: $(".img-qrcode"),
                success: function (data) {
                    if (data.successful) {
                        if (data.code > 0) {
                            $(".qr-code-box .add-num").html(data.data.Results);
                        }
                    }
                }
            });
        },
        //图片自适应高
        imgCalWidthInit: function () {
            var that = this;
            that.imgCalW();
            $(window).on("resize.imgCalW", function () {
                that.imgCalW();
                //console.log(that.imgCalW());
            });
        },
        cssReplace: function (str, nowselect, nowcss) {
            //str.replace(new RegExp(nowselect.replace(/\./g,"\\.")+"{.*?}"),"")
            var regNowSelector = nowselect.replace(/\./g, "\\.");
            var reg = new RegExp(regNowSelector + "{.*?}");
            var strNowAll = nowselect + "{" + nowcss + "}";
            var test = str.match(reg);
            var ret = "";
            if (!test) {
                ret = str + strNowAll;
            } else {
                ret = str.replace(reg, strNowAll);
            }
            return ret;
        },
        imgCalW: function () {
            var hasDom = $("#imgCalW").length;
            var str = $("#imgCalW").html() || "";

            var imgW = 0;
            
            var img1W = $(".row-wallimg-picture").find(".col-xs-2").width();
            if (img1W) {
                str = this.cssReplace(str, ".row-wallimg-picture .col-xs-2", "height:" + img1W + "px;overflow:hidden;");
                //var style1 = ".row-wallimg-picture .col-xs-2{height:" + img1W + "px;overflow:hidden;}";
                //str += style1;
                imgW = img1W;
            }

            //var img2W = $(".row-wallimg-user").find(".img-js-calw").width();
            var img2W = $(".row-wallimg-user").find(".img").innerWidth();
            if (img2W) {
                str = this.cssReplace(str, ".row-wallimg-user .img", "height:" + img2W + "px;");
                //var style2 = ".row-wallimg-user .img{height:" + img2W + "px;}";
                //str += style2;
                imgW = img2W;
            }

            var img3W = $(".row-lottery-1").find(".img-js-calw").innerWidth();
            if (img3W) {
                str = this.cssReplace(str, ".row-lottery-1 .img-lottery-2-avatar,.row-lottery-2 .img-lottery-2-avatar", "height:" + img3W + "px;");
                //var style3 = ".row-lottery-1 .img-lottery-2-avatar,.row-lottery-2 .img-lottery-2-avatar{height:" + img3W + "px;}";
                //str += style3;
                imgW = img3W;
            }

            if (hasDom) {
                $("#imgCalW").html(str);
            } else {
                $("<style id=\"imgCalW\">" + str + "</style>").appendTo("head");
            }
            
            return imgW;
        },
        scroll: function () {
            $("body").on("mouseenter mouseleave", ".is-scroll", function (e) {
                $(this).toggleClass("is-scroll-hover", e.type === "mouseenter");
            });
        },
        gotoFullscreen: function (element, method) {
            var el = document.documentElement
                , rfs = // for newer Webkit and Firefox
                       el.requestFullScreen
                    || el.webkitRequestFullScreen
                    || el.mozRequestFullScreen
                    || el.msRequestFullScreen
            ;
            if (typeof rfs != "undefined" && rfs) {
                rfs.call(el);
            } else if (typeof window.ActiveXObject != "undefined") {
                // for Internet Explorer
                var wscript = new ActiveXObject("WScript.Shell");
                if (wscript != null) {
                    wscript.SendKeys("{F11}");
                }
            }
        },
        exitFullscreen:function(){
            var de = document;
            if (de.exitFullscreen) {
                de.exitFullscreen();
            } else if (de.mozCancelFullScreen) {
                de.mozCancelFullScreen();
            } else if (de.webkitCancelFullScreen) {
                de.webkitCancelFullScreen();
            }
        },
        menuData: [
            {
                index: '0',
                typeName: 'topic',
                pageName: 'chat',
                tmpUrl: CONFIG.URL.wallApp + '/Template/topic/' + global['wallid']
            },
            {
                index: '1',
                typeName: 'picture',
                pageName: 'picture',
                tmpUrl: CONFIG.URL.wallApp + '/Template/picture/' + global['wallid']
            },
            {
                index: '2',
                typeName: 'checkin',
                pageName: 'qd',
                tmpUrl: CONFIG.URL.wallApp + '/Template/checkin/' + global['wallid']
            },
            {
                index: '3',
                typeName: 'lottery',
                pageName: 'share',
                tmpUrl: CONFIG.URL.wallApp + '/Template/lottery/' + global['wallid']
            },
            {
                index: '4',
                typeName: 'vote',
                pageName: 'vote',
                tmpUrl: CONFIG.URL.wallApp + '/Template/vote/' + global['wallid']
            },
            {
                index: '5',
                typeName: 'full',
                tmpUrl: ''
            },
            {
                index: '6',
                typeName: 'setup',
                tmpUrl: ''
            }
        ]
    };
    return bigScreenFrame;
});