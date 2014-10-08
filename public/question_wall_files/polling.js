define(['jquery'], function () {
    /**
    * polling对象
    */
    function polling(handler, clientid, channel) {
        this.handler = handler; //轮询地址
        this.successEventHandler = []; //成功委托
        this.failureEventHandler = []; //失败委托
        this.timeoutEventHandler = []; //超时委托
        //this.privateToken = privateToken; //密钥
        this.clientid = clientid || this.guid(); //用户标识
        this.channel = channel; //用户通道标识
        this.lastMessageId = 0; //消息记录
        this.enabled = true; //轮询可用
    }

    /**
    * 添加成功事件
    */
    polling.prototype.addSuccess = function (func) {
        this.successEventHandler[this.successEventHandler.length] = func;
    };

    /**
    * 添加失败事件
    */
    polling.prototype.addFailure = function (func) {
        this.failureEventHandler[this.failureEventHandler.length] = func;
    };

    /**
    * 添加超时事件
    */
    polling.prototype.addTimeout = function (func) {
        this.timeoutEventHandler[this.timeoutEventHandler.length] = func;
    };

    /**
    * 执行成功事件
    */
    polling.prototype.callSuccess = function (clientid, message) {
        for (var i = 0; i < this.successEventHandler.length; i++) {
            this.successEventHandler[i](message);
        }
    };

    /**
    * 执行失败事件
    */
    polling.prototype.callFailure = function (clientid, error) {
        for (var i = 0; i < this.failureEventHandler.length; i++) {
            this.failureEventHandler[i](error);
        }
    };

    /**
    * 执行超时事件
    */
    polling.prototype.callTimeout = function (clientid) {
        for (var i = 0; i < this.timeoutEventHandler.length; i++) {
            this.timeoutEventHandler[i](clientid);
        }
    };

    /**
    * 开始订阅
    */
    polling.prototype.subscribe = function () {
        var _this = this;
        $.ajax({
            type: 'get',
            url: _this.handler,
            data: {
                message: "{id:'" + _this.lastMessageId + "',connectionType:'callback-pollinging',clientid:'" + _this.clientid + "',channel:'/meta/connect'}"
            },
            dataType: 'jsonp',
            jsonp: 'jsonp',
            contentType: 'text/javascript;charset=utf-8',
            success: function (o) {
                var result = o;
                if (result == null || result.length == 0) {
                    //调用失败的方法
                    _this.callFailure(_this.publicToken, null);
                } else {
                    var message = result[0];

                    switch (message.type) {
                        case "error":
                            //  失败
                            _this.callFailure(_this.clientid, message.data);
                            break;
                        case "timeout":
                            //  超时
                            _this.callTimeout(_this.clientid);

                            if (_this.enabled) {

                                _this.subscribe();
                            }
                            break;
                        default:
                            //  成功
                            for (var i = 0; i < result.length; i++) {
                                var message = result[i];

                                _this.lastMessageId = message.id;

                                _this.callSuccess(_this.clientid, message.data);
                            }

                            if (_this.enabled) {
                                _this.subscribe();
                            }
                            break;
                    }

                }
            },
            error: function (o) {
                //调用失败的方法
            }
        });
    };

    /**
    * 取消订阅
    */
    polling.prototype.unsubscribe = function () {
        this.enabled = false;
    };

    /**
    * 生成Guid
    */
    polling.prototype.guid = function () {
        var res = [], hv;
        var rgx = new RegExp("[2345]");
        for (var i = 0; i < 8; i++) {
            hv = (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
            if (rgx.exec(i.toString()) != null) {
                if (i == 3) {
                    hv = "6" + hv.substr(1, 3);
                }
                //res.push("-");
            }
            res.push(hv.toUpperCase());
        }
        return res.join('');
    };

    /**
    * 发送请求
    */
    polling.prototype.ajax = function (options) {
        var _this = this;
        var opts = $.extend(true, {
            url: _this.handler,
            data: {},
            success: function () {
            },
            error: function () {
            }
        }, options || {});

        try {
            $.ajax({
                type: 'get',
                url: opts.url,
                data: opts.data,
                dataType: 'jsonp',
                jsonp: 'jsonp',
                contentType: 'text/javascript;charset=utf-8',
                success: function (o) {
                    if (o.code == -999) {
                        //登录

                    } else {
                        if (opts.success) {
                            opts.success(o);
                        }
                    }
                },
                error: function (o) {
                    if (opts.error) {
                        opts.error(o.status, o.responseText);
                    }
                }
            });
        } catch (e) {
        }
    };

    /**
    * 发送请求
    */
    polling.prototype.sender = function (options) {
        this.ajax($.extend(true, {
            data: {
                message: "{ id:'0',clientid:'" + this.clientid + "',data:{},channel:'/im/req' }"
            }
        }, options || {}));
    };


    /**
    * 初始化
    */
    polling.prototype.init = function (options) {
        this.ajax($.extend(true, {
            data: {
                message: "{ id:'0',clientid:'" + this.clientid + "',channel:'/meta/handshake'" + (options.ext ? ",ext:" + options.ext : "") + " }"
            }
        }, options || {}));
    };

    return polling;
});