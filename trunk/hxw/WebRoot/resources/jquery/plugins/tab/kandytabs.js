// JQuery Tab Plugin
// Name:    KandyTabs
// Author:  kandytang[at]msn.com
// Home:    www.jgpy.cn
// Pubdate: 2011-1-27
// Version: 3.1.1001
// LastModify: 2011-10-01 14:58:37
/**
 * 2011-12-15修改
 * 杨建亮
 * 修改except属性的处理。允许自定义样式，去除tab效果。
 * 声明为except的tab，只需要加上class="tabLink"
 */
(function ($) {
	$.fn.KandyTabs = function (o) {
		var p = {
			classes: "kandyTabs",
			id: "",
			type: "tab",
			trigger: "mouseover",
			action: "toggle",
			custom: {},
			delay: 200,
			last: 400,
			current: 1,
			direct: "top",
			except: "",
			child: [],
			ready: {},
			done: {},
			auto: false,
			stall: 5000,
			play: true,
			process: false,
			ctrl: false,
			nav: false,
			loop: false,
			column: 0,
			lang: {
				first: ["\u5DF2\u662F\u9996\u4E2A", "&lt;"],
				prev: ["\u524D\u4E00\u4E2A", "&lt;"],
				next: ["\u540E\u4E00\u4E2A", "&gt;"],
				last: ["\u5DF2\u662F\u672B\u4E2A", "&gt;"],
				empty: "\u6682\u65E0\u5185\u5BB9",
				play: ["\u64AD\u653E", "&lt;&lt;"],
				pause: ["\u6682\u505C", "&#124;&#124;"]
			}
		};
		var o = $.extend(p, o);
		if (typeof o.ready == "function") o.ready();
		this.each(function () {
			var c = o.current - 1,
				_except = o.except,
				_child = o.child[0],
				_childOptions = o.child[1],
				_stall = o.stall,
				_last = o.last,
				_col = o.column,
				$this = $(this),
				$tab, $title, $body, $btn, $cont, $roll, $process, d, $tmpbtn, $tmpcont, _tmpb, _tmpc, $child = $this.children(),
				_childlen = _all = $child.length,
				i, _process = false,
				_tagname = this.tagName,
				_tag = "div";
			if (o.process && o.auto) _process = true;
			for (i = 0; i < _childlen; i++) {
					if ($child[i].className == "tabbody") return false
				}
			if (_tagname == "DL") {
					$title = $("<dt/>");
					$body = $("<dd/>");
					_tag = "dd"
				} else if (_tagname == "UL" || _tagname == "OL") {
					$title = $("<li/>");
					$body = $("<li/>");
					_tag = "li"
				} else {
					$title = $("<div/>");
					$body = $("<div/>")
				}
			$tab = $(this).addClass(o.classes);
			if (o.id) $tab.attr("id", o.id);
			$tab.data("html", this.innerHTML);
			if (o.type != "fold") $tab.append($title.addClass("tabtitle"), $body.addClass("tabbody"));
			if (_process) $tab.append($process = $('<' + _tag + ' class="tabprocess"/>'));
			/*	
			if (_except != "") {
				var d = $(_except, this);
					_childlen = _childlen - d.length;
					for (i = 0; i < d.length; i++) {
						var e = d[i].tagName,
							_eclass = d[i].className,
							_eid = d[i].id;
						if (_eid != "") _eid = " id='" + _eid + "'";
						if (_eclass != "") _eclass = " " + _eclass;
						if (e.indexOf("H") > -1 || _eclass.toLowerCase().indexOf("title") > -1) {
								$title.before("<" + e + " class='tabexcept" + _eclass + "'" + _eid + ">" + d[i].innerHTML + "</" + e + ">")
							} else {
								$tab.append("<" + e + " class='tabexcept" + _eclass + "'" + _eid + ">" + d[i].innerHTML + "</" + e + ">")
							}
						d.eq(i).remove()
					}
					$child = $this.children()
				}
			*/
			if (_col > 0) {
					_childlen = _childlen / _col;
					if (_childlen.toString().indexOf(".") > -1) _childlen = parseInt(_childlen) + 1;
					for (i = 0; i < _childlen; i++) {
						$child.not(".tabtitle,.tabbody,.tabexcept,.tabprocess").slice(i * _col, i * _col + _col).wrapAll("<" + _tagname + "/>")
					}
					$child = $this.children()
				}
			if (o.type == "slide") {
					for (i = 0; i < _childlen; i++) {
						$tmpcont = $child.eq(i);
						_tmpc = $child[i];
						if (_tmpc.tagName == "A" || _tmpc.tagName == "IMG" || _tmpc.tagName == "IFRAME") {
							$tmpcont = $tmpcont.wrap('<div class="tabcont"/>').parent()
						} else if (_tmpc.tagName == "LI" || _tmpc.tagName == "DD") {
							$tmpcont = $tmpcont.wrap('<div class="tabcont"/>').parent().html($tmpcont.html())
						} else {
							$tmpcont.addClass("tabcont")
						}
						$title.append('<span class="tabbtn">' + (i + 1) + '</span>');
						$body.append($tmpcont)
					}
					_all = _childlen
				} else if (o.type == "fold") {
					_childlen = _childlen / 2;
					if (_childlen.toString().indexOf(".") > -1) _childlen = parseInt(_childlen) + 1;
					for (i = 0; i < _childlen; i++) {
						$child.eq(i * 2).addClass("tabbtn").next().addClass("tabcont")
					}
					if ($(".tabbtn", $tab).length > $(".tabcont", $tab).length) $tab.append('<' + _tag + ' class="tabcont">' + o.lang.empty + '</' + _tag + '>')
				} else {
					_childlen = _childlen / 2;
					if (_childlen.toString().indexOf(".") > -1) _childlen = parseInt(_childlen) + 1;
					for (i = 0; i < _childlen; i++) {
						$tmpbtn = $child.eq(i * 2);
						_tmpb = $child[(i * 2)];
						if (_tmpb.tagName == "A" || _tmpb.tagName == "IMG") {
							$tmpbtn = $tmpbtn.wrap('<span class="tabbtn"/>').parent()
						} else {
							$tmpbtn = $('<span class="tabbtn' + (_tmpb.className ? ' ' + _tmpb.className + '' : '') + '"' + (_tmpb.id ? ' id="' + _tmpb.id + '"' : '') + '>' + _tmpb.innerHTML + '</span>');
							if (o.type != "fold") $child.eq(i * 2).remove()
						}
						$tmpcont = $child.eq(i * 2 + 1);
						_tmpc = $child[(i * 2 + 1)];
						if (_tmpc) {
							if (_tmpc.tagName == "A" || _tmpc.tagName == "IMG" || _tmpc.tagName == "UL" || _tmpc.tagName == "OL" || _tmpc.tagName == "DL" || _tmpc.tagName == "IFRAME") {
								$tmpcont = $tmpcont.wrap('<div class="tabcont"/>').parent()
							} else if (_tmpc.tagName == "LI" || _tmpc.tagName == "DD") {
								$tmpcont = $tmpcont.wrap('<div class="tabcont"/>').parent().html($tmpcont.html())
							} else {
								$tmpcont.addClass("tabcont")
							}
						} else {
							$tmpcont = $('<div class="tabcont">' + o.lang.empty + '</div>')
						}
						$title.append($tmpbtn);
						$body.append($tmpcont)
					}
					_all = Math.round(_childlen)
				}
			$btn = $(".tabbtn", $tab);
			$cont = $(".tabcont", $tab).hide();
			if (o.type != "fold") {
					$btn.eq(c).addClass("tabcur");
					$cont.eq(c).show();
					if (o.direct == "left") $cont.css("float", "left")
				} else {
					if (o.direct == "left") {
						var f = $cont.width();
						$tab.css({
							overflow: "hidden",
							height: $cont.outerHeight()
						});
						$cont.css({
							overflow: "auto",
							float: "left"
						}).show();
						$btn.css({
							overflow: "auto",
							float: "left"
						}).eq(c).addClass("tabcur").next(".tabcont").width(f).siblings(".tabcont:visible").width(0).addClass("tabfold")
					} else {
						$cont.hide();
						$btn.eq(c).addClass("tabcur").next(".tabcont").show()
					}
					if (o.action == "roll") o.action = "slide";
					if (o.action == "slifade") o.action = "fade"
				}
			var g = function (a, b) {
					b && b * 2 > _stall ? b = _stall - 200 : b = b * 2;
					$body.stop(false, true).animate({
						height: $cont.eq(a).height(),
						width: $cont.eq(a).width()
					}, b)
				};
			var h = function (a) {
					switch (o.direct) {
					case "left":
						if (a == 0 && o.loop) {
							$roll.stop(false, true).animate({
								left: -$roll.width() / 2
							}, _last, function () {
								g(a, _last);
								$roll.css("left", 0)
							})
						} else {
							$roll.stop(false, true).animate({
								left: -$cont.eq(a).position().left
							}, _last, g(a, _last))
						}
						break;
					default:
						if (a == 0 && o.loop) {
							$roll.stop(false, true).animate({
								top: -$roll.height() / 2
							}, _last, function () {
								g(a, _last);
								$roll.css("top", 0)
							})
						} else {
							$roll.stop(false, true).animate({
								top: -$cont.eq(a).position().top
							}, _last, g(a, _last))
						}
					}
				};
			var j = function (a) {
					$cont.eq(a).stop(false, true).fadeIn(0, function () {
						$(this).siblings().fadeOut(_last, g(a, _last)).css("z-index", _all)
					}).css("z-index", 0)
				};
			if (o.action == "roll") {
					$body.css({
						position: "relative",
						overflow: "hidden"
					}).height($cont.eq(c).height()).width($cont.eq(c).width());
					$body.wrapInner("<div class='tabroll' style='position:absolute;width:" + $body.width() + "px'/>");
					$cont.show();
					$roll = $(".tabroll", $body);
					if (o.loop) $roll.append($roll.html());
					if (o.direct == "left") {
						var k = 0;
						for (i = 0; i < $cont.length; i++) {
							k += $cont.eq(i).outerWidth(true)
						}
						$roll.width(o.loop ? k * 2 : k)
					}
					setTimeout(function () {
						h(c)
					}, 100)
				};
			if (o.action == "slifade") {
					$body.css({
						position: "relative",
						overflow: "hidden"
					}).height($cont.eq(c).height());
					$cont.css({
						position: "absolute",
						width: $body.width()
					});
					setTimeout(function () {
						j(c)
					}, 100)
				};
			var l = function (a) {
					$btn.eq(a).stop(false, true).addClass("tabcur").siblings(".tabbtn").removeClass("tabcur");
					if (_process && _isProcess) $process.stop().width("").animate({
						width: 0
					}, _stall, function () {
						_isProcess = false
					});
					switch (o.action) {
					case "fade":
						$cont.eq(a).stop(false, true).fadeIn(_last).siblings(".tabcont").hide();
						break;
					case "slide":
						if (o.direct == "left") {
							$cont.eq(a).stop(false, true).animate({
								width: f
							}, _last, function () {
								$(this).removeClass("tabfold")
							}).siblings(".tabcont").animate({
								width: 0
							}, _last, function () {
								$(this).addClass("tabfold")
							})
						} else {
							$cont.eq(a).stop(false, true).slideDown(_last).siblings(".tabcont").slideUp(_last)
						}
						break;
					case "roll":
						h(a);
						break;
					case "slifade":
						j(a);
						break;
					default:
						$cont.eq(a).stop(false, true).show().siblings(".tabcont").hide()
					}
					if (typeof o.custom == "function") o.custom($btn, $cont, a, $this);
					if ($prev) a == 0 ? $prev.addClass("tabprevno").attr("title", o.lang.first[0]) : $prev.removeClass("tabprevno").attr("title", o.lang.prev[0]);
					if ($next) a == $btn.length - 1 ? $next.addClass("tabnextno").attr("title", o.lang.last[0]) : $next.removeClass("tabnextno").attr("title", o.lang.next[0]);
					if ($now) $now.text(a + 1);
					if (o.loop && o.nav) $prev.removeClass("tabprevno").attr("title", o.lang.prev[0]),
					$next.removeClass("tabnextno").attr("title", o.lang.next[0])
				};
			var m, $pause, $play, $nav, $prev, $next, $now, $tabprev, $tabnext, $autostop, _auto = null,
				setAuto = null,
				_isAuto = true,
				_isProcess = true;
			_auto = function () {
					setAuto && clearTimeout(setAuto);
					setAuto = null;
					window.CollectGarbage && CollectGarbage();
					if (o.process) _isProcess = true;
					o.type != "fold" ? $tabnext = $(".tabcur", $title).next() : $tabnext = $(".tabcur", $this).next().next();
					$tabnext.html() == null ? $btn.first().trigger(o.trigger) : $tabnext.trigger(o.trigger);
					if (o.trigger == "mouseover") if (o.process) $process.stop().width("").animate({
						width: 0
					}, _stall);
					setAuto = setTimeout(_auto, _stall)
				};
			if (o.auto) {
					if (o.process) $process.animate({
						width: 0
					}, _stall),
					_isProcess = true;
					setTimeout(_auto, _stall);
					o.type != "fold" ? $autostop = $(".tabtitle,.tabcont", $tab) : $autostop = $this;
					$autostop.mouseover(function () {
						if (o.process) $process.stop().width(""),
						_isProcess = false;
						clearTimeout(setAuto)
					}).mouseout(function () {
						if (o.process) $process.stop().width("").animate({
							width: 0
						}, _stall),
						_isProcess = true;
						if (_isAuto) setAuto = setTimeout(_auto, _stall)
					});
					if (o.ctrl) {
						$tab.append(m = $('<' + _tag + ' class="tabctrl"/>'));
						m.append($pause = $('<b class="tabpause" title="' + o.lang.pause[0] + '">' + o.lang.pause[1] + '</b>'), $play = $('<b class="tabplay" title="' + o.lang.play[0] + '" style="display:none">' + o.lang.play[1] + '</b>'));
						$pause.click(function () {
							$(this).hide();
							if (o.process) $process.stop().hide();
							clearTimeout(setAuto);
							$play.show();
							_isAuto = false
						});
						$play.click(function () {
							$(this).hide();
							if (o.process) $process.show().stop().width("").animate({
								width: 0
							}, _stall);
							setAuto = setTimeout(_auto, _stall);
							$pause.show();
							_isAuto = true
						});
						if (!o.play) {
							$pause.trigger("click")
						}
					}
				}
			if (o.nav) {
					_all = _all.toString();
					if (_all.indexOf(".") > -1) _all = parseInt(_all) + 1;
					$tab.append($nav = $('<' + _tag + ' class="tabnav"/>'));
					$nav.append($prev = $('<em class="tabprev" title="' + o.lang.prev[0] + '">' + o.lang.prev[1] + '</em>'), '<span class="tabpage"/>', $next = $('<em class="tabnext" title="' + o.lang.next[0] + '">' + o.lang.next[1] + '</em>'));
					$("span.tabpage", $nav).append($now = $('<b class="tabnow">' + (c + 1) + '</b>'), '<i>&nbsp;/&nbsp;</i>', '<b class="taball">' + _all + '</b>');
					if (c == 0 && !o.loop) $prev.addClass("tabprevno");
					$prev.mouseover(function () {
						if (_process) $process.stop().width(""),
						_isProcess = false;
						if (o.auto) clearTimeout(setAuto)
					}).mousedown(function () {
						if ($(this).hasClass("tabprevno")) return false;
						$tabprev = $(".tabcur", $title).prev();
						$tabprev.html() == null ? $btn.last().trigger(o.trigger) : $tabprev.trigger(o.trigger);
						if (o.auto) setAuto = setTimeout(_auto, _stall)
					}).mouseup(function () {
						if (o.auto) clearTimeout(setAuto)
					}).mouseout(function () {
						if (_process) $process.animate({
							width: 0
						}, _stall),
						_isProcess = true;
						if (o.auto) setAuto = setTimeout(_auto, _stall)
					});
					$next.mouseover(function () {
						if (_process) $process.stop().width(""),
						_isProcess = false;
						if (o.auto) clearTimeout(setAuto)
					}).mousedown(function () {
						if ($(this).hasClass("tabnextno")) return false;
						$tabnext = $(".tabcur", $title).next();
						$tabnext.html() == null ? $btn.first().trigger(o.trigger) : $tabnext.trigger(o.trigger);
						if (o.auto) setAuto = setTimeout(_auto, _stall)
					}).mouseup(function () {
						if (o.auto) clearTimeout(setAuto)
					}).mouseout(function () {
						if (_process) $process.animate({
							width: 0
						}, _stall),
						_isProcess = true;
						if (o.auto) setAuto = setTimeout(_auto, _stall)
					})
				}
			var n = null;
			if (o.trigger != "mouseover") o.delay = 0;
			$btn.bind(o.trigger, function () {
					var a = $btn.index($(this));
					clearTimeout(n);
					n = setTimeout(function () {
						l(a)
					}, o.delay)
				});
			if (o.trigger == "mouseover") {
					$btn.mouseout(function () {
						clearTimeout(n)
					})
				}
			if (o.type == "fold") {
					$btn.hover(function () {
						$(this).addClass("tabon")
					}, function () {
						$(this).removeClass("tabon")
					})
				}
			if (o.child != "" && $tab.find(_child).length) {
					$(_child).KandyTabs(_childOptions)
				}
			if (typeof o.done == "function") o.done($btn, $cont, $this)
			//TODO add by yangjianliang at 2011-12-15
			if (_except != "") {
				//alert($(_except, this).attr("class"));
				$(_except, this).unbind(o.trigger);
			}
		})
	}
})(jQuery);