﻿!function(e){"use strict";var t,n,a,o=[],r=".sm2-bar-ui";o.on={},n={stopOtherSounds:!0,excludeClass:"sm2-exclude"},soundManager.setup({html5PollingInterval:50,flashVersion:9}),soundManager.onready(function(){var e,n,l;if(e=a.dom.getAll(r),e&&e.length)for(n=0,l=e.length;l>n;n++)o.push(new t(e[n]))}),t=function(t){function r(){n.stopOtherSounds&&soundManager.stopAll()}function l(e){e&&(B.on&&B.on[e]?B.on[e](B):o.on[e]&&o.on[e](B))}function s(e,t){var n=Math.floor(e/1e3),a=Math.floor(n/3600),o=Math.floor(n/60)-Math.floor(60*a),r=Math.floor(n-3600*a-60*o);return t?(a?a+":":"")+(a&&10>o?"0"+o:o)+":"+(10>r?"0"+r:r):{min:o,sec:r}}function i(e){var t=e.getElementsByTagName("a");t.length&&(e=t[0]),T.playlistTarget.innerHTML='<ul class="sm2-playlist-bd"><li>'+e.innerHTML.replace(w.loadFailedCharacter,"")+"</li></ul>",T.playlistTarget.getElementsByTagName("li")[0].scrollWidth>T.playlistTarget.offsetWidth&&(T.playlistTarget.innerHTML='<ul class="sm2-playlist-bd"><li><marquee>'+e.innerHTML+"</marquee></li></ul>")}function u(t){var n=soundManager.createSound({url:t,volume:O,whileplaying:function(){var e,t,n=100;e=Math.min(n,Math.max(0,n*(this.position/this.durationEstimate)))+"%",t=Math.min(100,Math.max(0,100*this.position/this.durationEstimate))+"%",this.duration&&(T.progress.style.left=e,T.progressBar.style.width=t,T.time.innerHTML=s(this.position,!0))},onbufferchange:function(e){e?a.css.add(T.o,"buffering"):a.css.remove(T.o,"buffering")},onplay:function(){a.css.swap(T.o,"paused","playing"),l("play")},onpause:function(){a.css.swap(T.o,"playing","paused"),l("pause")},onresume:function(){a.css.swap(T.o,"paused","playing")},whileloading:function(){this.isHTML5||(T.duration.innerHTML=s(this.durationEstimate,!0))},onload:function(e){e?T.duration.innerHTML=s(this.duration,!0):this._iO&&this._iO.onerror&&this._iO.onerror()},onerror:function(){var t,n,a;t=N.getItem(),t&&w.loadFailedCharacter&&(T.playlistTarget.innerHTML=T.playlistTarget.innerHTML.replace("<li>","<li>"+w.loadFailedCharacter+" "),N.data.playlist&&N.data.playlist[N.data.selectedIndex]&&(n=N.data.playlist[N.data.selectedIndex].getElementsByTagName("a")[0],a=n.innerHTML,-1===a.indexOf(w.loadFailedCharacter)&&(n.innerHTML=w.loadFailedCharacter+" "+a))),l("error"),navigator.userAgent.match(/mobile/i)?b.next():(N.data.timer&&e.clearTimeout(N.data.timer),N.data.timer=e.setTimeout(b.next,2e3))},onstop:function(){a.css.remove(T.o,"playing")},onfinish:function(){var e,t;a.css.remove(T.o,"playing"),T.progress.style.left="0%",e=N.data.selectedIndex,l("finish"),t=N.getNext(),t&&N.data.selectedIndex!==e?(N.select(t),i(t),r(),this.play({url:N.getURL()})):l("end")}});return n}function d(t){soundManager.canPlayURL(t.href)&&(N.data.timer&&(e.clearTimeout(N.data.timer),N.data.timer=null),M||(M=u(t.href)),M.stop(),N.select(t.parentNode),i(t.parentNode),T.progress.style.left="0px",T.progressBar.style.width="0px",r(),M.play({url:t.href,position:0}))}function m(){function t(){return g.playlist}function n(e){var n,a;return null===g.selectedIndex?e:(n=t(),e=void 0!==e?e:g.selectedIndex,e=Math.max(0,Math.min(e,n.length)),a=n[e])}function o(e){var n,a,o,r;if(r=-1,n=t())for(a=0,o=n.length;o>a;a++)if(n[a]===e){r=a;break}return r}function r(){return null!==g.selectedIndex&&g.selectedIndex++,g.playlist.length>1?g.selectedIndex>=g.playlist.length&&(g.loopMode?g.selectedIndex=0:g.selectedIndex--):g.selectedIndex=null,n()}function l(){return g.selectedIndex--,g.selectedIndex<0&&(g.loopMode?g.selectedIndex=g.playlist.length-1:g.selectedIndex++),n()}function s(){var e,t,n;for(e=a.dom.getAll(T.playlist,"."+x.selected),t=0,n=e.length;n>t;t++)a.css.remove(e[t],x.selected)}function i(e){var t,n,r,l,i,u,d;s(),e&&(d=a.dom.ancestor("li",e),a.css.add(d,x.selected),n=e.offsetTop,r=n+e.offsetHeight,l=T.playlistContainer.offsetHeight,i=T.playlist.scrollTop,u=8,r>l+i?T.playlist.scrollTop=r-l+u:i>n&&(T.playlist.scrollTop=e.offsetTop-u)),t=o(e),g.selectedIndex=t}function u(e){var t;e=e||0,t=n(e),t&&d(t.getElementsByTagName("a")[0])}function m(){var e,t;return e=n(),e&&(t=e.getElementsByTagName("a")[0].href),t}function c(){return T.playlist?void(g.playlist=T.playlist.getElementsByTagName("li")):(e.console&&console.warn&&console.warn("refreshDOM(): playlist node not found?"),!1)}function f(){T.playlistTarget=a.dom.get(T.o,".sm2-playlist-target"),T.playlistContainer=a.dom.get(T.o,".sm2-playlist-drawer"),T.playlist=a.dom.get(T.o,".sm2-playlist-bd")}function p(){O=soundManager.defaultOptions.volume,f(),c(),a.css.has(T.o,x.playlistOpen)&&e.setTimeout(function(){b.menu(!0)},1)}var g;return g={playlist:[],selectedIndex:0,loopMode:!1,timer:null},p(),{data:g,refresh:c,getNext:r,getPrevious:l,getItem:n,getURL:m,playItemByOffset:u,select:i}}function c(e){return e&&(e.which&&2===e.which||void 0===e.which&&1!==e.button)?!0:void 0}function f(t){return t?(I.volume.x=a.position.getOffX(t),I.volume.y=a.position.getOffY(t),I.volume.width=t.offsetWidth,I.volume.height=t.offsetHeight,I.volume.backgroundSize=parseInt(a.style.get(t,"background-size"),10),void(e.navigator.userAgent.match(/msie|trident/i)&&(I.volume.backgroundSize=I.volume.backgroundSize/I.volume.width*100))):!1}function p(e){var t,n;return n=e.target||e.srcElement,c(e)?!0:("a"!==n.nodeName.toLowerCase()&&(t=n.getElementsByTagName("a"),t&&t.length&&(n=n.getElementsByTagName("a")[0])),a.css.has(n,"sm2-volume-control")?(f(n),a.events.add(document,"mousemove",b.adjustVolume),a.events.add(document,"mouseup",b.releaseVolume),b.adjustVolume(e)):void 0)}function g(t){var o,r,l,s,i,u,m;if(o=t||e.event,r=o.target||o.srcElement,r&&r.nodeName){if(s=r.nodeName.toLowerCase(),"a"!==s&&r.parentNode){do r=r.parentNode,s=r.nodeName.toLowerCase();while("a"!==s&&r.parentNode);if(!r)return!1}if("a"===s&&(u=r.href,soundManager.canPlayURL(u)?a.css.has(r,n.excludeClass)||(d(r),m=!0):(l=r.href.lastIndexOf("#"),-1!==l&&(i=r.href.substr(l+1),i&&b[i]&&(m=!0,b[i](t)))),m))return a.events.preventDefault(o)}}function v(e){var t,n,o,r,l,s;return t=T.progressTrack,n=a.position.getOffX(t),o=t.offsetWidth,r=e.clientX-n,l=r/o,s=M,s&&s.duration&&(s.setPosition(s.duration*l),s._iO&&s._iO.whileplaying&&s._iO.whileplaying.apply(s)),e.preventDefault&&e.preventDefault(),!1}function h(e){return a.events.remove(document,"mousemove",v),a.css.remove(T.o,"grabbing"),a.events.remove(document,"mouseup",h),a.events.preventDefault(e),!1}function y(){t||console.warn("init(): No playerNode element?"),T.o=t,e.navigator.userAgent.match(/msie [678]/i)&&a.css.add(T.o,x.legacy),e.navigator.userAgent.match(/mobile/i)&&a.css.add(T.o,x.noVolume),T.progress=a.dom.get(T.o,".sm2-progress-ball"),T.progressTrack=a.dom.get(T.o,".sm2-progress-track"),T.progressBar=a.dom.get(T.o,".sm2-progress-bar"),T.volume=a.dom.get(T.o,"a.sm2-volume-control"),T.volume&&f(T.volume),T.duration=a.dom.get(T.o,".sm2-inline-duration"),T.time=a.dom.get(T.o,".sm2-inline-time"),N=new m,E=N.getItem(0),N.select(E),E&&i(E),a.events.add(T.o,"mousedown",p),a.events.add(T.o,"click",g),a.events.add(T.progressTrack,"mousedown",function(e){return c(e)?!0:(a.css.add(T.o,"grabbing"),a.events.add(document,"mousemove",v),a.events.add(document,"mouseup",h),v(e))})}var x,T,w,N,M,b,I,E,O,L,B;return x={disabled:"disabled",selected:"selected",active:"active",legacy:"legacy",noVolume:"no-volume",playlistOpen:"playlist-open"},T={o:null,playlist:null,playlistTarget:null,playlistContainer:null,time:null,player:null,progress:null,progressTrack:null,progressBar:null,duration:null,volume:null},w={loadFailedCharacter:'<span title="Failed to load/play." class="load-error">✖</span>'},I={volume:{x:0,y:0,width:0,height:0,backgroundSize:0}},b={play:function(t){var n,a,o;return void 0===t||isNaN(t)?(o=t,o&&o.target&&(n=o.target||o.srcElement,a=n.href),a&&-1===a.indexOf("#")||(a=T.playlist.getElementsByTagName("a")[0].href),M||(M=u(a)),M.playState||r(),M.togglePause(),void(M.paused&&N.data.timer&&(e.clearTimeout(N.data.timer),N.data.timer=null))):N.playItemByOffset(t)},pause:function(){M&&M.readyState&&M.pause()},resume:function(){M&&M.readyState&&M.resume()},stop:function(){return b.pause()},next:function(){var t,n;N.data.timer&&(e.clearTimeout(N.data.timer),N.data.timer=null),n=N.data.selectedIndex,t=N.getNext(!0),t&&N.data.selectedIndex!==n&&d(t.getElementsByTagName("a")[0])},prev:function(){var e,t;t=N.data.selectedIndex,e=N.getPrevious(),e&&N.data.selectedIndex!==t&&d(e.getElementsByTagName("a")[0])},shuffle:function(e){var t=e?e.target||e.srcElement:a.dom.get(T.o,".shuffle");t&&!a.css.has(t,x.disabled)&&(a.css.toggle(t.parentNode,x.active),N.data.shuffleMode=!N.data.shuffleMode)},repeat:function(e){var t=e?e.target||e.srcElement:a.dom.get(T.o,".repeat");t&&!a.css.has(t,x.disabled)&&(a.css.toggle(t.parentNode,x.active),N.data.loopMode=!N.data.loopMode)},menu:function(e){var t;t=a.css.has(T.o,x.playlistOpen),!N||N.data.selectedIndex||L||(T.playlist.scrollTop=0,L=!0),"boolean"==typeof e&&e||(t||(T.playlistContainer.style.height="0px"),t=a.css.toggle(T.o,x.playlistOpen)),T.playlistContainer.style.height=(t?T.playlistContainer.scrollHeight:0)+"px"},adjustVolume:function(t){var n,o,r,l,s;return l=0,r=T.volume,void 0===t?!1:t&&void 0!==t.clientX?(n=(100-I.volume.backgroundSize)/2,l=Math.max(0,Math.min(1,(t.clientX-I.volume.x)/I.volume.width)),r.style.clip="rect(0px, "+I.volume.width*l+"px, "+I.volume.height+"px, "+I.volume.width*(n/100)+"px)",o=n/100*I.volume.width,s=100*Math.max(0,Math.min(1,(t.clientX-I.volume.x-o)/(I.volume.width-2*o))),M&&M.setVolume(s),O=s,a.events.preventDefault(t)):(arguments.length&&e.console&&e.console.warn&&console.warn("Bar UI: call setVolume("+t+") instead of adjustVolume("+t+")."),b.setVolume.apply(this,arguments))},releaseVolume:function(){a.events.remove(document,"mousemove",b.adjustVolume),a.events.remove(document,"mouseup",b.releaseVolume)},setVolume:function(e){var t,n,a,o,r,l;void 0===e||isNaN(e)||(T.volume&&(o=T.volume,t=I.volume.backgroundSize,n=(100-t)/2,a=I.volume.width*(n/100),r=a,l=r+(I.volume.width-2*a)*(e/100),o.style.clip="rect(0px, "+l+"px, "+I.volume.height+"px, "+r+"px)"),M&&M.setVolume(e),O=e)}},y(),B={on:null,actions:b,dom:T,playlistController:N}},a={array:function(){function e(e){var t;return function(n,a){return t=n[e]<a[e]?-1:n[e]>a[e]?1:0}}function t(e){var t,n,a;for(t=e.length-1;t>0;t--)n=Math.floor(Math.random()*(t+1)),a=e[t],e[t]=e[n],e[n]=a;return e}return{compare:e,shuffle:t}}(),css:function(){function e(e,t){return void 0!==e.className?new RegExp("(^|\\s)"+t+"(\\s|$)").test(e.className):!1}function t(t,n){return t&&n&&!e(t,n)?void(t.className=(t.className?t.className+" ":"")+n):!1}function n(t,n){return t&&n&&e(t,n)?void(t.className=t.className.replace(new RegExp("( "+n+")|("+n+")","g"),"")):!1}function a(e,a,o){var r={className:e.className};n(r,a),t(r,o),e.className=r.className}function o(a,o){var r,l;return r=e(a,o),l=r?n:t,l(a,o),!r}return{has:e,add:t,remove:n,swap:a,toggle:o}}(),dom:function(){function e(e,t){var n,a,o;return 1===arguments.length?(n=document.documentElement,a=e):(n=e,a=t),n&&n.querySelectorAll&&(o=n.querySelectorAll(a)),o}function t(){var t=e.apply(this,arguments);return t&&t.length?t[t.length-1]:t&&0===t.length?null:t}function n(e,t,n){if(!t||!e)return t;if(e=e.toUpperCase(),n&&t&&t.nodeName===e)return t;for(;t&&t.nodeName!==e&&t.parentNode;)t=t.parentNode;return t&&t.nodeName===e?t:null}return{ancestor:n,get:t,getAll:e}}(),position:function(){function e(e){var t=0;if(e.offsetParent)for(;e.offsetParent;)t+=e.offsetLeft,e=e.offsetParent;else e.x&&(t+=e.x);return t}function t(e){var t=0;if(e.offsetParent)for(;e.offsetParent;)t+=e.offsetTop,e=e.offsetParent;else e.y&&(t+=e.y);return t}return{getOffX:e,getOffY:t}}(),style:function(){function t(t,n){var a;return t.currentStyle?a=t.currentStyle[n]:e.getComputedStyle&&(a=document.defaultView.getComputedStyle(t,null).getPropertyValue(n)),a}return{get:t}}(),events:function(){var t,n,a;return t=function(t,a,o){var r={detach:function(){return n(t,a,o)}};return e.addEventListener?t.addEventListener(a,o,!1):t.attachEvent("on"+a,o),r},n=void 0!==e.removeEventListener?function(e,t,n){return e.removeEventListener(t,n,!1)}:function(e,t,n){return e.detachEvent("on"+t,n)},a=function(e){return e.preventDefault?e.preventDefault():(e.returnValue=!1,e.cancelBubble=!0),!1},{add:t,preventDefault:a,remove:n}}(),features:function(){function t(e){var t=i.style[e];return void 0!==t?e:null}function n(e){try{i.style[u]=e}catch(t){return!1}return!!i.style[u]}var a,o,r,l,s,i,u;return i=document.createElement("div"),o=e.requestAnimationFrame||e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||null,a=o?function(){return o.apply(e,arguments)}:null,r={transform:{ie:t("-ms-transform"),moz:t("MozTransform"),opera:t("OTransform"),webkit:t("webkitTransform"),w3:t("transform"),prop:null},rotate:{has3D:!1,prop:null},getAnimationFrame:a},r.transform.prop=r.transform.w3||r.transform.moz||r.transform.webkit||r.transform.ie||r.transform.opera,r.transform.prop&&(u=r.transform.prop,s={css_2d:"rotate(0deg)",css_3d:"rotate3d(0,0,0,0deg)"},n(s.css_3d)?(r.rotate.has3D=!0,l="rotate3d"):n(s.css_2d)&&(l="rotate"),r.rotate.prop=l),i=null,r}()},e.sm2BarPlayers=o,e.sm2BarPlayerOptions=n,e.SM2BarPlayer=t}(window);
