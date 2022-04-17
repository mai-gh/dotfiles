#!/usr/bin/env node

const { promisify } = require('util');
const exec = promisify(require('child_process').exec)
const os = require('os');
const util = require('util')
const fs = require('fs')

function findInNestedJson(nodes) {
  let next = [];
  for (const node of nodes) {
    if (node.focused) return node;
    else next = next.concat(node.nodes).concat(node.floating_nodes);
  }
  return findInNestedJson(next);
}

async function getFocusedTitle() {
  let execResponse = await exec('i3-msg -t get_tree');
  let { nodes, floating_nodes } = JSON.parse(execResponse.stdout);
  return findInNestedJson(nodes.concat(floating_nodes)).name
}

async function readFile(inputFile) {
  await fs.readFile(inputFile, (err, data) => {
    if (err) {
        console.log('err: ', err)
        throw err
    } else {
        const x = data.toString();
        console.log('x: ', x)
        console.log('data.toString(): ', data.toString())
        return Promise.resolve(x);
    }
  });
  
}

async function main () {
  let freeMem = '';
  let dateArray = [];
  let dateStr = '';
  let focusedWorkspace = '';
  let focusedTitle = '';
  let acad = '';
  let acadSymbol = '';
  let focusedTitleFixed = '';
  let batPercent = '';
  let printStr = ''
  let textColor = '"#cccccc"'
  while(true) {
    printStr = ''


    focusedTitle = await getFocusedTitle();
    focusedTitleFixed = focusedTitle;
    focusedTitleFixed = focusedTitleFixed.split(String.fromCharCode(92)).join(String.fromCharCode(92,92));
    focusedTitleFixed = focusedTitleFixed.replace(/"/g, '\\"');
    printStr +=  `,[ { "full_text": " ${focusedTitleFixed} ", "color": ${textColor} }, `


    let a = await exec('i3-msg -t get_workspaces');
    focusedWorkspace = JSON.parse(a.stdout).find(x => x.focused == true).num;
    printStr +=  `{ "full_text": " ${focusedWorkspace} ", "color": ${textColor} }, `


    freeMem = ~~(os.freemem() / (1024**2));
    printStr +=  `{ "full_text": " ${freeMem}M ", "color": ${textColor} }, `

/*
    let bb = await exec('xinput --query-state 12 | grep valuator');
    let valuator = [];
    //eval(valuator)
    eval(bb.stdout.replace(/\t/g, ''))
    //console.log(valuator)

    let posX = valuator[0]
    let posY = valuator[1]
    
    printStr +=  `{ "full_text": "\\tX:${posX} Y:${posY} \\t", "color": "#6666ff" }, `
*/

    await fs.readFile('/sys/class/power_supply/BAT1/capacity', 
                      function (err, data) {batPercent = data.toString().trim()});
    await fs.readFile('/sys/class/power_supply/ACAD/online',
                      function (err, data) {acad = data.toString().trim()});
    if (acad == '1') {
      printStr +=  `{ "full_text": " ✓ ", "color": "#00ff00" }, `
    } else {
      printStr +=  `{ "full_text": " ${batPercent}% ", "color": "#ff0000" }, `
    }


    dateArray = Date().split(' ');
    dateArray.splice(3, 1); // remove year
    dateStr = dateArray.splice(0, 4).join(' '); // get only  everything after HH:MM:SS
    printStr += `{ "full_text": " ${dateStr} ", "color": ${textColor} } ]`


    process.stdout.write(printStr);
    await new Promise(resolve => setTimeout(resolve, 1000));
  };
}


console.log('{ "version": 1 }[[]')
main()
