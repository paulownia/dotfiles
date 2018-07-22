/* eslint-parserOption: sourceType: module */
import test from 'ava';
import df from '../lib/defence_force';

test(t => {
    const x = df.getCurrent(new Date('2018-05-31 07:03:15'));
    t.true(x.current.includes('闇朱の獣牙兵団'));
    t.true(x.next.includes('紫炎の鉄機兵団'));
    t.is(x.nextAfter, 57);
});
test(t => {
    const x = df.getCurrent(new Date('2018-06-01 00:00:00'));
    t.true(x.current.includes('闇朱の獣牙兵団'));
    t.true(x.next.includes('紫炎の鉄機兵団'));
    t.is(x.nextAfter, 120);
});
test(t => {
    const x = df.getCurrent(new Date('2018-06-13 00:00:00'));
    t.true(x.current.includes('闇朱の獣牙兵団'));
    t.true(x.next.includes('紫炎の鉄機兵団'));
    t.is(x.nextAfter, 120);
});
