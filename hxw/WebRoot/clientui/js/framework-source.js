/**
 * version 2.03
 */
var parentTopHeight;
var parentBottomHeight;
var parentTopHeight_left;
var parentBottomHeight_left;
var fixHeight;
var skinName;
var themeColor = "white";
var broswerFlag;
var fontSize = 12;
var prePath = "../clientui/";
var exitVtab = 0;
var vtabIdx = 0;
var hasIframe = 0;
$(function () {
    if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
        var d = window.navigator.userAgent.substring(30, 33);
        if (d == "6.0") {
            broswerFlag = "IE6";
        } else {
            if (d == "7.0") {
                broswerFlag = "IE7";
            } else {
                if (d == "8.0") {
                    broswerFlag = "IE8";
                } else {
                    if (d == "9.0") {
                        broswerFlag = "IE9";
                    }
                }
            }
        }
    } else {
        if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
            broswerFlag = "Firefox";
        } else {
            if (window.navigator.userAgent.indexOf("Opera") >= 0) {
                broswerFlag = "Opera";
            } else {
                if (window.navigator.userAgent.indexOf("Safari") >= 1) {
                    broswerFlag = "Safari";
                } else {
                    broswerFlag = "Other";
                }
            }
        }
    }
    var l;
    if ($("#skin").attr("prePath") != null) {
        prePath = $("#skin").attr("prePath");
    }
    if (broswerFlag == "IE6" || broswerFlag == "IE7") {
        if ($(window.top.document.getElementById("skin")).attr("href") == "") {
            l = "skins/sky/import_skin.css";
        } else {
            l = $(window.top.document.getElementById("skin")).attr("href");
        }
    } else {
        if ($(window.top.document.getElementById("skin")).attr("href") == null) {
            l = "skins/sky/import_skin.css";
        } else {
            l = $(window.top.document.getElementById("skin")).attr("href");
        }
    }
    if ($(window.top.document.getElementById("skin")).attr("themeColor") != null) {
        themeColor = $(window.top.document.getElementById("skin")).attr("themeColor");
    }
    var f = l.split("/");
    var c = getPosition("skins", f) + 1;
    skinName = f[c];
    if (broswerFlag == "IE6" || broswerFlag == "IE7") {
        if ($(window.top.document.getElementById("skin")).attr("href") == "") {} else {
            $.ajax({
                url: prePath + "skins/" + skinName + "/import_skin.css",
                error: function () {
                    alert("无法通过路径：" + prePath + "skins/" + skinName + "/import_skin.css加载CSS，请检查prePath设置的是否正确。详情请参照“使用帮助>>内页结构及注意事项”");
                }
            });
        }
    } else {
        if ($(window.top.document.getElementById("skin")).attr("href") == null) {} else {
            $.ajax({
                url: prePath + "skins/" + skinName + "/import_skin.css",
                error: function () {
                    alert("无法通过路径：" + prePath + "skins/" + skinName + "/import_skin.css加载CSS，请检查prePath设置的是否正确。详情请参照“使用帮助>>内页结构及注意事项”");
                }
            })
        }
    }
    $("#skin").attr("href", prePath + "skins/" + skinName + "/import_skin.css");
    try {
        var m = jQuery.jCookie("fontSize");
        if (m != false) {
            fontSize = parseInt(m);
        }
    } catch (q) {}
    if (fontSize != 12) {
        $("body").css({
            fontSize: fontSize + "px"
        });
        if ($("table:[class=tableStyle]").length > 0) {
            $("table:[class=tableStyle]").css({
                fontSize: fontSize + "px"
            });
        }
        if ($("pre").length > 0) {
            $("pre").css({
                fontSize: fontSize + "px"
            });
        }
    }
    if ($(".box1").length > 0) {
        $(".box1").each(function () {
            var e = $(this).html();
            $(this).html("");
            if ($(this).attr("whiteBg") == "true") {
                $("<div class='box1_topcenter2'><div class='box1_topleft2'><div class='box1_topright2'></div></div></div>").appendTo($(this));
                $("<div class='box1_middlecenter'><div class='box1_middleleft2'><div class='box1_middleright2'><div class='boxContent'></div></div></div></div>").appendTo($(this));
                $("<div class='box1_bottomcenter2'><div class='box1_bottomleft2'><div class='box1_bottomright2'></div></div></div>").appendTo($(this))
            } else {
                $("<div class='box1_topcenter'><div class='box1_topleft'><div class='box1_topright'></div></div></div>").appendTo($(this));
                $("<div class='box1_middlecenter'><div class='box1_middleleft'><div class='box1_middleright'><div class='boxContent'></div></div></div></div>").appendTo($(this));
                $("<div class='box1_bottomcenter'><div class='box1_bottomleft'><div class='box1_bottomright'></div></div></div>").appendTo($(this))
            }
            if ($(this).attr("panelWidth") != null) {
                var y = $(this).attr("panelWidth");
                var x = y.substr(y.length - 1, 1);
                if (x == "%") {
                    $(this).width(y)
                } else {
                    var z = Number($(this).attr("panelWidth"));
                    $(this).width(z)
                }
            }
            if ($(this).attr("panelHeight") != null) {
                $(this).find(".box1_topcenter").height(20);
                $(this).find(".box1_bottomcenter").height(22);
                var w = Number($(this).attr("panelHeight")) - $(this).find(".box1_topcenter").outerHeight() - $(this).find(".box1_bottomcenter").outerHeight();
                $(this).find(".boxContent").height(w)
            }
            $(this).find(".boxContent").html(e);
            if ($(this).attr("overflow") != null) {
                $(this).find(".boxContent").css({
                    overflow: $(this).attr("overflow")
                })
            }
        })
    }
    if ($(".box2").length > 0) {
        $(".box2").each(function () {
            var y = $(this).html();
            $(this).html("");
            $("<div class='box2_topcenter'><div class='box2_topleft'><div class='box2_topright'><div class='title'></div><div class='status'><span class='ss'><a></a></span></div><div class='clear'></div></div></div></div>").appendTo($(this));
            $("<div class='box2_middlecenter'><div class='box2_middleleft'><div class='box2_middleright'><div class='boxContent'></div></div></div></div>").appendTo($(this));
            var D = $("<div class='box2_bottomcenter' id='box2_bottomcenter'><div class='box2_bottomleft'><div class='box2_bottomright'></div></div></div>");
            var C = $("<div class='box2_bottomcenter2' id='box2_bottomcenter'><div class='box2_bottomleft2'><div class='box2_bottomright2'></div></div></div>");
            if ($(this).attr("roller") == "false") {
                D.appendTo($(this))
            } else {
                C.appendTo($(this))
            }
            if ($(this).attr("panelTitle") != null) {
                $(this).find(".title").append($(this).attr("panelTitle"))
            }
            if ($(this).attr("panelWidth") != null) {
                var w = $(this).attr("panelWidth");
                var F = w.substr(w.length - 1, 1);
                if (F == "%") {
                    $(this).width(w)
                } else {
                    var e = Number($(this).attr("panelWidth"));
                    $(this).width(e)
                }
            }
            if ($(this).attr("panelHeight") != null) {
                var G = Number($(this).attr("panelHeight")) - $(this).find(".box2_topcenter").outerHeight() - $(this).find("#box2_bottomcenter").outerHeight();
                $(this).find(".boxContent").height(G)
            }
            $(this).find(".boxContent").html(y);
            if ($(this).attr("overflow") != null) {
                $(this).find(".boxContent").css({
                    overflow: $(this).attr("overflow")
                })
            }
            var z = "true";
            if ($(this).attr("showStatus") != null) {
                z = $(this).attr("showStatus")
            }
            var E = "#";
            if ($(this).attr("panelUrl") != null) {
                E = $(this).attr("panelUrl")
            }
            var B = "_self";
            if ($(this).attr("panelTarget") != null) {
                B = $(this).attr("panelTarget")
            }
            var x = "收缩";
            if ($(this).attr("statusText") != null) {
                x = $(this).attr("statusText")
            }
            var H;
            if (x == "收缩" && z == "true") {
                $(this).find(".ss").text(x);
                $(this).find(".ss").toggle(function () {
                    var I = $(this).parents(".box2").find(".boxContent");
                    H = I.height();
                    if (broswerFlag == "IE6") {
                        I.fadeOut(300, resetHeight)
                    } else {
                        I.hide(300, resetHeight)
                    }
                    $(this).text("展开")
                }, function () {
                    var I = $(this).parents(".box2").find(".boxContent");
                    I.height(H);
                    if (broswerFlag == "IE6") {
                        I.fadeIn(300, resetHeight)
                    } else {
                        I.show(300, resetHeight)
                    }
                    if ($(this).parents(".box2").attr("panelHeight") == null) {
                        setTimeout(function () {
                            I.css({
                                height: "auto"
                            })
                        }, 500)
                    }
                    $(this).text("收缩")
                })
            } else {
                if (x == "展开" && z == "true") {
                    $(this).find(".ss").text(x);
                    var A = $(this).find(".boxContent");
                    H = A.height();
                    A.hide();
                    $(this).find(".ss").toggle(function () {
                        var I = $(this).parents(".box2").find(".boxContent");
                        I.height(H);
                        if (broswerFlag == "IE6") {
                            I.fadeIn(300, resetHeight)
                        } else {
                            I.show(300, resetHeight)
                        }
                        if ($(this).parents(".box2").attr("panelHeight") == null) {
                            setTimeout(function () {
                                I.css({
                                    height: "auto"
                                })
                            }, 500)
                        }
                        $(this).text("收缩")
                    }, function () {
                        if (broswerFlag == "IE6") {
                            A.fadeOut(300, resetHeight)
                        } else {
                            A.hide(300, resetHeight)
                        }
                        $(this).text("展开")
                    })
                } else {
                    if (z == "true" || $(this).attr("statusText") != null) {
                        $(this).find(".ss").find("a").attr("href", E);
                        $(this).find(".ss").find("a").attr("target", B);
                        $(this).find(".ss").find("a").text(x)
                    } else {
                        $(this).find(".ss").hide()
                    }
                }
            }
        })
    }
    if ($(".box3").length > 0) {
        $(".box3").each(function () {
            var y = $(this).html();
            $(this).html("");
            $("<div class='box3_topcenter'><div class='box3_topleft'><div class='box3_topright'><div class='title'></div><div class='status'><span class='ss'><a></a></span></div><div class='clear'></div></div></div></div>").appendTo($(this));
            $("<div class='box3_middlecenter'><div class='box3_middleleft'><div class='box3_middleright'><div class='boxContent'></div></div></div></div>").appendTo($(this));
            var B = $("<div class='box3_bottomcenter'><div class='box3_bottomleft'><div class='box3_bottomright'></div></div></div>");
            B.appendTo($(this));
            if ($(this).attr("panelTitle") != null) {
                $(this).find(".title").append($(this).attr("panelTitle"))
            }
            if ($(this).attr("panelWidth") != null) {
                var w = $(this).attr("panelWidth");
                var D = w.substr(w.length - 1, 1);
                if (D == "%") {
                    $(this).width(w);
                } else {
                    var e = Number($(this).attr("panelWidth"));
                    $(this).width(e);
                }
            }
            if ($(this).attr("panelHeight") != null) {
                $(this).find(".box3_topcenter").height(29);
                $(this).find(".box3_bottomcenter").height(2);
                var E = Number($(this).attr("panelHeight")) - $(this).find(".box3_topcenter").outerHeight() - $(this).find(".box3_bottomcenter").outerHeight();
                $(this).find(".boxContent").height(E);
            }
            $(this).find(".boxContent").html(y);
            if ($(this).attr("overflow") != null) {
                $(this).find(".boxContent").css({
                    overflow: $(this).attr("overflow")
                })
            }
            var z = "false";
            if ($(this).attr("showStatus") != null) {
                z = $(this).attr("showStatus");
            }
            var C = "#";
            if ($(this).attr("panelUrl") != null) {
                C = $(this).attr("panelUrl");
            }
            var A = "_self";
            if ($(this).attr("panelTarget") != null) {
                A = $(this).attr("panelTarget");
            }
            var x = "更多>>";
            if ($(this).attr("statusText") != null) {
                x = $(this).attr("statusText");
            }
            var F;
            if (x == "收缩") {
                $(this).find(".ss").text(x);
                $(this).find(".ss").toggle(function () {
                    var G = $(this).parents(".box3").find(".boxContent");
                    F = G.height();
                    G.hide(300, resetHeight);
                    if ($(this).parents(".box3").attr("panelHeight") == null) {
                        setTimeout(function () {
                            G.css({
                                height: "auto"
                            })
                        }, 500)
                    }
                    $(this).text("展开")
                }, function () {
                    var G = $(this).parents(".box3").find(".boxContent");
                    G.height(F);
                    G.show(300, resetHeight);
                    $(this).text("收缩")
                })
            } else {
                if (z == "true" || $(this).attr("statusText") != null) {
                    $(this).find(".ss").find("a").attr("href", C);
                    $(this).find(".ss").find("a").attr("target", A);
                    $(this).find(".ss").find("a").text(x)
                } else {
                    $(this).find(".ss").hide()
                }
            }
        })
    }
    if ($(".box4").length > 0) {
        $(".box4").each(function () {
            var e = $(this).html();
            $(this).html("");
            if ($(this).attr("noTitle") == "true") {
                $("<div class='box4_topcenter2'><div class='box4_topleft2'><div class='box4_topright2'></div></div></div>").appendTo($(this))
            } else {
                $("<div class='box4_topcenter'><div class='box4_topleft'><div class='box4_topright'><div class='title'></div></div></div></div>").appendTo($(this))
            }
            $("<div class='box4_middlecenter'><div class='box4_middleleft'><div class='box4_middleright'><div class='boxContent'></div></div></div></div>").appendTo($(this));
            $("<div class='box4_bottomcenter'><div class='box4_bottomleft'><div class='box4_bottomright'></div></div></div>").appendTo($(this));
            if ($(this).attr("panelTitle") != null) {
                $(this).find(".title").append($(this).attr("panelTitle"))
            }
            if ($(this).attr("panelWidth") != null) {
                var y = $(this).attr("panelWidth");
                var x = y.substr(y.length - 1, 1);
                if (x == "%") {
                    $(this).width(y)
                } else {
                    var z = Number($(this).attr("panelWidth"));
                    $(this).width(z)
                }
            }
            if ($(this).attr("panelHeight") != null) {
                $(this).find(".box4_topcenter").height(27);
                $(this).find(".box4_bottomcenter").height(5);
                var w = Number($(this).attr("panelHeight")) - $(this).find(".box4_topcenter").outerHeight() - $(this).find(".box4_bottomcenter").outerHeight();
                $(this).find(".boxContent").height(w)
            }
            $(this).find(".boxContent").html(e);
            if ($(this).attr("overflow") != null) {
                $(this).find(".boxContent").css({
                    overflow: $(this).attr("overflow")
                })
            }
        })
    }
    if ($("#vtabConIn").length > 0) {
        exitVtab = 1;
        try {
            var j = jQuery.jCookie("vtabIndex");
            if (j != false) {
                vtabIdx = parseInt(j)
            }
            $(".list_menu2").not(":eq(" + vtabIdx + ")").hide();
            $(".vtab >div").eq(vtabIdx).addClass("vtab_cur");
            $(".vtab >div").each(function (e) {
                $(this).click(function () {
                    $(".vtab >div").removeClass("vtab_cur");
                    $(this).addClass("vtab_cur");
                    jQuery.jCookie("vtabIndex", e.toString());
                    $(".list_menu2").hide();
                    $(".list_menu2").eq(e).slideDown(600, function () {
                        $(".list_menu2").not(":eq(" + e + ")").hide()
                    })
                })
            })
        } catch (q) {}
    }
    if ($(".list_menu2").length > 0) {
        try {
            $(".list_menu2").each(function () {
                if ($(this).attr("showAll") != "true") {
                    $(this).find(".child").hide();
                    $(this).find(".parent").each(function () {
                        $(this).find("a").eq(0).click(function () {
                            $(this).parents(".list_menu2").find(".child").hide();
                            if (broswerFlag == "IE6" || broswerFlag == "IE7") {
                                $(this).parent().find("ul").slideDown()
                            } else {
                                $(this).parent().next("ul").slideDown()
                            }
                        })
                    })
                }
                $(this).find("dt").find("a").click(function () {
                    $(this).parents(".list_menu2").find("dt").find("a").removeClass("current");
                    $(this).addClass("current")
                })
            })
        } catch (q) {}
    }
    if ($(".list_menu3").length > 0) {
        $("#scrollContent").css({
            position: "static"
        });
        try {
            $(".list_menu3 >div span").each(function () {
                $(this).click(function () {
                    $(".list_menu3 >div").removeClass("current");
                    $(this).parent("div").addClass("current")
                });
                $(this).hover(function () {
                    $(this).animate({
                        paddingLeft: "40px"
                    }, "fast")
                }, function () {
                    $(this).animate({
                        paddingLeft: "20px"
                    })
                })
            })
        } catch (q) {}
    }
    if ($(".list_menu3_min").length > 0) {
        $("#scrollContent").css({
            position: "static"
        });
        try {
            $(".list_menu3_min >div span").each(function () {
                $(this).click(function () {
                    $(".list_menu3_min >div").removeClass("current");
                    $(this).parent("div").addClass("current")
                });
                $(this).hover(function () {
                    $(this).animate({
                        paddingLeft: "30px"
                    }, "fast")
                }, function () {
                    $(this).animate({
                        paddingLeft: "10px"
                    })
                })
            })
        } catch (q) {}
    }
    /*
    if ($(".date").length > 0) {
        //var h = document.createElement("script");
        //h.type = "text/javascript";
        //h.src = prePath + "js/form/datePicker/WdatePicker.js";
        //document.body.appendChild(h);
    	var wjs = prePath + "js/form/datePicker/WdatePicker.js";
    	alert(wjs);
        jQuery.getScript(wjs, function(){
            $(".date").each(function () {
                var e = "yyyy-MM-dd";
                if ($(this).attr("dateFmt") != null) {
                    e = $(this).attr("dateFmt");
                }
                $(this).focus(function () {
                    WdatePicker({
                        skin: themeColor,
                        isShowClear: true,
                        dateFmt: e,
                        onpicked: function (w) {
                            $(this).blur();
                        }
                    });
                });
            });
        });
        
    }
    */
    $("input:file[class='']").addClass("file");
    $("input:file[class='file']").rebrushfileupload();
    var i;
    $("input:text[class=''],input:password[class=''],input:text[class*=validate],input:password[class*=validate]").each(function () {
        $(this).addClass("textinput");
        $(this).hover(function () {
            if (i != $(this)[0]) {
                $(this).removeClass("textinput");
                $(this).addClass("textinput_hover")
            }
        }, function () {
            if (i != $(this)[0]) {
                $(this).removeClass("textinput_hover");
                $(this).addClass("textinput")
            }
        });
        $(this).focus(function () {
            i = $(this)[0];
            $(this).removeClass("textinput");
            $(this).removeClass("textinput_hover");
            $(this).addClass("textinput_click")
        });
        $(this).blur(function () {
            i = null;
            $(this).removeClass("textinput_click");
            $(this).addClass("textinput")
        });
        if ($(this).attr("clearable") == "true") {
            $(this).clearableTextField()
        }
        if ($(this).attr("maxNum") != null) {
            $(this).maxlength()
        }
        if ($(this).attr("checkStrength") == "true") {
            $(this).password_strength()
        }
        if ($(this).attr("watermark") != null) {
            $(this).watermark("watermark", $(this).attr("watermark"))
        }
    });
    $("input:password[class='textinput'],input:password[class*=validate]").each(function () {
        $(this).caps(function (e) {
            if (jQuery.browser.safari) {
                return
            }
            if (e) {
                $.cursorMessage("注意：大写键开启了")
            } else {}
        })
    });
    /*
    $("input:text[class='date'],input:text[class='cusDate'],input:text[class='keypad'],input:text[class='color']").each(function () {
        $(this).hover(function () {
            if (i != $(this)[0]) {
                $(this).addClass("date_hover")
            }
        }, function () {
            if (i != $(this)[0]) {
                $(this).removeClass("date_hover")
            }
        });
        $(this).focus(function () {
            i = $(this)[0];
            $(this).removeClass("date_hover");
            $(this).addClass("date_click")
        });
        $(this).blur(function () {
            i = null;
            $(this).removeClass("date_click")
        })
    });
    */
    $("textarea").each(function () {
        if ($(this).attr("class") == "") {
            $(this).addClass("textarea")
        }
        if ($(this).attr("maxNum") != null) {
            $(this).maxlength({
                maxCharacters: parseInt($(this).attr("maxNum"))
            })
        }
        if ($(this).attr("resize") == "true") {
            $(this).TextAreaResizer()
        }
        if ($(this).attr("autoHeight") == "true") {
            $(this).css({
                height: "auto"
            });
            $(this).attr("rows", 5);
            $(this).autoGrow()
        }
        if ($(this).attr("watermark") != null) {
            $(this).watermark("watermark", $(this).attr("watermark"))
        }
    });
    $("textarea[class='textarea'],textarea[class*='textarea'],textarea[class*=validate]").each(function () {
        $(this).hover(function () {
            if (i != $(this)[0]) {
                $(this).removeClass("textarea");
                $(this).addClass("textarea_hover")
            }
        }, function () {
            if (i != $(this)[0]) {
                $(this).removeClass("textarea_hover");
                $(this).addClass("textarea")
            }
        });
        $(this).focus(function () {
            i = $(this)[0];
            $(this).removeClass("textarea");
            $(this).removeClass("textarea_hover");
            $(this).addClass("textarea_click")
        });
        $(this).blur(function () {
            i = null;
            $(this).removeClass("textarea_click");
            $(this).addClass("textarea")
        })
    });
    $("button").each(function () {
        if ($(this).attr("class") == "") {
            $(this).addClass("button");
            var w = _getStrLength($(this).text());
            if (w < 5) {
                $(this).width(60)
            }
            var e = 0;
            var x = 50;
            e = _getStrLength($(this).filter(":has(span)").find("span").text());
            if (e != 0) {
                x = 20 + 7 * e + 10
            }
            if (broswerFlag == "Firefox" || broswerFlag == "Opera" || broswerFlag == "Safari") {
                $(this).filter(":has(span)").css({
                    paddingLeft: "5px",
                    width: x + 8 + "px"
                })
            } else {
                $(this).filter(":has(span)").css({
                    paddingLeft: "5px",
                    width: x + "px"
                })
            }
            $(this).filter(":has(span)").find("span").css({
                cursor: "default"
            })
        }
    });
    $("input:button[class=''],input:submit[class=''],input:reset[class='']").each(function () {
        $(this).addClass("button");
        var e = _getStrLength($(this).val());
        if (e < 5) {
            $(this).width(60)
        }
    });
    $("input:button[class='button'],input:submit[class='button'],input:reset[class='button'],button[class='button']").each(function () {
        $(this).hover(function () {
            if (i != $(this)[0]) {
                $(this).removeClass("button");
                $(this).addClass("button_hover")
            }
        }, function () {
            if (i != $(this)[0]) {
                $(this).removeClass("button_hover");
                $(this).addClass("button")
            }
        });
        $(this).focus(function () {
            $(this).removeClass("button");
            $(this).addClass("button_hover")
        });
        $(this).blur(function () {
            $(this).removeClass("button_hover");
            $(this).addClass("button")
        })
    });
    $(".render input:checkbox[class='']").custCheckBox();
    $(".render input:radio[class='']").custCheckBox();
    $("select").each(function () {
        if ($(this).attr("class") == "" && $(this).attr("multiple") == false) {
            $(this).selectbox()
        }
    });
    $("select[class*=validate]").not("[multiple]").selectbox();
    if ($(".img_light").length > 0) {
        $(".img_light").addClass("hand");
        $(".img_light").hover(function () {
            $(this).removeClass("img_light");
            $(this).addClass("img_lightOn")
        }, function () {
            $(this).addClass("img_light");
            $(this).removeClass("img_lightOn")
        })
    }
    enableTooltips();
    if ($(".cusTreeTable").length > 0) {
        $(".cusTreeTable").each(function () {
            $(this).find("tr").filter(":has(table)").hide();
            if ($(this).attr("trClick") == "true") {
                $(this).find("tr").eq(0).nextAll().not(":has(table)").each(function () {
                    $(this).addClass("hand");
                    $(this).hover(function () {
                        $(this).addClass("highlight")
                    }, function () {
                        $(this).removeClass("highlight")
                    });
                    $(this).click(function () {
                        if ($(this).next().css("display") == "none") {
                            $(this).next().show();
                            if ($(this).parents("table").attr("ohterClose") != "false") {
                                $(this).parents("table").find(".img_remove2").attr("title", "点击展开");
                                $(this).parents("table").find(".img_remove2").addClass("img_add2");
                                $(this).parents("table").find(".img_remove2").removeClass("img_remove2");
                                $(this).next().nextAll().filter(":has(table)").hide();
                                $(this).next().prevAll().filter(":has(table)").hide()
                            }
                            $(this).find(".img_add2").each(function () {
                                $(this).attr("title", "点击收缩");
                                $(this).removeClass("img_add2");
                                $(this).addClass("img_remove2")
                            })
                        } else {
                            $(this).next().hide();
                            $(this).find(".img_remove2").each(function () {
                                $(this).removeClass("img_remove2");
                                $(this).addClass("img_add2");
                                $(this).attr("title", "点击展开")
                            })
                        }
                        enableTooltips();
                        hideTooltip()
                    })
                })
            } else {
                $(this).find(".img_add2").click(function () {
                    if ($(this).parents("tr").next().css("display") == "none") {
                        $(this).parents("tr").next().show();
                        if ($(this).parents("table").attr("ohterClose") != "false") {
                            $(this).parents("table").find(".img_remove2").attr("title", "点击展开");
                            $(this).parents("table").find(".img_remove2").addClass("img_add2");
                            $(this).parents("table").find(".img_remove2").removeClass("img_remove2");
                            $(this).parents("tr").next().nextAll().filter(":has(table)").hide();
                            $(this).parents("tr").next().prevAll().filter(":has(table)").hide()
                        }
                        $(this).attr("title", "点击收缩");
                        $(this).removeClass("img_add2");
                        $(this).addClass("img_remove2")
                    } else {
                        $(this).parents("tr").next().hide();
                        $(this).removeClass("img_remove2");
                        $(this).addClass("img_add2");
                        $(this).attr("title", "点击展开")
                    }
                    enableTooltips();
                    hideTooltip()
                })
            }
        })
    }
    if ($(".simpleTab").length > 0) {
        $(".simpleTab").each(function () {
            $(this).find(".simpleTab_con").not(":eq(0)").hide();
            $(this).find(".simpleTab_top li").each(function (e) {
                $(this).click(function () {
                    $(this).parent().find("li").removeClass("current");
                    $(this).addClass("current");
                    if ($(this).parents(".simpleTab").attr("iframeMode") != "true") {
                        $(this).parents(".simpleTab").find(".simpleTab_con").hide();
                        $(this).parents(".simpleTab").find(".simpleTab_con").eq(e).fadeIn()
                    }
                })
            })
        })
    }
    if ($(".simpleMenu").length > 0) {
        refreshSimpleMenu()
    }
    if ($("#scrollContent").length > 0) {
        if (broswerFlag == "IE6") {
            $("#scrollContent").css({
                overflowX: "hidden",
                width: "100%"
            })
        } else {
            $("#scrollContent").css({
                overflowX: "hidden"
            })
        }
        $("body").addClass("trans_bg");
        parentTopHeight = $(window.parent.document.getElementById("hbox")).outerHeight() + $(window.parent.document.getElementById("rbox_topcenter")).outerHeight() + parseInt($(window.parent.document.getElementById("rbox")).css("paddingTop")) + parseInt($(window.parent.document.getElementById("rbox")).css("paddingBottom"));
        parentBottomHeight = $(window.parent.document.getElementById("fbox")).outerHeight() + $(window.parent.document.getElementById("rbox_bottomcenter")).outerHeight();
        parentTopHeight_left = $(window.parent.document.getElementById("hbox")).outerHeight() + $(window.parent.document.getElementById("lbox_topcenter")).outerHeight() + parseInt($(window.parent.document.getElementById("lbox")).css("paddingTop")) + parseInt($(window.parent.document.getElementById("lbox")).css("paddingBottom"));
        parentBottomHeight_left = $(window.parent.document.getElementById("fbox")).outerHeight() + $(window.parent.document.getElementById("lbox_bottomcenter")).outerHeight();
        if (parentTopHeight > 0) {
            if ($("body").attr("leftFrame") == "true") {
                $("body").addClass("contentStyleLeft")
            } else {
                $("body").addClass("contentStyle")
            }
            $("#scrollContent").css({
                overflowY: "auto"
            })
        }
        getFixHeight();
        scrollContent();
        var u = null;
        if (document.all) {} else {
            window.onload = function () {
                resetHeight()
            }
        }
        var g = 0;
        var v = 0;
        if ($("table:[class=tableStyle]", "#scrollContent").length > 0) {
            var b = 0;
            var k = $("table:[class=tableStyle]", "#scrollContent").eq(0);
            var p;
            if ($("table:[class=tableStyle]").length > 1) {
                p = $("table:[class=tableStyle]").eq(0);
                if (p.attr("headFixMode") == "true") {
                    b = 1;
                    k.css({
                        borderTop: 0
                    });
                    p.addClass("noBottomLine")
                }
            }
            if (k.height() > $("#scrollContent").height()) {
                if (broswerFlag == "IE6") {
                    g = 1
                } else {
                    if (broswerFlag == "IE7") {
                        v = 1
                    }
                }
                if (b == 1) {
                    if (broswerFlag != "IE6") {
                        var t = p.find("th").last();
                        var r = t.width();
                        t.width(r + 17)
                    }
                }
            }
            setTableStyle()
        } else {
            if ($(".flexiStyle", "#scrollContent").length > 0) {
                $("#scrollContent").css({
                    overflowY: "hidden",
                    overflowX: "hidden"
                });
                $(".contentStyle").css({
                    paddingRight: "8px"
                })
            }
        }
        if ($(".box1,.box2,.box3", "#scrollContent").length > 0) {
            $(".box1,.box2,.box3").each(function () {
                var e = $(this).attr("panelWidth");
                if (e == "100%" || e == null) {
                    if (broswerFlag == "IE6") {
                        g = 1
                    } else {
                        if (broswerFlag == "IE7") {
                            v = 1
                        }
                    }
                }
            })
        }
        if (g == 1) {}
        if (v == 1) {
            setTimeout(a, 100)
        }
        function n() {
            var w = $("body").css("paddingRight");
            var e = parseInt(w) + 17;
            $("body").css({
                paddingRight: e + "px"
            })
        }
        function a() {
            $("#scrollContent").css({
                paddingRight: "17px"
            })
        }
    } else {
        if ($("body").attr("rel") == "layout") {
            $("body").addClass("trans_bg");
            setTableStyle();
            parentTopHeight = $(window.parent.document.getElementById("hbox")).outerHeight() + $(window.parent.document.getElementById("rbox_topcenter")).outerHeight();
            parentBottomHeight = $(window.parent.document.getElementById("fbox")).outerHeight() + $(window.parent.document.getElementById("rbox_bottomcenter")).outerHeight() + 1;
            var o = window.parent.document.documentElement.clientHeight;
            try {
                window.top.document.getElementsByTagName("iframe")["frmright"].style.height = o - parentTopHeight - parentBottomHeight + "px"
            } catch (q) {}
        } else {
            setTableStyle();
            $("body").addClass("zDialogCon");
            if (broswerFlag == "IE6") {
                var s = $("body").width();
                $("body").width(s - 17)
            }
        }
    }
    closeProgress()
});

function refreshSimpleMenu() {
    $(".simpleMenu").hover(function () {
        if ($(this).find(".simpleMenu_link").attr("noBorder") != "true") {
            $(this).find(".simpleMenu_link").addClass("hoverBorder")
        }
        $(this).find(".simpleMenu_con").show()
    }, function () {
        $(this).find(".simpleMenu_link").removeClass("hoverBorder");
        $(this).find(".simpleMenu_con").hide()
    })
}
function getFixHeight() {
    fixHeight = 0;
    $("#scrollContent").parent().find(">*").not("div").not("#btc").hide();
    $("#scrollContent").parent().find(">div").not("#scrollContent").not(".searchMain").not(".jquery_rgbmultiselect_options_container").not("#cursorMessageDiv").not(".simplemenu").not(".iconmenu").not(".megamenu").not(".b-m-mpanel").each(function () {
        if ($(this).css("display") != "none") {
            fixHeight = fixHeight + $(this).outerHeight();
            if ($(this).css("marginBottom") != "auto") {
                fixHeight = fixHeight + parseInt($(this).css("marginBottom"))
            }
            if ($(this).css("marginTop") != "auto") {
                fixHeight = fixHeight + parseInt($(this).css("marginTop"))
            }
        }
    })
}
function scrollContent() {
    try {
        var b = window.top.document.documentElement.clientHeight;
        if (parentTopHeight > 0) {
            if ($("body").attr("leftFrame") == "true") {
                $("#scrollContent").height(b - parentTopHeight_left - parentBottomHeight_left - fixHeight)
            } else {
                $("#scrollContent").height(b - parentTopHeight - parentBottomHeight - fixHeight)
            }
            if ($(".flexiStyle").length > 0) {
                var a = b - parentTopHeight - parentBottomHeight - fixHeight - 45;
                $(".bDiv").height(a)
            }
        }
    } catch (c) {}
    if ($("body").attr("leftFrame") == "true") {
        try {
            window.top.document.getElementsByTagName("iframe")["frmleft"].style.height = b - parentTopHeight_left - parentBottomHeight_left + "px"
        } catch (c) {}
    } else {
        try {
            window.top.document.getElementsByTagName("iframe")["frmright"].style.height = b - parentTopHeight - parentBottomHeight + "px"
        } catch (c) {}
    }
    if (exitVtab == 1) {
        try {
            $("#vtabConIn").height(b - parentTopHeight_left - parentBottomHeight_left);
            $(".vtab").height(b - parentTopHeight_left - parentBottomHeight_left - 20)
        } catch (c) {}
    }
}
function resetHeight() {
    try {
        getFixHeight();
        scrollContent()
    } catch (a) {}
}
function changeFont(a) {
    $("body").css({
        fontSize: a + "px"
    });
    if ($("table:[class=tableStyle]").length > 0) {
        $("table:[class=tableStyle]").css({
            fontSize: a + "px"
        })
    }
    if ($("pre").length > 0) {
        $("pre").css({
            fontSize: a + "px"
        })
    }
    if ($("iframe").length > 0) {
        for (var b = 0; b < $("iframe").length; b++) {
            document.getElementsByTagName("iframe")[b].contentWindow.changeFont(a)
        }
    }
}(function (a) {
    a.fn.tableRenderer = function () {
        return this.each(function () {
            a(this).find("th").addClass("th");
            if (a(this).find("tr").eq(1).find("td").eq(0).find('input[type="checkbox"]').length == 1) {
                if (a(this).attr("useCheckBox") != "false") {
                    a(this).attr("useCheckBox", "true")
                }
                if (a(this).attr("useMultColor") != "false") {
                    a(this).attr("useMultColor", "true")
                }
            }
            if (a(this).find("tr").eq(1).find("td").eq(0).find('input[type="radio"]').length == 1) {
                if (a(this).attr("useRadio") != "false") {
                    a(this).attr("useRadio", "true")
                }
            }
            if (a(this).attr("formMode") == "true") {
                a(this).attr("useColor", "false");
                a(this).attr("useHover", "false");
                a(this).attr("useClick", "false");
                a(this).find("th").css({
                    fontWeight: "bold",
                    "text-align": "center"
                });
                a(this).find("tr").not("tr:last").find("td:even").css("text-align", "right");
                if (a(this).attr("footer") != null) {
                    if (a(this).attr("footer") == "left") {
                        a(this).find("tr:last").find("td").css("text-align", "left")
                    } else {
                        if (a(this).attr("footer") == "right") {
                            a(this).find("tr:last").find("td").css("text-align", "right")
                        } else {
                            if (a(this).attr("footer") == "center") {
                                a(this).find("tr:last").find("td").css("text-align", "center")
                            } else {
                                if (a(this).attr("footer") == "normal") {
                                    a(this).find("tr:last").find("td:even").css("text-align", "right")
                                }
                            }
                        }
                    }
                } else {
                    a(this).find("tr:last").find("td").css("text-align", "center")
                }
                a(this).find("td").css({
                    paddingTop: "3px",
                    paddingBottom: "3px"
                })
            }
            if (a(this).attr("transMode") == "true") {
                a(this).attr("useColor", "false");
                a(this).attr("useHover", "false");
                a(this).attr("useClick", "false");
                a(this).find("th").css({
                    fontWeight: "bold",
                    "text-align": "center"
                });
                a(this).css({
                    border: "none",
                    backgroundColor: "transparent"
                });
                a(this).find("tr").css({
                    border: "none",
                    backgroundColor: "transparent"
                });
                a(this).find("tr").not("tr:last").find("td:even").css("text-align", "right");
                if (a(this).attr("footer") != null) {
                    if (a(this).attr("footer") == "left") {
                        a(this).find("tr:last").find("td").css("text-align", "left")
                    } else {
                        if (a(this).attr("footer") == "right") {
                            a(this).find("tr:last").find("td").css("text-align", "right")
                        } else {
                            if (a(this).attr("footer") == "center") {
                                a(this).find("tr:last").find("td").css("text-align", "center")
                            } else {
                                if (a(this).attr("footer") == "normal") {
                                    a(this).find("tr:last").find("td:even").css("text-align", "right")
                                }
                            }
                        }
                    }
                } else {
                    a(this).find("tr:last").find("td").css("text-align", "center")
                }
                a(this).find("td").css({
                    paddingTop: "3px",
                    paddingBottom: "3px",
                    border: "none"
                })
            }
            if (a(this).attr("useColor") != "false") {
                a(this).find("tr:even").addClass("odd")
            }
            if (a(this).attr("useHover") != "false") {
                a(this).find("tr").hover(function () {
                    a(this).addClass("highlight")
                }, function () {
                    a(this).removeClass("highlight")
                })
            }
            if (a(this).attr("sortMode") == "true") {
                a(this).find("th").filter(":has(span)").hover(function () {
                    a(this).removeClass("th");
                    a(this).addClass("th_over")
                }, function () {
                    a(this).removeClass("th_over");
                    a(this).addClass("th")
                });
                a(this).find("th span").addClass("sort_off");
                a(this).find("th").click(function () {})
            }
            if (a(this).attr("useClick") != "false") {
                a(this).attr("useClick", "true")
            }
            if (a(this).attr("useClick") == "true" && a(this).attr("useMultColor") == "true") {
                a(this).attr("useClick", "false")
            }
            if (a(this).attr("useRadio") != "true") {
                a(this).attr("useRadio", "false")
            }
            if (a(this).attr("useCheckBox") != "true") {
                a(this).attr("useCheckBox", "false")
            }
            if (a(this).attr("useClick") != "false") {
                if (a(this).attr("useRadio") == "false") {
                    a(this).find("tr").click(function () {
                        a(this).siblings().removeClass("selected");
                        a(this).addClass("selected")
                    })
                } else {
                    a(this).find('input[type="radio"]:checked').parents("tr").addClass("selected");
                    a(this).find("tr").click(function () {
                        a(this).siblings().removeClass("selected");
                        a(this).addClass("selected");
                        a(this).find('input[type="radio"]').attr("checked", "checked")
                    })
                }
            }
            if (a(this).attr("useMultColor") == "true") {
                if (a(this).attr("useCheckBox") == "false") {
                    a(this).find("tr").click(function () {
                        a(this).toggleClass("selected")
                    })
                } else {
                    a(this).find('input[type="checkbox"]:checked').parents("tr").addClass("selected");
                    if (a(this).find("th").length > 0) {
                        var b = a('<span class="img_checkAllOff" title="点击全选"></span>');
                        a(this).find("th").eq(0).html("");
                        a(this).find("th").eq(0).append(b);
                        try {
                            enableTooltips()
                        } catch (c) {}
                        if (a(this).attr("headFixMode") == "true") {
                            b.toggle(function () {
                                a("table:[class=tableStyle]").find("tr").each(function () {
                                    a(this).addClass("selected");
                                    a(this).find('input[type="checkbox"]').attr("checked", "checked")
                                });
                                a(this).removeClass("img_checkAllOff");
                                a(this).addClass("img_checkAllOn");
                                a(this).attr("title", "取消全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (d) {}
                            }, function () {
                                a("table:[class=tableStyle]").find("tr").each(function () {
                                    if (a(this).hasClass("selected")) {
                                        a(this).removeClass("selected");
                                        a(this).find('input[type="checkbox"]').removeAttr("checked")
                                    }
                                });
                                a(this).removeClass("img_checkAllOn");
                                a(this).addClass("img_checkAllOff");
                                a(this).attr("title", "点击全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (d) {}
                            })
                        } else {
                            b.toggle(function () {
                                a(this).parents("table").find("tr").each(function () {
                                    a(this).addClass("selected");
                                    a(this).find('input[type="checkbox"]').attr("checked", "checked")
                                });
                                a(this).removeClass("img_checkAllOff");
                                a(this).addClass("img_checkAllOn");
                                a(this).attr("title", "取消全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (d) {}
                            }, function () {
                                a(this).parents("table").find("tr").each(function () {
                                    if (a(this).hasClass("selected")) {
                                        a(this).removeClass("selected");
                                        a(this).find('input[type="checkbox"]').removeAttr("checked")
                                    }
                                });
                                a(this).removeClass("img_checkAllOn");
                                a(this).addClass("img_checkAllOff");
                                a(this).attr("title", "点击全选");
                                try {
                                    hideTooltip();
                                    enableTooltips()
                                } catch (d) {}
                            })
                        }
                    }
                    a(this).find("tr:has(td)").find('input[type="checkbox"]').unbind("click");
                    a(this).find("tr:has(td)").find('input[type="checkbox"]').bind("click", function () {
                        if (a(this).parents("tr").hasClass("selected")) {
                            a(this).parents("tr").removeClass("selected")
                        } else {
                            a(this).parents("tr").addClass("selected")
                        }
                    })
                }
            }
        })
    }
})(jQuery);

function setTableStyle() {
    $(".tableStyle").tableRenderer()
}
function tableRefresh(b) {
    var a;
    if (typeof(b) == "object") {
        a = b
    } else {
        a = $("#" + b)
    }
    a.tableRenderer()
}
function getPosition(b, c) {
    for (var a = 0; a < c.length; a++) {
        if (b == c[a]) {
            return a;
            break
        }
    }
}(function (a) {
    a.fn.custCheckBox = function (b) {
        var d = {
            disable_all: false,
            hover: true,
            wrapperclass: "group",
            callback: function () {}
        };
        var c = a.extend(d, b);
        return this.each(function () {
            var e = a(this);
            a.fn.buildbox = function (f) {
                if (broswerFlag == "IE6" || broswerFlag == "IE7" || broswerFlag == "IE8" || broswerFlag == "IE9") {
                    a(f).css({
                        display: "none"
                    }).before('<span class="cust_checkbox">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>')
                } else {
                    a(f).css({
                        display: "none"
                    }).before('<span class="cust_checkbox">&nbsp;&nbsp;&nbsp;</span>')
                }
                var i = a(f).attr("checked");
                var g = a(f).attr("type");
                var h = a(f).attr("disabled");
                if (g === "checkbox") {
                    a(f).prev("span").addClass("checkbox");
                    if (h || c.disable_all) {
                        g = "checkbox_disabled"
                    }
                } else {
                    a(f).prev("span").addClass("radio");
                    if (h || c.disable_all) {
                        g = "radio_disabled"
                    }
                }
                if (i) {
                    a(f).prev("span").addClass("cust_" + g + "_on")
                } else {
                    a(f).prev("span").addClass("cust_" + g + "_off")
                }
                if (c.disable_all) {
                    a(f).attr("disabled", "disabled")
                }
                a(f).prev("span").prev("label").css({
                    cursor: "pointer"
                });
                a(f).prev("span").prev("label").unbind().click(function () {
                    if (a(f).attr("onclick") != null) {
                        a(a(f).attr("onclick"))
                    }
                    if (!c.disable_all) {
                        var l = a(this).next("span");
                        var j = a(l).next("input").attr("type");
                        var k = a(l).next("input").attr("disabled");
                        if (a(l).hasClass("checkbox")) {
                            if (a(l).hasClass("cust_" + j + "_off") && !k) {
                                if (broswerFlag == "IE6" || broswerFlag == "IE7" || broswerFlag == "IE8" || broswerFlag == "IE9") {
                                    a(l).removeClass("cust_" + j + "_off").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_on").next("input").attr("checked", "checked")
                                } else {
                                    a(l).removeClass("cust_" + j + "_off").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_on").next("input").removeAttr("checked")
                                }
                            } else {
                                if (!k) {
                                    if (broswerFlag == "IE6" || broswerFlag == "IE7" || broswerFlag == "IE8" || broswerFlag == "IE9") {
                                        a(l).removeClass("cust_" + j + "_on").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_off").next("input").removeAttr("checked")
                                    } else {
                                        a(l).removeClass("cust_" + j + "_on").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_off").next("input").attr("checked", "checked")
                                    }
                                    a(l).removeClass("cust_" + j + "_hvr")
                                }
                            }
                        } else {
                            if (!k) {
                                a(l).parent().find(".cust_checkbox").removeClass("cust_" + j + "_on").addClass("cust_" + j + "_off").next("input").removeAttr("checked");
                                a(l).removeClass("cust_" + j + "_off").addClass("cust_" + j + "_on").next("input").attr("checked", "checked");
                                a(l).removeClass("cust_" + j + "_hvr")
                            }
                        }
                        c.callback.call(this)
                    }
                }).hover(function () {
                    var j = a(this).next("span");
                    if (a(j).hasClass("cust_checkbox_off") && c.hover) {
                        a(j).addClass("cust_checkbox_hvr")
                    } else {
                        if (a(j).hasClass("cust_radio_off") && c.hover) {
                            a(j).addClass("cust_radio_hvr")
                        }
                    }
                }, function () {
                    var j = a(this).next("span");
                    if (a(j).hasClass("cust_checkbox_off") && c.hover) {
                        a(j).removeClass("cust_checkbox_hvr")
                    } else {
                        if (a(j).hasClass("cust_radio_off") && c.hover) {
                            a(j).removeClass("cust_radio_hvr")
                        }
                    }
                });
                a(f).prev("span").unbind().click(function () {
                    if (a(f).attr("onclick") != null) {
                        a(a(f).attr("onclick"))
                    }
                    if (!c.disable_all) {
                        var j = a(this).next("input").attr("type");
                        var k = a(this).next("input").attr("disabled");
                        if (a(this).hasClass("checkbox")) {
                            if (a(this).hasClass("cust_" + j + "_off") && !k) {
                                a(this).removeClass("cust_" + j + "_off").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_on").next("input").attr("checked", "checked")
                            } else {
                                if (!k) {
                                    a(this).removeClass("cust_" + j + "_on").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_off").next("input").removeAttr("checked");
                                    a(this).removeClass("cust_" + j + "_hvr")
                                }
                            }
                        } else {
                            if (!k) {
                                a(this).parent().find(".cust_checkbox").removeClass("cust_" + j + "_on").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_off").next("input").removeAttr("checked");
                                a(this).removeClass("cust_" + j + "_off").removeClass("cust_" + j + "_hvr").addClass("cust_" + j + "_on").next("input").attr("checked", "checked")
                            }
                        }
                        c.callback.call(this)
                    }
                }).hover(function () {
                    if (a(this).hasClass("cust_checkbox_off") && c.hover) {
                        a(this).addClass("cust_checkbox_hvr")
                    } else {
                        if (a(this).hasClass("cust_radio_off") && c.hover) {
                            a(this).addClass("cust_radio_hvr")
                        }
                    }
                }, function () {
                    if (a(this).hasClass("cust_checkbox_off") && c.hover) {
                        a(this).removeClass("cust_checkbox_hvr")
                    } else {
                        if (a(this).hasClass("cust_radio_off") && c.hover) {
                            a(this).removeClass("cust_radio_hvr")
                        }
                    }
                })
            };
            a.fn.buildbox(a(e))
        })
    }
})(jQuery);

function radioRefresh(a) {
    var b;
    if (typeof(a) == "object") {
        b = a
    } else {
        b = $("#" + a)
    }
    b.find("span").remove();
    b.find("input:radio[class='']").custCheckBox()
}
function checkRefresh(a) {
    var b;
    if (typeof(a) == "object") {
        b = a
    } else {
        b = $("#" + a)
    }
    b.find("span").remove();
    b.find("input:checkbox[class='']").custCheckBox()
}
jQuery.fn.extend({
    selectbox: function (a) {
        return this.each(function () {
            new jQuery.SelectBox(this, a)
        })
    }
});
if (!window.console) {
    var console = {
        log: function (a) {}
    }
}
var depth = 500;
var elm_id = 1;
jQuery.SelectBox = function (G, g) {
    var c = g || {};
    c.inputClass = c.inputClass || "selectbox";
    c.containerClass = c.containerClass || "selectbox-wrapper";
    c.hoverClass = c.hoverClass || "current";
    c.currentClass = c.selectedClass || "selected";
    c.debug = c.debug || false;
    elm_id++;
    var i = 0;
    var e = false;
    var E = 0;
    var B = $(G);
    var y = k(c);
    var p = C();
    var d = q(c);
    var x = false;
    var w = false;
    var j = 1;
    var F;
    var D;
    var H = 0;
    var r = 0;
    if (window.navigator.userAgent.indexOf("Windows") > -1) {
        H = 1
    }
    D = B.width();
    if (D == "0") {
        D = 116
    }
    var n;
    if (H == 1) {
        if (broswerFlag == "Safari") {
            n = $("<input type='button' value=' ' class='selBtn_safari'/>")
        }
        if (broswerFlag == "IE9") {
            n = $("<input type='button' value=' ' class='selBtn selBtn_ie9'/>")
        } else {
            n = $("<input type='button' value=' ' class='selBtn'/>")
        }
    } else {
        n = $("<input type='button' value=' ' class='selBtn_linux'/>")
    }
    if (B.attr("disabled") == true) {
        n.attr("disabled", true);
        n.addClass("selBtn_disabled")
    }
    var v = $("<div class='loader'>数据加载中...</div>");
    if (B.attr("autoWidth") != null) {
        if (B.attr("autoWidth") == "true") {
            x = true
        } else {
            x = false
        }
    }
    if (B.attr("colNum") != null) {
        j = parseInt(B.attr("colNum"))
    }
    if (B.attr("colWidth") != null) {
        F = Number(B.attr("colWidth"))
    }
    if (j != 1) {
        if (x) {
            d.width(D - 20)
        } else {
            d.width(96)
        }
        if (F != null) {
            y.width(F * j + 40)
        } else {
            var b = Number(D);
            y.width(b * j + 40)
        }
    } else {
        if (x) {
            d.width(D - 20);
            y.width(D + 6)
        } else {
            d.width(96);
            var f = 96 + 4 + 22;
            var b = Number(D);
            y.width(Math.max(f, b))
        }
    }
    B.hide().before(p);
    p.append(d);
    p.append(n);
    p.append(y);
    p.append(v);
    v.hide();
    z();
    if (B.attr("editable") != null) {
        if (B.attr("editable") == "true") {
            w = true
        } else {
            w = false
        }
    }
    if (!w) {
        d.css({
            cursor: "pointer"
        });
        d.click(function () {
            var M;
            var K = y.find("li").length;
            if (j == 1) {
                M = K * 26
            } else {
                if (K % j == 0) {
                    M = K * 26 / j
                } else {
                    M = (K - K % j) * 26 / j + 26
                }
            }
            y.height(M);
            var I = 200;
            if (parentTopHeight > 0) {
                var L = window.top.document.documentElement.clientHeight;
                I = L - parentTopHeight - parentBottomHeight - p.offset().top - 30
            } else {
                I = window.document.documentElement.clientHeight - (p.offset().top - $(window).scrollTop()) - 30
            }
            if (I < y.height()) {
                if (p.offset().top > y.height()) {
                    if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                        y.css({
                            top: -y.height() - 17
                        })
                    } else {
                        if ($.browser.msie) {
                            y.css({
                                top: -y.height()
                            })
                        } else {
                            y.css({
                                top: -y.height() - 7
                            })
                        }
                    }
                } else {
                    if (I < 100 && p.offset().top > I) {
                        y.height(p.offset().top);
                        y.css({
                            overflow: "auto"
                        });
                        if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                            y.css({
                                top: -y.height() - 17
                            })
                        } else {
                            if ($.browser.msie) {
                                y.css({
                                    top: -y.height()
                                })
                            } else {
                                y.css({
                                    top: -y.height() - 7
                                })
                            }
                        }
                    } else {
                        y.css({
                            overflow: "auto"
                        });
                        if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                            y.css({
                                top: 8
                            })
                        } else {
                            if ($.browser.msie) {
                                y.css({
                                    top: 25
                                })
                            } else {
                                y.css({
                                    top: 18
                                })
                            }
                        }
                        y.height(I)
                    }
                }
            } else {
                if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                    y.css({
                        top: 8
                    })
                } else {
                    if ($.browser.msie) {
                        y.css({
                            top: 25
                        })
                    } else {
                        y.css({
                            top: 18
                        })
                    }
                }
            }
            if (!e) {
                depth++;
                p.css({
                    zIndex: depth
                });
                setTimeout(J, 100)
            }
            function J() {
                y.toggle()
            }
        }).focus(function () {
            if (y.not(":visible")) {
                depth++;
                p.css({
                    zIndex: depth
                });
                e = true;
                setTimeout(I, 100)
            }
            function I() {
                y.show()
            }
        }).keydown(function (I) {
            switch (I.keyCode) {
            case 38:
                I.preventDefault();
                o(-1);
                break;
            case 40:
                I.preventDefault();
                o(1);
                break;
            case 13:
                I.preventDefault();
                $("li." + c.hoverClass).trigger("click");
                break;
            case 27:
                l();
                break
            }
        }).blur(function () {
            if (y.is(":visible") && E > 0) {
                if (c.debug) {
                    console.log("container visible and has focus")
                }
            } else {
                if (r == 1) {} else {
                    l()
                }
            }
        })
    } else {
        d.css({
            cursor: "text"
        });
        d.change(function () {
            B.attr("editValue", $(this).val())
        })
    }
    n.click(function () {
        var M;
        var K = y.find("li").length;
        if (j == 1) {
            M = K * 26
        } else {
            if (K % j == 0) {
                M = K * 26 / j
            } else {
                M = (K - K % j) * 26 / j + 26
            }
        }
        y.height(M);
        var J = 200;
        if (parentTopHeight > 0) {
            var L = window.top.document.documentElement.clientHeight;
            J = L - parentTopHeight - parentBottomHeight - p.offset().top - 30
        } else {
            J = window.document.documentElement.clientHeight - (p.offset().top - $(window).scrollTop()) - 30
        }
        if (J < y.height()) {
            if (p.offset().top > y.height()) {
                if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                    y.css({
                        top: -y.height() - 17
                    })
                } else {
                    if ($.browser.msie) {
                        y.css({
                            top: -y.height()
                        })
                    } else {
                        y.css({
                            top: -y.height() - 7
                        })
                    }
                }
            } else {
                if (J < 100 & p.offset().top > J) {
                    y.height(p.offset().top);
                    y.css({
                        overflow: "auto"
                    });
                    if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                        y.css({
                            top: -y.height() - 17
                        })
                    } else {
                        if ($.browser.msie) {
                            y.css({
                                top: -y.height()
                            })
                        } else {
                            y.css({
                                top: -y.height() - 7
                            })
                        }
                    }
                } else {
                    y.css({
                        overflow: "auto"
                    });
                    if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                        y.css({
                            top: 8
                        })
                    } else {
                        if ($.browser.msie) {
                            y.css({
                                top: 25
                            })
                        } else {
                            y.css({
                                top: 18
                            })
                        }
                    }
                    y.height(J)
                }
            }
        } else {
            if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                y.css({
                    top: 8
                })
            } else {
                if ($.browser.msie) {
                    y.css({
                        top: 25
                    })
                } else {
                    y.css({
                        top: 18
                    })
                }
            }
        }
        if (!e) {
            depth++;
            p.css({
                zIndex: depth
            });
            setTimeout(I, 100)
        }
        function I() {
            y.toggle()
        }
    }).focus(function () {
        if (y.not(":visible")) {
            depth++;
            p.css({
                zIndex: depth
            });
            e = true;
            setTimeout(I, 100)
        }
        function I() {
            y.show()
        }
    }).keydown(function (I) {
        switch (I.keyCode) {
        case 38:
            I.preventDefault();
            o(-1);
            break;
        case 40:
            I.preventDefault();
            o(1);
            break;
        case 13:
            I.preventDefault();
            $("li." + c.hoverClass).trigger("click");
            break;
        case 27:
            l();
            break
        }
    }).blur(function () {
        if (y.is(":visible") && E > 0) {
            if (c.debug) {
                console.log("container visible and has focus")
            }
        } else {
            if (r == 1) {} else {
                l()
            }
        }
    });

    function l() {
        E = 0;
        y.hide();
        r = 0
    }
    function z() {
        y.append(s(d.attr("id"))).hide();
        var I = d.css("width")
    }
    function C() {
        var I = $("<div></div>");
        I.addClass("mainCon");
        return I
    }
    function k(I) {
        var J = $("<div></div>");
        J.attr("id", elm_id + "_container");
        J.addClass(I.containerClass);
        J.css({});
        J.mouseover(function () {
            r = 1
        });
        J.mouseout(function () {
            r = 0
        });
        return J
    }
    function q(J) {
        var I = document.createElement("input");
        var L = $(I);
        L.attr("id", elm_id + "_input");
        L.attr("type", "text");
        L.addClass(J.inputClass);
        if (broswerFlag == "IE8") {
            L.addClass("selectboxFont")
        }
        L.attr("autocomplete", "off");
        var K = false;
        if (B.attr("editable") != null) {
            if (B.attr("editable") == "true") {
                K = true
            } else {
                K = false
            }
        }
        if (!K) {
            L.attr("readonly", "readonly")
        } else {
            L.attr("readonly", false)
        }
        L.attr("tabIndex", B.attr("tabindex"));
        if (B.attr("disabled") == true) {
            L.attr("disabled", true);
            L.addClass("inputDisabled")
        }
        return L
    }
    function o(J) {
        var I = $("li", y);
        if (!I || I.length == 0) {
            return false
        }
        i += J;
        if (i < 0) {
            i = I.size()
        } else {
            if (i > I.size()) {
                i = 0
            }
        }
        a(I, i);
        I.removeClass(c.hoverClass);
        $(I[i]).addClass(c.hoverClass)
    }
    function a(J, K) {
        var I = $(J[K]).get(0);
        var J = y.get(0);
        if (I.offsetTop + I.offsetHeight > J.scrollTop + J.clientHeight) {
            J.scrollTop = I.offsetTop + I.offsetHeight - J.clientHeight
        } else {
            if (I.offsetTop < J.scrollTop) {
                J.scrollTop = I.offsetTop
            }
        }
    }
    function h() {
        var I = $("li." + c.currentClass, y).get(0);
        var J = (I.id).split("_");
        var L = J[0].length + J[1].length + 2;
        var M = I.id;
        var K = M.substr(L, M.length);
        B.val(K);
        B.attr("relText", $(I).text());
        var M = $(I).html().trim();
        d.val(M);
        if (w == true) {
            B.attr("editValue", d.val())
        }
        B.focus();
        return true
    }
    function t() {
        return B.val()
    }
    function m() {
        return d.val()
    }
    function s(O) {
        var P = new Array();
        var L = document.createElement("ul");
        var N = [];
        var J = 0;
        var I;
        if (B.attr("childId") != null) {
            I = true
        }
        var K = 1;
        var M;
        if (B.attr("colNum") != null) {
            K = parseInt(B.attr("colNum"))
        }
        if (B.attr("colWidth") != null) {
            M = Number(B.attr("colWidth"))
        }
        B.find("option").each(function () {
            N.push($(this)[0]);
            var Q = document.createElement("li");
            Q.setAttribute("id", O + "_" + $(this).val());
            Q.innerHTML = $(this).html();
            if ($(this).is(":selected")) {
                var R;
                if (B.attr("editable") != null) {
                    if (B.attr("editable") == "true") {
                        R = true
                    } else {
                        R = false
                    }
                }
                if (R == true) {
                    d.val($(this).html());
                    $(Q).addClass(c.currentClass)
                } else {
                    var T = $(this).html().trim();
                    d.val(T);
                    $(Q).addClass(c.currentClass)
                }
            }
            if (K != 1) {
                $(Q).addClass("li_left");
                if (M != null) {
                    $(Q).width(M)
                } else {
                    var S = Number(D);
                    $(Q).width(S)
                }
            }
            L.appendChild(Q);
            $(Q).mouseover(function (U) {
                E = 1;
                if (c.debug) {
                    console.log("over on : " + this.id)
                }
                jQuery(U.target, y).addClass(c.hoverClass)
            }).mouseout(function (U) {
                E = -1;
                if (c.debug) {
                    console.log("out on : " + this.id)
                }
                jQuery(U.target, y).removeClass(c.hoverClass)
            }).click(function (V) {
                var W = $("li." + c.hoverClass, y).get(0);
                if (c.debug) {
                    console.log("click on :" + this.id)
                }
                var U = $(this).attr("id").split("_");
                $("#" + U[0] + "_container li." + c.currentClass).removeClass(c.currentClass);
                $(this).addClass(c.currentClass);
                h();
                B.get(0).blur();
                l();
                if (B.attr("onchange") != null) {
                    $(B.attr("onchange"))
                }
                d.removeClass("tipColor");
                if (I) {
                    u(B, B.val())
                }
            })
        });
        B.find("optgroup").each(function () {
            var R = getPosition($(this).children("option").eq(0)[0], N);
            var Q = $(this).attr("label");
            $(L).find("li").eq(R + J).before("<li class='group'>" + Q + "</li>");
            J++
        });
        return L
    }
    function u(K, J) {
        if (J != "") {
            var L = K.attr("childId");
            var I = $("#" + L).prev().find("div[class=loader]");
            I.show();
            window.setTimeout(function () {
                A(K, J)
            }, 200)
        }
    }
    function A(K, J) {
        var I;
        if (K.attr("childDataType") == null) {
            I = K.attr("childDataPath") + J
        } else {
            if (K.attr("childDataType") == "url") {
                I = K.attr("childDataPath") + J
            } else {
                I = K.attr("childDataPath") + J + "." + K.attr("childDataType")
            }
        }
        $.ajax({
            url: I,
            error: function () {
                try {
                    top.Dialog.alert("数据加载失败，请检查childDataPath是否正确")
                } catch (L) {
                    alert("数据加载失败，请检查childDataPath是否正确")
                }
            },
            success: function (O) {
                var L = K.attr("childId");
                var T = $("#" + L).prev().find("div[class=loader]");
                T.hide();
                var R = $("#" + L).prev().find("ul");
                var N = $("#" + L).prev().find(">div").attr("id").split("_")[0];
                var M = $("#" + L).prev().find("input:text");
                var P = $("#" + L)[0];
                R.html("");
                P.options.length = 0;
                $(O).find("node").each(function () {
                    var W = $(this).attr("text");
                    var V = $(this).attr("value");
                    var U = document.createElement("li");
                    $(U).text(W);
                    $(U).attr("relValue", V);
                    R.append($(U));
                    P.options[P.options.length] = new Option(W, V);
                    $(U).mouseover(function (X) {
                        jQuery(X.target).addClass(c.hoverClass)
                    });
                    $(U).mouseout(function (X) {
                        jQuery(X.target).removeClass(c.hoverClass)
                    });
                    $(U).mousedown(function (Y) {
                        $("#" + N + "_container li." + c.currentClass).removeClass(c.currentClass);
                        $(this).addClass(c.currentClass);
                        $("#" + L).attr("relText", $(this).text());
                        $("#" + L).val($(this).attr("relValue"));
                        M.val($(this).html());
                        $("#" + L).prev().find(">div").hide();
                        $("#" + L).focus();
                        if ($("#" + L).attr("onchange") != null) {
                            $($("#" + L).attr("onchange"))
                        }
                        var X;
                        if ($("#" + L).attr("childId") != null) {
                            X = true
                        }
                        if (X) {
                            u($("#" + L), $("#" + L).val())
                        }
                    })
                });
                if ($(O).find("node").length == 0) {
                    var S = document.createElement("li");
                    $(S).text("无内容");
                    R.append($(S))
                }
                var Q = R.find("li").eq(0);
                M.val(Q.text());
                Q.addClass(c.currentClass);
                $("#" + L).attr("relValue", Q.attr("relValue"));
                $("#" + L).attr("relText", Q.text())
            }
        })
    }
};

function selRefresh(a) {
    var b;
    if (typeof(a) == "object") {
        b = a
    } else {
        b = $("#" + a)
    }
    b.prev(".mainCon").remove();
    b.selectbox()
}
var tipDirection = "down";

function enableTooltips(e) {
    var b, a, c, d;
    if (!document.getElementById || !document.getElementsByTagName) {
        return
    }
    AddCss();
    d = document.createElement("span");
    d.id = "btc";
    d.setAttribute("id", "btc");
    d.style.position = "absolute";
    d.style.zIndex = 9999;
    $("body").append($(d));
    $("a[title],span[title],input[title],textarea[title],img[title],div[title]").each(function () {
        if ($(this).attr("defaultTip") != "false") {
            Prepare($(this)[0])
        }
    })
}
function _getStrLength(c) {
    var b;
    var a;
    for (b = 0, a = 0; b < c.length; b++) {
        if (c.charCodeAt(b) < 128) {
            a++
        } else {
            a = a + 2
        }
    }
    return a
}
function Prepare(f) {
    var g, d, a, e, c;
    d = f.getAttribute("title");
    if (d != null && d.length != 0) {
        f.removeAttribute("title");
        if (_getStrLength(d) > 37 || _getStrLength(d) == 37) {
            g = CreateEl("span", "tooltip")
        } else {
            if (_getStrLength(d) > 10 && _getStrLength(d) < 37) {
                g = CreateEl("span", "tooltip_mid")
            } else {
                g = CreateEl("span", "tooltip_min")
            }
        }
        e = CreateEl("span", "top");
        $(e).html(d);
        g.appendChild(e);
        a = CreateEl("b", "bottom");
        g.appendChild(a);
        setOpacity(g);
        f.tooltip = g;
        f.onmouseover = showTooltip;
        f.onmouseout = hideTooltip;
        f.onmousemove = Locate2
    }
}
function showTooltip(a) {
    document.getElementById("btc").appendChild(this.tooltip);
    Locate(a)
}
function hideTooltip(a) {
    var b = document.getElementById("btc");
    if (b.childNodes.length > 0) {
        b.removeChild(b.firstChild)
    }
}
function setOpacity(a) {
    a.style.filter = "alpha(opacity:95)";
    a.style.KHTMLOpacity = "0.95";
    a.style.MozOpacity = "0.95";
    a.style.opacity = "0.95"
}
function CreateEl(b, d) {
    var a = document.createElement(b);
    a.className = d;
    a.style.display = "block";
    return (a)
}
function AddCss() {}
function Locate(g) {
    var a = 0,
        i = 0;
    if (g == null) {
            g = window.event
        }
    if (g.pageX || g.pageY) {
            a = g.pageX;
            i = g.pageY
        } else {
            if (g.clientX || g.clientY) {
                if (document.documentElement.scrollTop) {
                    a = g.clientX + document.documentElement.scrollLeft;
                    i = g.clientY + document.documentElement.scrollTop
                } else {
                    a = g.clientX + document.body.scrollLeft;
                    i = g.clientY + document.body.scrollTop
                }
            }
        }
    var h = window.document.documentElement.clientWidth;
    var c = window.document.documentElement.clientHeight;
    var b = $("#btc").width();
    var f = $("#btc").height();
    if (h - b < a - 20) {
            document.getElementById("btc").style.left = (h - b) + "px"
        } else {
            document.getElementById("btc").style.left = (a - 20) + "px"
        }
    if ($(window).scrollTop() + c - f < i) {
            document.getElementById("btc").style.top = (i - f - 10) + "px";
            var d = $("#btc >span")[0].className;
            if (d == "tooltip") {
                $("#btc >span")[0].className = "tooltip_r"
            } else {
                if (d == "tooltip_min") {
                    $("#btc >span")[0].className = "tooltip_min_r"
                } else {
                    if (d == "tooltip_mid") {
                        $("#btc >span")[0].className = "tooltip_mid_r"
                    }
                }
            }
            tipDirection = "up"
        } else {
            document.getElementById("btc").style.top = (i + 10) + "px";
            var d = $("#btc >span")[0].className;
            if (d == "tooltip_r") {
                $("#btc >span")[0].className = "tooltip"
            } else {
                if (d == "tooltip_min_r") {
                    $("#btc >span")[0].className = "tooltip_min"
                } else {
                    if (d == "tooltip_mid_r") {
                        $("#btc >span")[0].className = "tooltip_mid"
                    }
                }
            }
            tipDirection = "down"
        }
}
function Locate2(f) {
    var a = 0,
        h = 0;
    if (f == null) {
            f = window.event
        }
    if (f.pageX || f.pageY) {
            a = f.pageX;
            h = f.pageY
        } else {
            if (f.clientX || f.clientY) {
                if (document.documentElement.scrollTop) {
                    a = f.clientX + document.documentElement.scrollLeft;
                    h = f.clientY + document.documentElement.scrollTop
                } else {
                    a = f.clientX + document.body.scrollLeft;
                    h = f.clientY + document.body.scrollTop
                }
            }
        }
    var g = window.document.documentElement.clientWidth;
    var c = window.document.documentElement.clientHeight;
    var b = $("#btc").width();
    var d = $("#btc").height();
    if (g - b < a - 20) {
            document.getElementById("btc").style.left = (g - b) + "px"
        } else {
            document.getElementById("btc").style.left = (a - 20) + "px"
        }
    if (tipDirection == "up") {
            document.getElementById("btc").style.top = (h - d - 10) + "px"
        } else {
            document.getElementById("btc").style.top = (h + 10) + "px"
        }
}(function (c) {
    var h, i;
    var d = 0;
    var a = 32;
    var e;
    c.fn.TextAreaResizer = function () {
        return this.each(function () {
            h = c(this).addClass("processed"),
            i = null;
            c(this).wrap('<div class="resizable-textarea"><span></span></div>').parent().append(c('<div class="grippie"></div>').bind("mousedown", {
                el: this
            }, b));
            var k = c("div.grippie", c(this).parent())[0];
            k.style.marginRight = (k.offsetWidth - c(this)[0].offsetWidth) + "px"
        })
    };

    function b(k) {
        h = c(k.data.el);
        h.blur();
        d = j(k).y;
        i = h.height() - d;
        h.css("opacity", 0.25);
        c(document).mousemove(g).mouseup(f);
        return false
    }
    function g(m) {
        var k = j(m).y;
        var l = i + k;
        if (d >= (k)) {
            l -= 5
        }
        d = k;
        l = Math.max(a, l);
        h.height(l + "px");
        if (l < a) {
            f(m)
        }
        return false
    }
    function f(k) {
        c(document).unbind("mousemove", g).unbind("mouseup", f);
        h.css("opacity", 1);
        h.focus();
        h = null;
        i = null;
        d = 0
    }
    function j(k) {
        return {
            x: k.clientX + document.documentElement.scrollLeft,
            y: k.clientY + document.documentElement.scrollTop
        }
    }
})(jQuery);
(function (a) {
    a.fn.watermark = function (b, c) {
        return this.each(function () {
            var e = a(this),
                d;
            e.focus(function () {
                    d && !(d = 0) && e.removeClass(b).data("w", 0).val("")
                }).blur(function () {
                    !e.val() && (d = 1) && e.addClass(b).data("w", 1).val(c)
                }).closest("form").submit(function () {
                    d && e.val("")
                });
            e.blur()
        })
    };
    a.fn.removeWatermark = function () {
        return this.each(function () {
            a(this).data("w") && a(this).val("")
        })
    }
})(jQuery);
if (jQuery) {
    (function (a) {
        a.cursorMessageData = {};
        a(window).ready(function (b) {
            if (a("#cursorMessageDiv").length == 0) {
                a("body").append('<div id="cursorMessageDiv">&nbsp;</div>');
                a("#cursorMessageDiv").hide()
            }
            a("body").mousemove(function (c) {
                a.cursorMessageData.mouseX = c.pageX;
                a.cursorMessageData.mouseY = c.pageY;
                if (a.cursorMessageData.options != undefined) {
                    a._showCursorMessage()
                }
            })
        });
        a.extend({
            cursorMessage: function (c, b) {
                if (b == undefined) {
                    b = {}
                }
                if (b.offsetX == undefined) {
                    b.offsetX = 5
                }
                if (b.offsetY == undefined) {
                    b.offsetY = 5
                }
                if (b.hideTimeout == undefined) {
                    b.hideTimeout = 1000
                }
                a("#cursorMessageDiv").html(c).fadeIn("slow");
                if (jQuery.cursorMessageData.hideTimeoutId != undefined) {
                    clearTimeout(jQuery.cursorMessageData.hideTimeoutId)
                }
                if (b.hideTimeout > 0) {
                    jQuery.cursorMessageData.hideTimeoutId = setTimeout(a.hideCursorMessage, b.hideTimeout)
                }
                jQuery.cursorMessageData.options = b;
                a._showCursorMessage()
            },
            hideCursorMessage: function () {
                a("#cursorMessageDiv").fadeOut("slow")
            },
            _showCursorMessage: function () {
                a("#cursorMessageDiv").css({
                    top: (a.cursorMessageData.mouseY + a.cursorMessageData.options.offsetY) + "px",
                    left: (a.cursorMessageData.mouseX + a.cursorMessageData.options.offsetX)
                })
            }
        })
    })(jQuery)
}
jQuery.fn.caps = function (a) {
    return this.keypress(function (f) {
        var b = f.which ? f.which : (f.keyCode ? f.keyCode : -1);
        var d = f.shiftKey ? f.shiftKey : (f.modifiers ? !! (f.modifiers & 4) : false);
        var g = ((b >= 65 && b <= 90) && !d) || ((b >= 97 && b <= 122) && d);
        a.call(this, g)
    })
};

function iframeHeight(b) {
    var a = document.getElementById(b);
    //调整iframe高度  林杨 2011-07-07
    //start
    var Sys;
	var match;

    var ua = navigator.userAgent.toLowerCase();
	if (window.ActiveXObject){ //判断浏览器类型及版本
		Sys = "ie";
    	match = ua.match(/msie ([\d.]+)/)[1]
	}
    if(Sys == 'ie' && parseInt(match)==6){ //IE6
    	a.style.height = (a.contentWindow.document.body.scrollHeight+40) + "px"
    }else{
    	a.style.height = a.contentWindow.document.body.scrollHeight + "px"
    }
    //end
}(function (a) {
    a.rebrushfileupload = {
        defaults: {
            button_text: " ",
            class_container: "fileupload-rebrush",
            class_field: "fileupload-rebrush-field",
            class_button: "fileupload-rebrush-button"
        }
    };
    a.fn.extend({
        rebrushfileupload: function (d) {
            d = a.extend({}, a.rebrushfileupload.defaults, d);
            var e = ["padding-left", "padding-right", "margin-left", "margin-right", "border-left-width", "border-right-width"];
            a(this).wrap('<div class="file-container"/>');
            var g = a(this).parent();
            if (broswerFlag == "IE9") {
                g.prepend('<input type="text" value="" readonly="readonly" /><input type="button" class="fileBtn fileBtn_ie9" value="' + d.button_text + '" />')
            } else {
                if (broswerFlag == "Firefox") {
                    g.prepend('<input type="text" value="" readonly="readonly" /><input type="button" class="fileBtn fileBtn_ff" value="' + d.button_text + '" />')
                } else {
                    g.prepend('<input type="text" value="" readonly="readonly" /><input type="button" class="fileBtn" value="' + d.button_text + '" />')
                }
            }
            var i = g.find("input[type=text]");
            var b = g.find("input[type=button]");
            var f = 0;
            for (var h in e) {
                var c = Math.round(parseFloat(i.css(e[h]) + 0)) + 0;
                var j = Math.round(parseFloat(b.css(e[h]) + 0)) + 0;
                f += (isNaN(c) ? 0 : c) + (isNaN(j) ? 0 : j)
            }
            f += Math.round(parseFloat(i.width())) + Math.round(parseFloat(b.width()));
            if (a.browser.msie) {
                i.width(a(this).width() - 65);
                g.css({
                    position: "relative",
                    width: a(this).width() + 10,
                    overflow: "hidden"
                })
            } else {
                i.width(a(this).width() - 90);
                g.css({
                    position: "relative",
                    width: a(this).width(),
                    overflow: "hidden"
                })
            }
            if (broswerFlag == "IE8" || broswerFlag == "IE9") {
                a(this).css({
                    position: "absolute",
                    "z-index": 2,
                    "font-size": "12px",
                    opacity: "0",
                    left: "0px",
                    top: "-18px"
                })
            } else {
                if (broswerFlag == "Firefox") {
                    a(this).css({
                        position: "absolute",
                        "z-index": 2,
                        "font-size": "12px",
                        opacity: "0",
                        left: "0px",
                        top: "-8px"
                    })
                } else {
                    a(this).css({
                        position: "absolute",
                        "z-index": 2,
                        "font-size": "12px",
                        opacity: "0",
                        left: "0px",
                        top: "0px"
                    })
                }
            }
            a(this).change(function () {
                a(this).parent().find("input[type=text]").val(a(this).val());
                if (a(this).attr("showInfo") != "false") {
                    try {
                        a(this).attr("title", a(this).val());
                        enableTooltips()
                    } catch (k) {}
                }
            })
        }
    })
})(jQuery);
(function (d) {
    d.fn.clearableTextField = function () {
        if (d(this).length > 0) {
            d(this).bind("keyup change paste cut", e);
            for (var f = 0; f < d(this).length; f++) {
                c(d(d(this)[f]))
            }
        }
    };

    function e() {
        c(d(this))
    }
    function c(f) {
        if (f.val().length > 0) {
            b(f)
        } else {
            a(f)
        }
    }
    function b(i) {
        if (!i.next().hasClass("text_clear_button")) {
            i.after("<div class='text_clear_button'></div>");
            var f = i.next();
            var g = f.outerHeight(),
                k = f.outerHeight();
            i.css("padding-right", parseInt(i.css("padding-right")) + g + 1);
            i.width(i.width() - g - 1);
            var m = i.position();
            var j = {};
            j.left = m.left + i.outerWidth(false) - (g + 2);
            var l = Math.round((i.outerHeight(true) - k) / 2);
            j.top = m.top + d("#scrollContent").scrollTop() + l;
            f.css(j);
            f.click(function () {
                    i.val("");
                    c(i)
                })
        }
    }
    function a(h) {
        var f = h.next();
        if (f.hasClass("text_clear_button")) {
            f.remove();
            var g = f.width();
            h.css("padding-right", parseInt(h.css("padding-right")) - g - 1);
            h.width(h.width() + g + 1)
        }
    }
})(jQuery);
(function (a) {
    a.fn.maxlength = function (b) {
        var c = jQuery.extend({
            events: [],
            maxCharacters: 10,
            status: true,
            statusClass: "maxNum",
            statusText: "剩余字数",
            notificationClass: "notification",
            showAlert: false,
            alertText: "输入字符超出限制.",
            slider: true
        }, b);
        a.merge(c.events, ["keyup"]);
        return this.each(function () {
            var g = a(this);
            var j = a(this).val().length;

            function d() {
                var k = c.maxCharacters - j;
                if (k < 0) {
                    k = 0
                }
                g.next("div").html(c.statusText + " :" + k)
            }
            function e() {
                var k = true;
                if (j >= c.maxCharacters) {
                    k = false;
                    g.addClass(c.notificationClass);
                    g.val(g.val().substr(0, c.maxCharacters));
                    i()
                } else {
                    if (g.hasClass(c.notificationClass)) {
                        g.removeClass(c.notificationClass)
                    }
                }
                if (c.status) {
                    d()
                }
            }
            function i() {
                if (c.showAlert) {
                    alert(c.alertText)
                }
            }
            function f() {
                var k = false;
                if (g.is("textarea")) {
                    k = true
                } else {
                    if (g.filter("input[type=text]")) {
                        k = true
                    } else {
                        if (g.filter("input[type=password]")) {
                            k = true
                        }
                    }
                }
                return k
            }
            if (!f()) {
                return false
            }
            a.each(c.events, function (k, l) {
                g.bind(l, function (m) {
                    j = g.val().length;
                    e()
                })
            });
            if (c.status) {
                g.after(a("<div/>").addClass(c.statusClass).html("-"));
                d()
            }
            if (!c.status) {
                var h = g.next("div." + c.statusClass);
                if (h) {
                    h.remove()
                }
            }
            if (c.slider) {
                g.next().hide();
                g.focus(function () {
                    g.next().slideDown("fast")
                });
                g.blur(function () {
                    g.next().slideUp("fast")
                })
            }
        })
    }
})(jQuery);
var colsDefault = 0;
var rowsDefault = 5;

function setDefaultValues(a) {
    colsDefault = a.cols;
    rowsDefault = $(a).attr("rows")
}
function bindEvents(a) {
    a.onkeyup = function () {
        grow(a)
    }
}
function grow(d) {
    var c = 0;
    var a = d.value.split("\n");
    for (var b = a.length - 1; b >= 0; --b) {
        c += Math.floor((a[b].length / colsDefault) + 1)
    }
    if (c >= rowsDefault) {
        d.rows = c + 1
    } else {
        d.rows = rowsDefault
    }
}
jQuery.fn.autoGrow = function () {
    return this.each(function () {
        setDefaultValues(this);
        bindEvents(this)
    })
};
(function (b) {
    var a = new
    function () {
        this.countRegexp = function (d, e) {
            var c = d.match(e);
            return c ? c.length : 0
        };
        this.getStrength = function (i, e) {
            var c = i.length;
            if (c < e) {
                return 0
            }
            var g = this.countRegexp(i, /\d/g),
                j = this.countRegexp(i, /[a-z]/g),
                f = this.countRegexp(i, /[A-Z]/g),
                d = c - g - j - f;
            if (g == c || j == c || f == c || d == c) {
                    return 1
                }
            var h = 0;
            if (g) {
                    h += 2
                }
            if (j) {
                    h += f ? 4 : 3
                }
            if (f) {
                    h += j ? 4 : 3
                }
            if (d) {
                    h += 5
                }
            if (c > 10) {
                    h += 1
                }
            return h
        };
        this.getStrengthLevel = function (e, c) {
            var d = this.getStrength(e, c);
            switch (true) {
            case (d <= 0):
                return 1;
                break;
            case (d > 0 && d <= 4):
                return 2;
                break;
            case (d > 4 && d <= 8):
                return 3;
                break;
            case (d > 8 && d <= 12):
                return 4;
                break;
            case (d > 12):
                return 5;
                break
            }
            return 1
        }
    };
    b.fn.password_strength = function (c) {
        var d = b.extend({
            container: null,
            minLength: 6,
            texts: {
                1: "非常弱",
                2: "弱密码",
                3: "强度一般",
                4: "强密码",
                5: "非常强"
            }
        }, c);
        return this.each(function () {
            if (d.container) {
                var e = b(d.container)
            } else {
                var e = b("<span/>").attr("class", "password_strength");
                b(this).after(e)
            }
            b(this).keyup(function () {
                var g = b(this).val();
                if (g.length > 0) {
                    var h = a.getStrengthLevel(g, d.minLength);
                    var f = "password_strength_" + h;
                    if (!e.hasClass(f) && h in d.texts) {
                        e.text(d.texts[h]).attr("class", "password_strength " + f)
                    }
                } else {
                    e.text("").attr("class", "password_strength")
                }
            })
        })
    }
})(jQuery);
jQuery.jCookie = function (i, b, l, j) {
    if (!navigator.cookieEnabled) {
        return false
    }
    var j = j || {};
    if (typeof(arguments[0]) !== "string" && arguments.length === 1) {
        j = arguments[0];
        i = j.name;
        b = j.value;
        l = j.expires
    }
    i = encodeURI(i);
    if (b && (typeof(b) !== "number" && typeof(b) !== "string" && b !== null)) {
        return false
    }
    var e = j.path ? "; path=" + j.path : "";
    var f = j.domain ? "; domain=" + j.domain : "";
    var d = j.secure ? "; secure" : "";
    var g = "";
    if (b || (b === null && arguments.length == 2)) {
        l = (l === null || (b === null && arguments.length == 2)) ? -1 : l;
        if (typeof(l) === "number" && l != "session" && l !== undefined) {
            var k = new Date();
            k.setTime(k.getTime() + (l * 24 * 60 * 60 * 1000));
            g = ["; expires=", k.toGMTString()].join("")
        }
        document.cookie = [i, "=", encodeURI(b), g, f, e, d].join("");
        return true
    }
    if (!b && typeof(arguments[0]) === "string" && arguments.length == 1 && document.cookie && document.cookie.length) {
        var a = document.cookie.split(";");
        var h = a.length;
        while (h--) {
            var c = a[h].split("=");
            if (jQuery.trim(c[0]) === i) {
                return decodeURI(c[1])
            }
        }
    }
    return false
};

function showProgressBar(c) {
    top.progressFlag = 1;
    var a = "正在加载中...";
    if (c) {
        a = c
    }
    var b = new top.Dialog();
    b.Width = 360;
    b.Height = 70;
    b.Title = a;
    b.InvokeElementId = "progress";
    b.show()
}
function closeProgress() {
    try {
        if (top.progressFlag == 1) {
            top.Dialog.close();
            top.progressFlag = 0
        }
    } catch (a) {}
}
String.prototype.trim = function () {
    return this.replace(/(^\s*)|(\s*$)/g, "")
};