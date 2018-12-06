'use strict';

const [magenta, red, green, blue, silver, bold] = [35, 31, 32, 34, 33, 1].map(n => {
  return function(str) {
    return `\u001b[${n}m${str}\u001b[0m`;
  };
});

function getCurrent(d = new Date()) {
  const b = blue`蒼怨の屍獄兵団`;
  const r = red`闇朱の獣牙兵団`;
  const m = magenta`紫炎の鉄機兵団`;
  const g = green`深碧の造魔兵団`;
  const s = silver`銀甲の凶蟲兵団`;
  const k = bold`ランダム`;

  const e = [m, s, g, b, s, k, r];

  const current = ((d.getDay() * 24) + d.getHours()) % e.length;

  let nextAfter = 60 - d.getMinutes();
  let next = (current + 1) % e.length;
  if (e[current] === e[next]) {
    next = (current + 2) % e.length;
    nextAfter = nextAfter + 60;
  }

  return {
    current: e[current],
    next: e[next],
    nextAfter: nextAfter
  };
}

module.exports.getCurrent = getCurrent;

function printEnemy(arg) {
  if (arg == null) {
    const {current, next, nextAfter} = getCurrent();
    puts(`現在の敵は${current}です`);
    puts(`${nextAfter}分後に${next}に変わります`);
    process.exit(0);
  }

  const h = Number.parseInt(arg);
  if (0 <= h && h < 24) {
    const d = new Date();
    d.setMinutes(0);
    d.setSeconds(0);
    d.setHours((h < d.getHours()) ? h + 24 : h);

    const {current, next, nextAfter} = getCurrent(d);
    puts(`${d.getMonth() + 1}月${d.getDate()}日${d.getHours()}時の敵は${current}です`);
    d.setMinutes(nextAfter + d.getMinutes());
    puts(`${d.getHours()}時に${next}に変わります`);

    process.exit(0);
  } else {
    process.exit(1);
  }
}

module.exports.printEnemy = printEnemy;

function puts(str) {
  process.stdout.write(str);
  process.stdout.write('\n');
}
