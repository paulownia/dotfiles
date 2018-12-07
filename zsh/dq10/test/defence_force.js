/* eslint-parserOption: sourceType: module */

import test from 'ava';
import df from '../lib/defence_force';

test(t => {
  const x = df.getCurrent(new Date('2018-09-20 15:03:15')); // 木曜日
  t.true(x.current.includes('朱'));
  t.true(x.next.includes('紫'));
  t.is(x.nextInMinutes, 57);
});
test(t => {
  const x = df.getCurrent(new Date('2018-09-18 23:00:00'));  // 火曜日
  t.true(x.current.includes('銀'));
  t.true(x.next.includes('碧'));
  t.is(x.nextInMinutes, 60);
});
test(t => {
  const x = df.getCurrent(new Date('2018-09-19 23:00:00'));  // 水曜日
  t.true(x.current.includes('銀'));
  t.true(x.next.includes('ランダム'));
  t.is(x.nextInMinutes, 60);
});
test(t => {
  const x = df.getCurrent(new Date('2018-09-22 23:03:15'));  // 土曜
  t.true(x.current.includes('朱'));
  t.true(x.next.includes('紫'));
  t.is(x.nextInMinutes, 57);
});
