$(document).ready(function(){return d3.csv("2015-beijing.csv",function(e){var t,n,a,r,i,c,l,d,u,o,g,h,s,p,v,f;for(t=document.getElementById("container").getBoundingClientRect(),e=e.map(function(e){return{date:new Date(e["Date (LST)"]),value:e.Value}}),n=d3.extent(e.map(function(e){return parseInt(e.value)<0?0:parseInt(e.value)})),a=d3.extent(e.map(function(e){return e.date.getTime()})),r={},i=0,c=e.length;c>i;++i)l=e[i],l.idx=r[l.value]=((d=r[l.value])?d:0)+1;return u=d3.extent(e.map(function(e){return e.idx})),o=[0,50,100,150,200,300,500,722],console.log(n),g=d3.scale.linear().domain(a).range([0,t.width]),h=d3.scale.linear().domain(u).range([0,t.width]),s=d3.scale.linear().domain(n).range([t.height,0]),p=["#30b0e0","#a1cde5","#bbcedd","#c3a470","#51332a","#cd6260","#ba171a","#821c3f"],console.log(t),v=d3.select("#container").append("svg").attr({width:t.width+"px",height:t.height+"px",viewBox:[-20,-20,t.width+20,t.height+20].join(" "),preserveAspectRatio:"xMidYMid"}),v.selectAll("circle").data(e).enter().append("circle"),v.selectAll("circle").attr({r:3,fill:function(e){var t,n,a;for(t=0,n=o.length;n>t&&(a=t,!(e.value<o[a]));++t);return p[a]},cy:function(e){return s(e.value)}}).attr({cx:function(e){return g(e.date)}}),f=0})});
