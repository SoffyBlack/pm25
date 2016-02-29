<- $ document .ready

(data) <- d3.csv \2015-beijing.csv

/*
console.log data
console.log data.0
console.log new Date(data.0["Date (LST)"])
console.log data.0["Value"]
*/
box = document.getElementById \container .getBoundingClientRect!
data = data.map -> {} <<< {date: new Date(it["Date (LST)"]), value: it["Value"]}

valuerange = d3.extent data.map -> if parseInt(it.value) < 0 => 0 else parseInt(it.value)
daterange = d3.extent data.map -> it.date.getTime!
hash = {}
for item in data =>
  item.idx = hash[item.value] = (if hash[item.value] => that else 0) + 1
idxrange = d3.extent data.map -> it.idx


region = [0 50 100 350 400 722]
console.log valuerange
xscale = d3.scale.linear!domain daterange .range [0,box.width]
xscale2 = d3.scale.linear!domain idxrange .range [0,box.width]
yscale = d3.scale.linear!domain valuerange .range [box.height,0]
#colors = d3.scale.linear!domain region .range <[#1d3263 #226c87 #f8d672 #e48e11 #e03215 #ab2321]>
colors = <[#1d3263 #226c87 #f8d672 #e48e11 #e03215 #ab2321]>

console.log box
svg = d3.select \#container .append \svg .attr do
  width: "#{box.width}px"
  height: "#{box.height}px"
  viewBox: [-20, -20, box.width + 20, box.height + 20].join(" ")
  preserveAspectRatio: "xMidYMid"

svg.selectAll \circle .data data
  .enter!append \circle

svg.selectAll \circle 
  .attr do
    r: 3
    fill: -> 
      for i from 0 til region.length => if it.value < region[i] => break
      colors[i]
    cy: -> yscale it.value
  .attr do
    cx: -> xscale it.date


state = 0

setInterval (->
  state := 1 - state
  if state == 0 =>
    svg.selectAll \circle .transition!duration 2000 
      .attr do
        cx: -> xscale it.date
  else if state == 1 =>
    svg.selectAll \circle .transition!duration 2000 
      .attr do
        cx: -> xscale2 it.idx

), 4000
