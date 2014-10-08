/**
* big_screen_topic.js
* @fileOverview 微信墙->大屏讨论
* @author Tim
* @version 1.0
* @date 2014-05-15
* @remark 实现微信墙的大屏讨论
*/

define(['utils', 'template', 'dialogTools'], function (utils, temp, dialogTools) {
    var global = window.$CONFIG || {};
    var bigScreenTopic = {
        // 初始化
        init: function (opt) {
            var that = this;
            this.bindEvent();

        },
        // 绑定事件
        bindEvent: function () {
            var that = this;
            //选择话题下拉
            $(".container-topic").on(window.tap, ".sel-topic", function () {
                if ($(this).data("isShow")) {
                    $(this).data("isShow", 0);
                    $(".container-topic .sel-box").slideUp();
                    $(".container-topic .sel-topic .arrow").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
                } else {
                    $(this).data("isShow", 1);
                    $(".container-topic .sel-box").slideDown();
                    $(".container-topic .sel-topic .arrow").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
                }
            }).on("mouseover", ".sel-topic", function () {
                $(".container-topic .arrow").show();
            }).on("mouseout", ".sel-topic", function () {
                $(".container-topic .arrow").hide();
            });

            //下拉框列表点击
            $(".container-topic").on(window.tap, ".sel-box .item", function (e) {
                utils.event.stop(e);
                $(".container-topic .sel-topic").data("isShow", 0);
                $(".container-topic .sel-box").slideUp();
                $(".container-topic .sel-topic .arrow").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");

                var topicName = $(this).html();
                var id = $(this).data("id");
                var userid = $(this).data("userid");
                //加载数据
                that.getTopicList(id, userid);
                //默认主题
                if (userid == 0) {
                    $(this).parents('div.sel-topic').addClass('txt-con-2');
                    $(this).parents('div.sel-topic').find('h2.txt-2').show();
                } else {
                    $(this).parents('div.sel-topic').removeClass('txt-con-2');
                    $(this).parents('div.sel-topic').find('h2.txt-2').hide();
                }
                $(".container-topic .sel-topic .txt").html(topicName);
            });

            var itemListObj=$(".container-topic .sel-box .item");
            if (itemListObj.length) {
                for (var i = 0; i < itemListObj.length; i++){
                    if (itemListObj.eq(i).data("userid") == "0") {
                        $(".container-topic .sel-box .item").eq(i).trigger(window.tap);
                        break;
                    }
                }
            } else {
                that.getTopicList();
            }

            //$(".container-topic").on(window.tap, ".img-logo", function () {
            //    var data = {
            //        items: [
            //            {
            //                "Content": "频道chat,测试数据!",
            //                "CreateTime": "2014-06-06 10:49:08",
            //                "NickName": "Kk",
            //                "Photo": "http://tp3.sinaimg.cn/2360155050/180/40006191934/1",
            //                "UserId": "538ea7d32fdb5f22c08d82f0"
            //            }
            //        ]
            //    };
            //    that.setTopic(data);
            //});

        },
        pollCallback: function (data) {
            if (data.items.length > 0) {
                for (var i = 0; i < data.items.length; i++) {
                    data.items[i].Content = this.processFacialExpression(data.items[i].Content);  //emoje解码
                    
                    //默认头像
                    if (data.items[i].Photo == "") {
                        data.items[i].Photo = "/wall/wechat_userico.png";
                    }


                    if ($(".row-talking .item").first().length) {
                        var maxFloor = parseInt($(".row-talking .item").first().data("floor")); //获取当前最高楼层
                        data.items[i].Floor = maxFloor + 1;
                    } else {
                        data.items[i].Floor = i+1;
                    }
                }
            }

            this.setTopic(data);
        },
        getTopicList: function (topicid, userid) {
            var that = this;
            //注册滚动事件
            utils.scroll({
                el: ".row-talking",
                url: "/ajax/GetContentList",
                data: {
                    WallId: global["wallid"],
                    TopicId: topicid,
                    UserId:userid,
                    page: 1,
                    pagesize: 10
                }
            }, function (json, opt) {
                if (json.data && json.data.items) {
                    if (json.code > 0) {
                        if (opt.page > 1 && json.data.items.length > 0) {
                            that.floor = parseInt($(".row-talking .item").last().data("floor")) - 1;
                        } else {
                            that.floor = json.data.total;
                        }

                        if (json.data.items.length > 0) {
                            for (var i = 0; i < json.data.items.length; i++) {
                                json.data.items[i].Content = that.processFacialExpression(json.data.items[i].Content);
                                json.data.items[i].Floor = that.floor--;
                                //if (json.data.items[i].Photo == "") {
                                //    json.data.items[i].Photo = "/img/wall/wechat_userico.png";
                                //}
                            }
                        }

                        if (json.data.total == 0) {
                            $(".row-talking").fadeOut(function () {
                                $(".row-talking").show().html('<div class="col-xs-12"><div class="tip" style="text-align:center; font-size: 20px;">一个评论也没有，快来互动吧</div></div>');
                            });
                            //$.dialog.tips({
                            //    status: "info",
                            //    content: '该话题没有数据！'
                            //});
                            //var logoUrl = $(".img-logo").eq(0).attr("src");
                            //if (logoUrl == "http://file.31huiyi.com") {
                            //    logoUrl = CONFIG.URL.staticImg + "/wall/screen/img-logobottom.png";
                            //}
                            //var defaultData = {
                            //    "type":"default",
                            //    "items" : [
                            //        {
                            //            "NickName": "31会议网",
                            //            "Photo": logoUrl,
                            //            "Content": "欢迎使用微信墙服务，请发送#" + global["qrcode"] + "房间号加入互动",
                            //            "Floor":0
                            //        }
                            //    ]
                            //};
                            //that.setTopic(defaultData, 1);
                        } else if (opt.page == 1) {
                            $(".row-talking").find(".tip").remove();

                            $(".row-talking").fadeIn();
                            that.setTopic(json.data, 1);
                        } else {
                            $(".row-talking").find(".tip").remove();

                            $(".row-talking").fadeIn();
                            that.setTopic(json.data, 2);
                        }
                    } else {
                        $.dialog.tips({
                            status: "warnning",
                            content: '哎呀，出错了！'
                        });
                    }
                }
            });
        },
        floor:0,
        setTopic: function (data,type) {
            var that = this;

            var topicListHtml = temp.render("topicItem", data);
            if ($(".row-talking .tip").length) {
                $(".row-talking .tip").remove();
            }
            
            //type  1:htm  2:append
            if (type == 1) {
                $(".row-talking").html(topicListHtml);
                $(".row-talking .item").slideDown(function () {
                    $(this).removeAttr("style");
                });
            } else if(type == 2) {
                $(".row-talking").append(topicListHtml);
                $(".row-talking .item").slideDown(function () {
                    $(this).removeAttr("style");
                });
            } else {
                $(".row-talking").prepend(topicListHtml);
                $(".row-talking .item").slideDown(function () {
                    $(this).removeAttr("style");
                });
            }
            //向下滚动
            //var topicHeight = $(".row-talking").height();
            //var topicScrollHeight = $(".row-talking")[0].scrollHeight;
            //$(".row-talking").animate({ "scrollTop": topicScrollHeight - topicHeight + "px" }, function () {
            //    //that.destoryReaded();
            //});
        },
        destoryReaded:function() {
            var totalNum = $(".row-talking .item").length;
            if (totalNum > 3) {
                var removeNum = totalNum - 3;
                $(".row-talking .item:lt(" + removeNum + ")").remove();
            }
        },
        emojies:['/::)','/::~','/::B','/::|','/:8-)','/::<','/::$','/::X','/::Z','/::\'(','/::-|','/::@','/::P','/::D','/::O','/::(','/::+','/:Cb','/::Q','/::T','/:,@P','/:,@-D','/::d','/:,@o','/::g','/:|-)','/::!','/::L','/::>','/::,@','/:,@f','/::-S','/:?','/:,@x','/:,@@','/::8','/:,@!','/:!!!','/:xx','/:bye','/:wipe','/:dig','/:handclap','/:&-(','/:B-)','/:<@','/:@>','/::-O','/:>-|','/:P-(','/::\'|','/:X-)','/::*','/:@x','/:8*','/:pd','/:<W>','/:beer','/:basketb','/:oo','/:coffee','/:eat','/:pig','/:rose','/:fade','/:showlove','/:heart','/:break','/:cake','/:li','/:bome','/:kn','/:footb','/:ladybug','/:shit','/:moon','/:sun','/:gift','/:hug','/:strong','/:weak','/:share','/:v','/:@)','/:jj','/:@@','/:bad','/:lvu','/:no','/:ok','/:love','/:<L>','/:jump','/:shake','/:<O>','/:circle','/:kotow','/:turn','/:skip','/[挥手]','/:#-0','/[街舞]','/:kiss','/:<&','/:&>'],
        processFacialExpression: function (str) {
            if (str) {
                str = str.replaceAll('<', '&lt;');
                for (var i = 0; i < this.emojies.length; i++) {
                    if (str.indexOf('/:', 0) >= 0) {
                        str = str.replaceAll(this.emojies[i], '<img src="http://www.31huiyi.com/picture/weixin/emoji/' + i + '.png"/>');
                    } else {
                        break;
                    }
                }
                return str;
            } else {
                return str;
            }
        }
    };
    return bigScreenTopic;
});