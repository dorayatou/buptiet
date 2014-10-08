/**
* utils.js
* @fileOverview 网站共用方法库
* @author Tim
* @version 1.0
* @date 2013-09-02
* @extends jquery.1.8.3
* @remark 不涉及网站具体业务逻辑,只是对常用公共方法进行封装
*/

define(['jquery'], function ($) {
    var utils = {};

    //常用配置
    utils.config = {
        DEBUG: true
    };

    //拖曳
    utils.drag = function (obj, position, target, offset, func) {
        func = func || $.noop;
        target = $(target || obj);
        position = position || window;
        offset = offset || {
            x: 0,
            y: 0
        };
        return obj.css("cursor", "move").bind("mousedown.drag", function (e) {
            e.preventDefault();
            e.stopPropagation();
            //if (e.which && (e.which != 1)) return;
            //if (e.originalEvent.mouseHandled) { return; }
            if (document.defaultView) {
                var _top = document.defaultView.getComputedStyle(target[0], null).getPropertyValue("top");
                var _left = document.defaultView.getComputedStyle(target[0], null).getPropertyValue("left");
            } else {
                if (target[0].currentStyle) { //这个是在ie下取得元素的样式
                    var _top = target.css("top");
                    var _left = target.css("left");
                }
            }
            var width = target.outerWidth(),
                height = target.outerHeight();
            if (position === window) {
                position = $.browser.msie6 ? document.body : window;
                var mainW = $(position).width() - offset.x,
                    mainH = $(position).height() - offset.y;
            } else {
                var mainW = $(position).outerWidth() - offset.x,
                    mainH = $(position).outerHeight() - offset.y;
            }
            target.posX = e.pageX - parseInt(_left);
            target.posY = e.pageY - parseInt(_top);
            if (target[0].setCapture) target[0].setCapture();
            else if (window.captureEvents) window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
            $(document).unbind(".drag").bind("mousemove.drag", function (e) {
                var posX = e.pageX - target.posX,
                    posY = e.pageY - target.posY;
                target.css({
                    left: function () {
                        if (posX > 0 && posX + width < mainW)
                            return posX;
                        else if (posX <= 0)
                            return offset.x;
                        else if (posX + width >= mainW)
                            return mainW - width;
                    },
                    top: function () {
                        if (posY > 0 && posY + height < mainH)
                            return posY;
                        else if (posY <= 0)
                            return offset.y;
                        else if (posY + height >= mainH)
                            return mainH - height;
                    }
                });
                func(_top, _left, width, height, posY, posX);
            }).bind("mouseup.drag", function (e) {
                if (target[0].releaseCapture) target[0].releaseCapture();
                else if (window.releaseEvents) window.releaseEvents(Event.MOUSEMOVE | Event.MOUSEUP);
                $(this).unbind(".drag");
            });
        });
    };


    //错误日志打印
    utils.log = function (msg, src) {
        var that = this;
        if (that.config.DEBUG) {
            if (src) {
                msg = src + ' : ' + msg;
            }
            if (window['console']) {
                console.log(msg);
            }
        }
    };

    //json to str
    utils.strToJson = function (msg, type) {
        var that = this;
        var str = type ? undefined : {};

        if (!msg || that.getType(msg) != 'string') {
            return str;
        }
        try {
            var ToJsonOBJ = eval("(" + msg + ")");
            if (this.getType(ToJsonOBJ) == 'object' || that.getType(ToJsonOBJ) == 'array') {
                return ToJsonOBJ;
            }
        } catch (e) {
        }
        return str;
    };
    utils.jsonToStr = function (o) {
        var that = this;
        if (o == undefined) {
            return "";
        }
        var r = [];
        if (typeof o == "string") {
            return "\"" + o.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n").replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + "\"";
        }
        if (typeof o == "object") {
            if (!o.sort) {
                for (var i in o) {
                    r.push("\"" + i + "\":" + that.jsonToStr(o[i]));
                }
                if (!!document.all && !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/.test(o.toString)) {
                    r.push("toString:" + o.toString.toString());
                }
                r = "{" + r.join() + "}";
            } else {
                for (var i = 0; i < o.length; i++) {
                    r.push(that.jsonToStr(o[i]));
                }
                r = "[" + r.join() + "]";
            }
            return r;
        }
        return o.toString().replace(/\"\:/g, '":""');
    };
    utils.getType = function (o) {
        var _t;
        return ((_t = typeof (o)) == "object" ? Object.prototype.toString.call(o).slice(8, -1) : _t).toLowerCase();
    };

    //阻止事件冒泡
    utils.event = {
        stop: function (event) {
            if (event && event.preventDefault) {
                // 阻止默认浏览器动作(W3C)
                event.preventDefault();
            } else {
                // IE中阻止函数器默认动作的方式
                window.event.returnValue = false;
            }
            if (event && event.stopPropagation) {
                // 因此它支持W3C的stopPropagation()方法
                event.stopPropagation();
            } else {
                // 否则，我们需要使用IE的方式来取消事件冒泡
                window.event.cancelBubble = true;
            }
        }
    };

    //Ajax
    utils.loadingObjArr = {};
    utils.loading = function (item) {

        if (item.type == "wheel") {
            //loading skin one
            if (item.loadingObj == "") {
                return;
            }

            var loadingImg = '<img src="' + CONFIG.URL.staticImg + '/loading.gif"/>',
                bgStr = "";

            if (item.isMask) {
                bgStr = "background:rgba(255, 255, 255, 0.6); filter:alpha(opacity=30); _background:#fff;";
            }

            var msgTxt = '<div style="text-align:center; margin-top:6px; color:#666;">' + item.msgTxt + '</div>';

            var loadingBox = '<div style="' + bgStr + '" id="loadingBox_' + item.eleID + '" class="utils-ajax-loading">' + loadingImg + msgTxt + '</div>';
            $("body").append(loadingBox);

            this.loadingObjArr[item.eleID] = $("#" + "loadingBox_" + item.eleID);
            var loadingParentEl = item.loadingObj;

            var boxW = loadingParentEl.outerWidth(),
                boxH = loadingParentEl.outerHeight(),
                boxT = loadingParentEl.offset().top,
                boxL = loadingParentEl.offset().left,
                loadingEl = $("#" + "loadingBox_" + item.eleID),
                imgW = 32,
                imgH = 32;


            if (item.imgW) {
                imgW = item.imgW;
            }
            if (item.imgH) {
                imgH = item.imgH;
            }

            loadingEl.css({
                "position": "absolute",
                "z-index": "100000",
                "text-align": "center",
                "width": boxW + "px",
                "height": boxH + "px",
                "paddingTop": boxH / 2 - imgH / 2 + "px",
                "top": boxT + "px",
                "left": boxL + "px"
            });

            //窗口改变时重置位置
            $(window).bind('resize', function () {
                var loadingParentEl = item.loadingObj;
                var boxW = loadingParentEl.outerWidth(),
                    boxH = loadingParentEl.outerHeight(),
                    boxT = loadingParentEl.offset().top,
                    boxL = loadingParentEl.offset().left;

                loadingEl.css({
                    "width": boxW + "px",
                    "height": boxH + "px",
                    "top": boxT + "px",
                    "left": boxL + "px"
                });

                $(".utils-ajax-mask").css({
                    "width": windowW + "px",
                    "height": windowH + "px"
                });
            });
        } else if (item.type == "belt") {
            //loading skin two
            if (item.loadingObj == "") {
                return;
            }

            var loadingImg = '<img src="' + CONFIG.URL.staticImg + '/loading_01.gif"/>',
                bgStr = "";

            bgStr = "background:#fcfcfc; border-radius:8px; padding: 20px 30px; text-align:center; background-image:-ms-linear-gradient(top, rgba(255, 255, 255,1) 0%, rgba(220, 220, 220,1) 100%); background-image: -webkit-gradient(linear, 0% 0%, 0% 100%, from(rgb(255, 255, 255)), to(rgb(220, 220, 220))); -webkit-box-shadow: rgb(102, 102, 102) 2px 2px 5px; box-shadow: rgb(102, 102, 102) 2px 2px 5px; border: 1px solid rgb(217, 215, 211);";

            var msgTxt = '<div style="text-align:center; margin-top:6px; color:#666; text-shadow: rgb(255, 255, 255) 2px 2px 5px; color: rgb(0, 69, 120); white-space: pre-wrap; font-weight: 800; font-size:20px;">' + item.msgTxt + '</div>';

            var windowW = $(window).width();
            var windowH = $(window).height();

            var maskBox = '<div style="background:#fcfcfc; filter:alpha(opacity=30); background:rgba(0, 0, 0, 0.2); z-index:10000; position:fixed; top:0px; left:0px; width:' + windowW + 'px; height:' + windowH + 'px;" class="utils-ajax-mask"></div>';
            var loadingBox = maskBox + '<div style="' + bgStr + '" id="loadingBox_' + item.eleID + '" class="utils-ajax-loading">' + loadingImg + msgTxt + '</div>';
            $("body").append(loadingBox);

            this.loadingObjArr[item.eleID] = $("#" + "loadingBox_" + item.eleID);
            var loadingParentEl = item.loadingObj;

            var boxW = loadingParentEl.outerWidth(),
                boxH = loadingParentEl.outerHeight(),
                boxT = loadingParentEl.offset().top,
                boxL = loadingParentEl.offset().left,
                loadingEl = $("#" + "loadingBox_" + item.eleID),
                imgW = 32,
                imgH = 32;


            if (item.imgW) {
                imgW = item.imgW;
            }
            if (item.imgH) {
                imgH = item.imgH;
            }

            loadingEl.css({
                "position": "fixed",
                "z-index": "100001",
                "min-width": "230px",
                "min-height": "110px",
                "max-width": "400px",
                "top": (windowH - 110) / 2 + "px",
                "left": (windowW - 230)/2 + "px"
            });


            //窗口改变时重置位置
            $(window).bind('resize', function () {
                var windowW = $(window).width();
                var windowH = $(window).height();
                loadingEl.css({
                    "top": (windowH - 110) / 2 + "px",
                    "left": (windowW - 230) / 2 + "px"
                });

                $(".utils-ajax-mask").css({
                    "width": windowW + "px",
                    "height": windowH + "px"
                });
            });
        }
    };
    utils.ajax = function (opts) {
        var that = this,
            eleRandomId = (new Date()).getTime() + parseInt(Math.random() * 100000);

        $.ajax({
            url: opts.url || "",
            data: opts.data || {},
            async: opts.async || true,
            type: opts.type || "post",
            dataType: opts.dataType || "json",
            ifModified: false,
            timeout: opts.timeout || 20000,
            traditional: false,
            cache: opts.cache || false,
            context: new Object() || $("body"),
            beforeSend: function () {
                if (this["issubmit"]) {
                    return false;
                }
                this["issubmit"] = 1;

                if (opts.loadingObj) {
                    that.loading({
                        eleID: eleRandomId,
                        loadingObj: opts.loadingObj.el || "",
                        msgTxt: opts.loadingObj.msg || '载入中...',
                        isMask: opts.loadingObj.isMask || false,
                        type: opts.loadingObj.type || "wheel"
                    });
                }
                if (opts.start) {
                    opts.start();
                }
            },
            success: function (data) {
                if (opts.success) {
                    opts.success(data);
                }
            },
            error: function (data) {
                if (opts.error) {
                    opts.error(data);
                }
                that.log('网络超时，请重试！');
            },
            complete: function (o) {
                this["issubmit"] = 0;
                if (opts.loadingObj) {
                    if (that.loadingObjArr[eleRandomId]) {
                        $(".utils-ajax-mask").remove();
                        that.loadingObjArr[eleRandomId].remove();
                    }
                }
                if (opts.complete) {
                    opts.complete();
                }
            }
        });
    };

    //获取url信息
    utils.splitEx = function (str, qr, Len) {
        var a = str.split(qr);
        if (!Len) {
            return a;
        }
        var b = [];
        var s = '';
        for (var i = 0; i < a.length; i++) {
            if (i < Len - 1) {
                b.push(a[i]);
            } else {
                s += (!s) ? a[i] : qr + a[i];
            }
        }
        b.push(s);
        return b;
    };
    utils.getRequest = function (MyUrl) {
        var url = '';
        var theRequest = {};
        theRequest.locationUrl = '';
        theRequest.locationDomain = '';
        theRequest.locationHost = '';
        theRequest.locationProt = '80';
        theRequest.locationDir = '';
        theRequest.locationType = '';
        theRequest.locationPlot = '';
        var urlhref = MyUrl || document.location.href;
        var urlArr = this.splitEx(urlhref, '?', 2);
        if (urlArr.length) {
            var uu = this.splitEx(urlArr[1], '#', 2);
            url = '?' + uu[0];
            if (uu[1]) {
                theRequest.locationPlot = uu[1];
            }
            theRequest.locationUrl = urlArr[0];
            var IsHttp = 0;
            var IsFile = 0;
            var RgbReg = /^http:\/\//i;
            if (RgbReg.test(urlArr[0])) {
                IsHttp = 1;
                theRequest.locationType = 'HTTP';
            }
            if (!IsHttp) {
                RgbReg = /^file:\/\/\//i;
                if (RgbReg.test(urlArr[0])) {
                    IsFile = 1;
                    theRequest.locationType = 'FILE';
                }
            }
            var HttpStr = urlArr[0];
            if (IsHttp) {
                HttpStr = urlArr[0].replace(/^http:\/\//i, '');
            }
            if (IsFile) {
                HttpStr = urlArr[0].replace(/^file:\/\/\//i, '');
            }
            var HttpArray = HttpStr.split('/');
            if (HttpArray[0]) {
                if (HttpArray[1]) {
                    for (var i = 1; i < HttpArray.length; i++) {
                        RgbReg = /^\//i;
                        if (!RgbReg.test(HttpArray[i])) {
                            HttpArray[i] = '/' + HttpArray[i];
                        }
                        theRequest.locationDir += HttpArray[i];
                    }
                }
                if (IsFile) {
                    theRequest.locationHost = HttpArray[0];
                    theRequest.locationProt = '';
                }
                if (IsHttp) {
                    var HP = this.splitEx(HttpArray[0], ':', 2);
                    theRequest.locationHost = HP[0];
                    theRequest.locationProt = HP[1];
                }
            }
        }
        if (url && url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for (var i = 0; i < strs.length; i++) {
                var HS = this.splitEx(strs[i], '=', 2);
                theRequest[HS[0]] = unescape(HS[1]);
            }
        }
        if (theRequest.locationType) {
            var hand = '';
            if (theRequest.locationType == 'HTTP') {
                hand = 'http://';
            }
            if (theRequest.locationType == 'FILE') {
                hand = 'file:///';
            }
            theRequest.locationDomain = hand + theRequest.locationHost;
            if (theRequest.locationProt && theRequest.locationProt != 80 && theRequest.locationType == 'HTTP') {
                theRequest.locationDomain += ':' + theRequest.locationProt;
            }
        }
        if (MyUrl && !theRequest.locationHost) {
            var RgbReg = /^\//i;
            if (RgbReg.test(theRequest.locationUrl)) {
                var uu = this.GetRequest();
                theRequest.locationHost = uu.locationHost;
                theRequest.locationType = uu.locationType;
                theRequest.locationDomain = uu.locationDomain;
                theRequest.locationProt = uu.locationProt;
                theRequest.locationDir = theRequest.locationUrl;
                theRequest.locationUrl = theRequest.locationDomain + theRequest.locationDir;
            }
        }
        return theRequest;
    };
    //对象克隆
    utils.object = {
        clone: function (obj) {
            var con = obj.constructor, cloneObj = null;
            if (con == Object) {
                cloneObj = new con();
            } else if (con == Function) {
                return Cute.Function.clone(obj);
            } else cloneObj = new con(obj.valueOf());

            for (var it in obj) {
                if (cloneObj[it] != obj[it]) {
                    if (typeof (obj[it]) != 'object') {
                        cloneObj[it] = obj[it];
                    } else {
                        cloneObj[it] = arguments.callee(obj[it])
                    }
                }
            }
            cloneObj.toString = obj.toString;
            cloneObj.valueOf = obj.valueOf;
            return cloneObj;
        }
    };

    //字数限制
    utils.wordLimit = function (opt) {
        var that = this;
        var currLength = opt.inputObj.val().length;
        if (currLength > opt.max) {
            opt.btnObj.removeClass("btn-warning").addClass("btn-disabled");
            opt.btnObj.data("isdisabled", true);
            opt.tipObj.html(currLength + "/" + opt.max);
            opt.inputObj.stop().css({ "background-color": "#fcc" }).fadeOut(100).fadeIn(100).fadeOut(100, function () { opt.inputObj.css({ "background-color": "white", "border": "1px solid #ff0000" }); }).fadeIn(100, function () { opt.inputObj.css({ "opacity": 1 }); }).trigger("focus");

        } else {
            opt.btnObj.addClass("btn-warning").removeClass("btn-disabled");
            opt.inputObj.css({ "border": "1px solid #c1c1c1" });
            opt.btnObj.data("isdisabled", false);
            opt.tipObj.html(currLength + "/" + opt.max);
        }
    };

    //展开收缩
    utils.iswitch = function (parentBox, box, icobox) {
        $(document).on("click", parentBox + " " + icobox, function () {
            if ($(this).data("isShow")) {
                $(this).data("isShow", 0);
                $(this).html($(this).html().replace("展开", "收起"));
                $(this).closest(parentBox).find(box).nextAll().slideDown(function () {
                    $(this).closest(parentBox).removeClass('product-block-close');
                });
            } else {
                $(this).data("isShow", 1);
                $(this).html($(this).html().replace("收起", "展开"));
                $(this).closest(parentBox).find(box).nextAll().slideUp(function () {
                    $(this).closest(parentBox).addClass('product-block-close');
                });
            }
        });
    };

    //获取当前客户端时间
    utils.getCurrTime = function (type) {
        var currTime = new Date();
        var year = currTime.getFullYear(),
            month = currTime.getMonth(),
            day = currTime.getDate(),
            hour = currTime.getHours(),
            minute = currTime.getMinutes(),
            sencond = currTime.getSeconds(),
            timeStr = "";

        if (type) {
            timeStr = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + sencond;
        } else {
            timeStr = year + "-" + month + "-" + day;
        }
        return timeStr;
    };

    //时间Format
    Date.prototype.Format = function (fmt) { //author: meizz 
        var o = {
            "M+": this.getMonth() + 1, //月份 
            "d+": this.getDate(), //日 
            "h+": this.getHours(), //小时 
            "m+": this.getMinutes(), //分 
            "s+": this.getSeconds(), //秒 
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
            "S": this.getMilliseconds() //毫秒 
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    //字符串Format
    String.prototype.format = function () {
        var args = arguments;
        return this.replace(/\{(\d+)\}/g,
            function (m, i) {
                return args[i];
            });
    };

    String.prototype.replaceAll = function (s1, s2) {
        var r = new RegExp(s1.replace(/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g, "\\$1"), "ig");
        return this.replace(r, s2);
    };

    //封装绑定事件
    utils.on = function (options) {
        var opt = $.extend(true, {
            context: document,
            selector: '',
            event: ''
        }, options || {});

        $(opt.context).delegate(opt.selector, opt.event, function () {
            var element = $(this);
            if (element.hasClass("btn-disabled")) {
                return false;
            }
            if (opt.fn) {
                opt.fn(element);
            }
        });
    };

    //滚动加载
    utils.scroll = function (options, callback) {
        var _opt = $.extend({
            el: null,
            url: '',
            data: {},
            dataType: 'json',
            page: 1,
            pagesize: 10,
            loadingImg: '',
            loadingText: '正在加载中,请稍后...',
            open: true,
            doneText: '没有更多了...',
            error: function () {
            }
        }, options || {});

        //对象
        var _this = $(_opt.el);

        //合并对象
        _opt.data = $.extend({ page: _opt.page, pagesize: _opt.pagesize }, _opt.data || {});

        //内置对象
        _opt.loading = $('<div class="scroll-tips" style="text-align: center;padding:15px;">' + _opt.loadingText + '</div>');
        if (_opt.open) {
            _opt.done = $('<div class="scroll-tips" style="text-align: center;padding:15px;">' + _opt.doneText + '</div>');
        }
        _opt.on = true;

        _opt.doing = function () {
            $.ajax({
                url: _opt.url,
                type: 'post',
                data: _opt.data,
                dataType: _opt.dataType,
                success: function (json) {
                    if (json &&
                        json.data &&
                        json.data.items) {

                        if (callback) {
                            callback(json, { page: _opt.data.page });
                        }

                        if (json.data.items.length > 0) {
                            //递增+1
                            ++_opt.data.page;
                        } else {
                            if (_opt.open) {
                                //没有更多了..
                                _opt.done.appendTo(_this);

                                setTimeout(function () {
                                    _opt.done.remove();
                                },3000);
                            }
                        }
                    } else {
                        if (_opt.open) {
                            //没有更多了..
                            _opt.done.appendTo(_this);
                        }
                    }
                },
                error: function () {
                    if (_opt.error) {
                        _opt.error();
                    }
                },
                beforeSend: function () {
                    if (_opt.open) {
                        _opt.done.remove();
                    }
                    _opt.loading.appendTo(_this);
                },
                complete: function () {
                    _opt.on = true;
                    _opt.loading.remove();
                }
            });
        };

        if (_opt.el) {
            $(_opt.el).off().scroll(function () {
                //可见高度
                var _view = _this.height();
                //包含不可见高度
                var _content = _this.get(0).scrollHeight;
                //滚动高度
                var _scrollTop = _this.scrollTop();

                if (_content - _view - _scrollTop <= 50) {
                    if (_opt.on) {
                        _opt.on = false;
                        _opt.doing();
                    }
                }
            });

            _opt.doing();
        }
    };

    //table RowSort
    utils.tableSort = function (selector, callback) {
        selector = selector || "table";
        var table = $(selector).eq(0);

        var tbody = table.find("tbody");
        var rowsClass = "tbody tr";
        var rows = tbody.children();
        var selectedRow;
        var pop;
        var fnReflashSortNum = function () {
            $("#lotteryList").find("tbody tr td:first-child").each(function (i, e) {
                $(this).text(i + 1);
            });
        };
        var mousedownindex = 0;
        var createPop = function () {
            var pop = $(".pop-wall-lottery-table");
            if (!pop.length) {
                pop = $("<div><table class=\"table table-striped\"></table></div>").addClass("pop pop-wall-lottery-table").appendTo("body");
            }
            pop.css("display", "block").find("tr").remove();
            return pop;
        }
        var popPosition = function () {
            pop.css({ "position": "absolute", "top": e.clientY + 10, "left": e.clientX - 40 });
        }
        var selectedRowHide = function () {
            $(selectedRow).addClass("tr-hide");
            $(selectedRow).after("<tr class=\"tr-clone\"><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
            mousedownindex = $(selectedRow).closest("tbody").find(">tr").index($(selectedRow));
        }

        var moveShadowTr = function (e) {
            var intr = $(e.target).parents("tr");

            if (!intr.hasClass("tr-clone")) {
                if ($(e.target).parents("tr").eq(0).nextAll(".tr-clone").length) {
                    $(e.target).parents("tr").eq(0).before(table.find(".tr-clone"));
                } else {
                    $(e.target).parents("tr").eq(0).after(table.find(".tr-clone"));
                }
            }

            //$(e.target).after($(selectedRow));
        }


        //压下鼠标时选取行 
        table.on("mousedown", rowsClass, function (e) {
            if ($(e.target).hasClass("link")) {
                return false;
            }
            if (!$(this).siblings("tr").length) {
                return false;
            }
            if ($(this).hasClass("tr-clone")) {
                return false;
            }

            selectedRow = this;
            rows = table.find("tbody tr");
            tbody.css('cursor', 'move');
            pop = createPop();
            //pop.find("table").append($(this).clone());
            selectedRowHide();

            pop.css("width", $(this).parents("table").eq(0).width());
            pop.find("table").append($(this));
            table.find("thead th").each(function (i, e) {
                $(".pop-wall-lottery-table").find("td").eq(i).css("width", $(this).outerWidth());
            });


            var left = table.offset().left;
            //pop.css({ "position": "fixed", "top": e.clientY + 30, "left": e.clientX - 40 });
            pop.css({ "position": "fixed", "top": e.clientY + 10, "left": left });
            return false; //防止拖动时选取文本内容，必须和 mousemove 一起使用 
        });
        table.on("mousemove", rowsClass, function (e) {
            if (selectedRow) {
                var left = table.offset().left;
                //pop.css({ "position": "fixed", "top": e.clientY + 30, "left": e.clientX - 40 });
                pop.css({ "position": "fixed", "top": e.clientY + 10, "left": left });
                moveShadowTr(e);
            }
            return false; //防止拖动时选取文本内容，必须和 mousedown 一起使用 
        });
        //释放鼠标键时进行插入 
        //var callback = callback || function() {};
        table.on("mouseup", rowsClass, function (e) {
            if (selectedRow) {
                $(selectedRow).find("td").attr("style", "");
                if (selectedRow != this) {
                    var isPosition = rows.index($(this)) - rows.index($(selectedRow));
                    if (isPosition > 0) {
                        $(this).after($(selectedRow)).removeClass('mouseover'); //插入   
                    } else {
                        $(this).before($(selectedRow)).removeClass('mouseover'); //插入   
                    }

                    table.find(".tr-clone").remove();
                    table.find(".tr-hide").removeClass("tr-hide");
                    fnReflashSortNum();

                    var nowindex = $(selectedRow).closest("tbody").find(">tr").index($(selectedRow));
                    if (nowindex != mousedownindex) {
                        callback();
                    }
                } else {
                    table.find(".tr-clone").remove();
                    table.find(".tr-hide").removeClass("tr-hide");
                }
                tbody.css('cursor', 'default');
                selectedRow = null;
                pop.css("display", "none");
            }
        });
        //标示当前鼠标所在位置 
        table.on("mouseenter mouseleave", rowsClass, function (e) {
            if (selectedRow && selectedRow != this) {
                $(this).toggleClass('mouseover', e.type === "mouseenter");
            }
        });

        //当用户压着鼠标键移出 tbody 时，清除 cursor 的拖动形状，以前当前选取的 selectedRow             
        tbody.on("mouseover", function (event) {
            event.stopPropagation(); //禁止 tbody 的事件传播到外层的 div 中 
        });

        $('#contain').mouseover(function (event) {

            if ($(event.relatedTarget).parents('#content')) //event.relatedTarget: 获取该事件发生前鼠标所在位置处的元素 
            {
                tbody.css('cursor', 'default');
                selectedRow = null;
            }
        });
    }


    //低版本placeholder
    $.fn.extend({
        placeholder: function () {
            if ("placeholder" in document.createElement("input")) {
                return this; //如果原生支持placeholder属性，则返回对象本身
            } else {
                return this.each(function () {
                    var _this = $(this);

                    if (_this.attr("type") == "password") {
                        _this.parent().css({ "position": "relative" });
                        _this.parent().append('<label class="lab-tip txt-muted">' + _this.attr("placeholder") + '</label>');

                        var _thisH = parseInt(_this.outerHeight());
                        var _tipH = parseInt($(".lab-tip").outerHeight());
                        var _tipT = (_thisH - _tipH) / 2;
                        _this.parent().find(".lab-tip").css({
                            "position": "absolute",
                            "cursor": "text",
                            "top": _tipT + "px",
                            "left": _tipT + 2 + "px"
                        });
                        _this.parent().find(".lab-tip").on("click", function () {
                            $(this).hide();
                            _this.focus();
                        });

                        _this.on("focus", function () {
                            _this.parent().find(".lab-tip").hide();
                            if (_this.val() === _this.attr("placeholder")) {
                                _this.val("");
                            }
                        }).on("blur", function () {
                            if (_this.val().length === 0) {
                                _this.val(_this.attr("placeholder"));
                                _this.parent().find(".lab-tip").show();
                                _this.val("");
                            } else {
                                _this.parent().find(".lab-tip").hide();
                            }
                        });
                    } else {
                        _this.addClass("txt-muted");
                        _this.val(_this.attr("placeholder")).on("focus", function () {
                            if (_this.val() === _this.attr("placeholder")) {
                                _this.val("");
                            }
                        }).on("blur", function () {
                            if (_this.val().length === 0) {
                                _this.val(_this.attr("placeholder"));
                                _this.addClass("txt-muted");
                            } else {
                                _this.removeClass("txt-muted");
                            }
                        });
                    }
                });
            }
        }
    });

    //随机取出数组中的某一个或几个
    utils.randomArr = function (arr, num) {
        var that = this;
        //新建一个数组,将传入的数组复制过来,用于运算,而不要直接操作传入的数组;
        var temp_array = new Array();
        for (var index in arr) {
            temp_array.push(arr[index]);
        }

        //取出的数值项,保存在此数组
        var return_array = new Array();

        for (var i = 0; i < num; i++) {
            //判断如果数组还有可以取出的元素,以防下标越界
            if (temp_array.length > 0) {
                //在数组中产生一个随机索引
                var arrIndex = Math.floor(Math.random() * temp_array.length);
                //将此随机索引的对应的数组元素值复制出来
                return_array[i] = temp_array[arrIndex];

                //然后删掉此索引的数组元素,这时候temp_array变为新的数组
                temp_array.splice(arrIndex, 1);
            } else {
                //数组中数据项取完后,退出循环,比如数组本来只有10项,但要求取出20项.
                break;
            }
        }
        return return_array;
    };

    //浏览器版本
    utils.browser = (function () {
        var Browser = {};
        try {
            (function () {
                var ua = navigator.userAgent.toLowerCase();
                //alert(ua);

                check = function (r) {
                    return r.test(ua);
                }
                var DOC = document;
                Browser.isStrict = DOC.compatMode == "CSS1Compat";
                Browser.isOpera = check(/opera/);
                Browser.isWebKit = !Browser.isIE && check(/webkit/);
                Browser.isIE = !Browser.isOpera && check(/msie/);
                Browser.isIE10 = Browser.isIE && check(/msie 10/);
                Browser.isGecko = !Browser.isSafari && check(/gecko/);
                Browser.isGecko2 = Browser.isGecko && check(/rv:1\.8/);
                Browser.isGecko3 = Browser.isGecko && check(/rv:1\.9/);
                Browser.isBorderBox = Browser.isIE && !Browser.isStrict;
                Browser.isWindows = check(/windows|win32/);
                Browser.isMac = check(/macintosh|mac os x/);
                Browser.isAir = check(/adobeair/);
                Browser.isLinux = check(/linux/);
                Browser.isIpad = check(/ipad/);
                Browser.isIpadFull = false;
                Browser.isIphone = check(/iphone/);
                Browser.isAndroid = check(/android/);
                Browser.isSecure = /^https/i.test(window.location.protocol);

                if (Browser.isAndroid || Browser.isIphone) {
                    Browser.isMobile = true;
                }
                if (Browser.isAndroid || Browser.isIphone || Browser.isIpad) {
                    Browser.isTouchFlat = true;
                }
            })();
        } catch (e) { }

        return Browser;
    })();

    return utils;
});