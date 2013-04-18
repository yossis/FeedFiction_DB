// Copyright 2010 Mike Brevoort http://mike.brevoort.com @mbrevoort
// 
// v5.0 jquery-facebook-multi-friend-selector
// 
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
// 
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
(function(a){var b=function(b,c){var d=a(b),e=this,f=[],g,h=0,i=0,j,k=a.extend({max_selected:-1,max_selected_message:"{0} of {1} selected",pre_selected_friends:[],exclude_friends:[],friend_fields:"id,name",sorter:function(a,b){var c=a.name.toLowerCase(),d=b.name.toLowerCase();return c<d?-1:c>d?1:0},labels:{selected:"Selected",filter_default:"Start typing a name",filter_title:"Find Friends:",all:"All",max_selected_message:"{0} of {1} selected"}},c||{}),l,m=function(a){var b={};for(var c=0,d=a.length;c<d;c++)b[a[c]]="";return b};d.html("<div id='jfmfs-friend-selector'>    <div id='jfmfs-inner-header'>        <span class='jfmfs-title'>"+k.labels.filter_title+" </span><input type='text' id='jfmfs-friend-filter-text' value='"+k.labels.filter_default+"'/>"+"        <a class='filter-link selected' id='jfmfs-filter-all' href='#'>"+k.labels.all+"</a>"+"        <a class='filter-link' id='jfmfs-filter-selected' href='#'>"+k.labels.selected+" (<span id='jfmfs-selected-count'>0</span>)</a>"+(k.max_selected>0?"<div id='jfmfs-max-selected-wrapper'></div>":"")+"    </div>"+"    <div id='jfmfs-friend-container'></div>"+"</div>");var n=a("#jfmfs-friend-container"),o=a("#jfmfs-friend-selector"),p=m(k.pre_selected_friends),q=m(k.exclude_friends),r;FB.api("/me/friends?fields="+k.friend_fields,function(b){var c=b.data.sort(k.sorter),e={},g=[],h="";a.each(c,function(a,b){b.id in q||(h=b.id in p?"selected":"",g.push("<div class='jfmfs-friend "+h+" ' id='"+b.id+"'><img/><div class='friend-name'>"+b.name+"</div></div>"))}),n.append(g.join("")),f=a(".jfmfs-friend",d),f.bind("inview",function(b,c){a(this).attr("src")===undefined&&a("img",a(this)).attr("src","//graph.facebook.com/"+this.id+"/picture"),a(this).unbind("inview")}),s()}),this.getSelectedIds=function(){var b=[];return a.each(d.find(".jfmfs-friend.selected"),function(c,d){b.push(a(d).attr("id"))}),b},this.getSelectedIdsAndNames=function(){var b=[];return a.each(d.find(".jfmfs-friend.selected"),function(c,d){b.push({id:a(d).attr("id"),name:a(d).find(".friend-name").text()})}),b},this.clearSelected=function(){r.removeClass("selected")};var s=function(){r=a(".jfmfs-friend",d),j=r.first().offset().top;for(var b=0,c=r.length;b<c;b++)if(a(r[b]).offset().top===j)h++;else{i=a(r[b]).offset().top-j;break}d.delegate(".jfmfs-friend","click",function(b){var c=k.max_selected===1,f=a(this).hasClass("selected"),g=a(".jfmfs-friend.selected").length>=k.max_selected,h=n.find(".selected").attr("id")===a(this).attr("id");if(!c&&!f&&u()&&g)return;c&&!h&&n.find(".selected").removeClass("selected"),a(this).toggleClass("selected"),a(this).removeClass("hover");if(a(this).hasClass("selected"))if(!l)l=a(this);else if(b.shiftKey){var i=a(this).index(),j=l.index(),m=Math.max(i,j),o=Math.min(i,j);for(var q=o;q<=m;q++){var s=a(r[q]);!s.hasClass("hide-non-selected")&&!s.hasClass("hide-filtered")&&u()&&a(".jfmfs-friend.selected").length<k.max_selected&&a(r[q]).addClass("selected")}}l=a(this),p(),u()&&v(),d.trigger("jfmfs.selection.changed",[e.getSelectedIdsAndNames()])}),a("#jfmfs-filter-selected").click(function(b){b.preventDefault(),r.not(".selected").addClass("hide-non-selected"),a(".filter-link").removeClass("selected"),a(this).addClass("selected")}),a("#jfmfs-filter-all").click(function(b){b.preventDefault(),r.removeClass("hide-non-selected"),a(".filter-link").removeClass("selected"),a(this).addClass("selected")}),d.find(".jfmfs-friend:not(.selected)").live("hover",function(b){b.type=="mouseover"&&a(this).addClass("hover"),b.type=="mouseout"&&a(this).removeClass("hover")}),d.find("#jfmfs-friend-filter-text").keyup(function(){var b=a(this).val();clearTimeout(g),g=setTimeout(function(){b==""?r.removeClass("hide-filtered"):(o.find(".friend-name:not(:Contains("+b+"))").parent().addClass("hide-filtered"),o.find(".friend-name:Contains("+b+")").parent().removeClass("hide-filtered")),m()},400)}).focus(function(){a.trim(a(this).val())=="Start typing a name"&&a(this).val("")}).blur(function(){a.trim(a(this).val())==""&&a(this).val("Start typing a name")}),d.find(".jfmfs-button").hover(function(){a(this).addClass("jfmfs-button-hover")},function(){a(this).removeClass("jfmfs-button-hover")});var f=function(){var b=window.innerHeight,c=document.compatMode;if(c||!a.support.boxModel)b=c=="CSS1Compat"?document.documentElement.clientHeight:document.body.clientHeight;return b},m=function(){var b=n.innerHeight(),c=n.scrollTop(),d=n.offset().top,e,f,g=0,k=!1,l=a(".jfmfs-friend:not(.hide-filtered )");a.each(l,function(e,m){g++;if(m!==null){m=a(l[e]),f=j+i*Math.ceil(g/h)-c-d;if(f+i>=-10&&f-i<b)m.data("inview",!0),m.trigger("inview",[!0]),k=!0;else if(k)return!1}})},p=function(){a("#jfmfs-selected-count").html(t())};n.bind("scroll",a.debounce(250,m)),v(),m(),p(),d.trigger("jfmfs.friendload.finished")},t=function(){return a(".jfmfs-friend.selected").length},u=function(){return k.max_selected>0},v=function(){var b=k.labels.max_selected_message.replace("{0}",t()).replace("{1}",k.max_selected);a("#jfmfs-max-selected-wrapper").html(b)}};a.fn.jfmfs=function(c){return this.each(function(){var d=a(this);if(d.data("jfmfs"))return;var e=new b(this,c);d.data("jfmfs",e)})},a.expr[":"].Contains=function(b,c,d){return a(b).text().toUpperCase().indexOf(d[3].toUpperCase())>=0}})(jQuery),$.debounce===undefined&&function(a,b){var c=a.jQuery||a.Cowboy||(a.Cowboy={}),d;c.throttle=d=function(a,d,e,f){function i(){function l(){h=+(new Date),e.apply(c,k)}function m(){g=b}var c=this,i=+(new Date)-h,k=arguments;f&&!g&&l(),g&&clearTimeout(g),f===b&&i>a?l():d!==!0&&(g=setTimeout(f?m:l,f===b?a-i:a))}var g,h=0;return typeof d!="boolean"&&(f=e,e=d,d=b),c.guid&&(i.guid=e.guid=e.guid||c.guid++),i},c.debounce=function(a,c,e){return e===b?d(a,c,!1):d(a,e,c!==!1)}}(this);