import test from 'ava';
import df from '../lib/df';

test(t => {
    const x = df.defenseForce(new Date('2018-05-29 01:03:15'));
    t.true(x.current.includes('闇朱の獣牙兵団'));
    t.true(x.next.includes('紫炎の鉄機兵団a'));
    t.is(x.nextAfter, 57);
})
