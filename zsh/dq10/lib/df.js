'use strict';

const [magenta, red, green, blue, bold] = [35, 31, 32, 34, 1].map(n => {
    return function(str) {
        return `\u001b[${n}m${str}\u001b[0m`;
    };
});

function defenseForce(d = new Date()) {
    const e = [
        red`闇朱の獣牙兵団`,
        magenta`紫炎の鉄機兵団`,
        green`深碧の造魔兵団`,
        blue`蒼炎の屍獄兵団`,
        bold`ランダム`];

    const pattern = e.length;
    const timeSpan = (pattern - 1) * 120 + 60;

    const min = (d.getDay() * 1440 + d.getHours() * 60 + d.getMinutes() + 360) % timeSpan;

    const current = (min / 120) | 0;
    const next = (current + 1) % pattern;

    return {
        current: e[current],
        next: e[next],
        nextAfter: (current === pattern - 1) ? 60 - min % 60 : 120 - min % 120
    };
}

module.exports.defenseForce = defenseForce;

function printEnemy(arg) {
    if (arg == null) {
        const {current, next, nextAfter} = defenseForce();
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

        const {current, next, nextAfter} = defenseForce(d);
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
