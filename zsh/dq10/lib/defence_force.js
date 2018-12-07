'use strict';

const 獣 = '闇朱の獣牙兵団';
const マシン = '紫炎の鉄機兵団';
const ゴーレム = '深碧の造魔兵団';
const ゾンビ ='蒼怨の屍獄兵団';
const 虫 = '銀甲の凶蟲兵団';
const ランダム = 'ランダム';

const nameToAnsiColorCode = {
  [獣]: 31,        // red
  [マシン]: 35,    // magenta
  [ゴーレム]: 32,  // green
  [ゾンビ]: 34,    // blue
  [虫]: 33,        // yellow
  [ランダム]: 1    // bolf
};

// サイクル、日曜日の0時スタートでサイクルを定義、1時間毎の敵を記述
const cycle = [
  マシン,
  虫,
  ゴーレム,
  ゾンビ,
  虫,
  ランダム,
  獣,
];

function printColor(strings, ...values) {
  const colored = values.map(val => {
    const code = nameToAnsiColorCode[val];
    if (code) {
      return `\u001b[${code}m${val}\u001b[0m`;
    } else {
      return val;
    }
  });
  process.stdout.write(String.raw(strings, ...colored));
  process.stdout.write('\n');
}

function getCurrent(d = new Date()) {

  const current = ((d.getDay() * 24) + d.getHours()) % cycle.length;


  let nextInMinutes = 60 - d.getMinutes();
  let next = (current + 1) % cycle.length;
  if (cycle[current] === cycle[next]) {
    next = (next + 1) % cycle.length;
    nextInMinutes += 60;
  }

  var nextChangedAt = new Date(d.getTime() + nextInMinutes * 60 * 1000);

  return {
    current: cycle[current],
    next: cycle[next],
    nextInMinutes,
    nextChangedAt,
  };
}

module.exports.getCurrent = getCurrent;

function printEnemy(arg) {
  if (arg == null) {
    const {current, next, nextInMinutes} = getCurrent();
    printColor`現在の敵は${current}です`;
    printColor`${nextInMinutes}分後に${next}に変わります`;
    process.exit(0);
  }

  const h = Number.parseInt(arg);
  if (0 <= h && h < 24) {
    const d = new Date();
    d.setMinutes(0);
    d.setSeconds(0);
    d.setHours((h < d.getHours()) ? h + 24 : h);

    const {current, next, nextChangedAt} = getCurrent(d);
    printColor`${d.getMonth() + 1}月${d.getDate()}日${d.getHours()}時の敵は${current}です`;
    printColor`${nextChangedAt.getHours()}時に${next}に変わります`;

    process.exit(0);
  } else {
    process.exit(1);
  }
}

module.exports.printEnemy = printEnemy;

