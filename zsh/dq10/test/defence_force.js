/* eslint-parserOption: sourceType: module */
import test from 'ava';
import df from '../lib/defence_force';

test(t => {
    const x = df.getCurrent(new Date('2018-09-20 15:03:15'));
    t.true(x.current.includes('闇朱の獣牙兵団'));
    t.true(x.next.includes('蒼怨の屍獄兵団'));
    t.is(x.nextAfter, 57);
});
test(t => {
    const x = df.getCurrent(new Date('2018-09-18 23:00:00'));
    t.true(x.current.includes('紫炎の鉄機兵団'));
    t.true(x.next.includes('深碧の造魔兵団'));
    t.is(x.nextAfter, 60);
});
test(t => {
    const x = df.getCurrent(new Date('2018-09-19 23:00:00'));
    t.true(x.current.includes('ランダム'));
    t.true(x.next.includes('闇朱の獣牙兵団'));
    t.is(x.nextAfter, 120);
});
test(t => {
    const x = df.getCurrent(new Date('2018-09-22 23:03:15'));
    t.true(x.current.includes('闇朱の獣牙兵団'));
    t.true(x.next.includes('蒼怨の屍獄兵団'));
    t.is(x.nextAfter, 57);
});
