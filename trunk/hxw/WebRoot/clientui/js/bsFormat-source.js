var leftOverHeight = 0;
var rightOverHeight = 0;
var exitMenu = 0;
var hexitMenu = 0;
var progressFlag = 0;
$(function () {
    leftOverHeight = $("#hbox").outerHeight() + $("#fbox").outerHeight() + $("#lbox_topcenter").outerHeight() + $("#lbox_bottomcenter").outerHeight();
    rightOverHeight = $("#hbox").outerHeight() + $("#fbox").outerHeight() + $("#rbox_topcenter").outerHeight() + $("#rbox_bottomcenter").outerHeight();
    var c = null;
    autoReset();
    window.onresize = function () {
        if (c) {
            clearTimeout(c)
        }
        c = setTimeout("autoReset()", 100)
    };
    var b = document.getElementsByTagName("html")[0];
    b.style.overflow = "hidden";
    $("#bs_center").toggle(function () {
        $("#hideCon").hide(200);
        $(this).removeClass("bs_leftArr");
        $(this).addClass("bs_rightArr");
        $(this).attr("title", "展开面板");
        enableTooltips();
        hideTooltip();
        return false
    }, function () {
        $("#hideCon").show();
        $(this).removeClass("bs_rightArr");
        $(this).addClass("bs_leftArr");
        $(this).attr("title", "收缩面板");
        enableTooltips();
        hideTooltip();
        return false
    });
    var a = 12;
    try {
        var d = jQuery.jCookie("fontSize");
        if (d != false) {
            a = parseInt(d)
        }
    } catch (f) {}
    if (a == 12) {
        $(".fontChange").eq(2).find("a").addClass("fontChange_cur")
    } else {
        if (a == 14) {
            $(".fontChange").eq(1).find("a").addClass("fontChange_cur")
        } else {
            if (a == 16) {
                $(".fontChange").eq(0).find("a").addClass("fontChange_cur")
            }
        }
    }
    $(".fontChange a").each(function () {
        $(this).click(function () {
            $(".fontChange a").removeClass("fontChange_cur");
            $(this).addClass("fontChange_cur");
            var g = parseInt($(this).attr("setFont"));
            jQuery.jCookie("fontSize", g);
            try {
                document.getElementById("frmright").contentWindow.changeFont(g)
            } catch (h) {}
            try {
                document.getElementById("frmleft").contentWindow.changeFont(g)
            } catch (h) {}
        })
    });
    if ($("#vmenu").length > 0) {
        exitMenu = 1;
        $(".vbaseItem").height(30);
        $(".vbaseItem").css({
            overflow: "hidden"
        })
    }
    if ($("#menu").length > 0) {
        hexitMenu = 1
    }
    enableTooltips()
});

function autoReset() {
    try {
        document.getElementById("frmleft").contentWindow.scrollContent()
    } catch (f) {}
    try {
        document.getElementById("frmright").contentWindow.scrollContent()
    } catch (f) {}
    var a = document.documentElement.clientHeight;
    try {
        var g = a - leftOverHeight - parseInt($("#lbox").css("paddingTop")) - parseInt($("#lbox").css("paddingBottom"));
        $("#bs_left").height(g)
    } catch (f) {}
    try {
        var h = a - rightOverHeight - parseInt($("#rbox").css("paddingTop")) - parseInt($("#rbox").css("paddingBottom"));
        $("#bs_right").height(h)
    } catch (f) {}
    if (exitMenu == 1) {
        try {
            $(".vbaseItem").show();
            var b = parseInt((g - 10) / 30) - 1;
            var d = parseInt($(".vbaseItem").length);
            for (var c = b; c < d; c++) {
                $(".vbaseItem").eq(c).hide()
            }
        } catch (f) {}
    }
}
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
        f.onmousemove = Locate
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
function Locate(c) {
    var a = 0,
        f = 0;
    if (c == null) {
            c = window.event
        }
    if (c.pageX || c.pageY) {
            a = c.pageX;
            f = c.pageY
        } else {
            if (c.clientX || c.clientY) {
                if (document.documentElement.scrollTop) {
                    a = c.clientX + document.documentElement.scrollLeft;
                    f = c.clientY + document.documentElement.scrollTop
                } else {
                    a = c.clientX + document.body.scrollLeft;
                    f = c.clientY + document.body.scrollTop
                }
            }
        }
    document.getElementById("btc").style.top = (f + 10) + "px";
    var d = window.document.documentElement.clientWidth;
    var b = $("#btc").width();
    if (d - b < a - 20) {
            document.getElementById("btc").style.left = (d - b) + "px"
        } else {
            document.getElementById("btc").style.left = (a - 20) + "px"
        }
}
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
};