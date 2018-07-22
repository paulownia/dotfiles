import test from 'ava';
import ac from '../lib/ast_clock';

test(t => {
    const ast = ac.convert(new Date('2018-05-31 07:03:15'));
    t.is(ast.getHours(), 21);
    t.is(ast.getMinutes(), 5);  // 15秒 * 20倍速 / 60(s/m)
});
test(t => {
    const ast = ac.convert(new Date('2018-06-01 00:00:00'));
    t.is(ast.getHours(), 0)
    t.is(ast.getMinutes(), 0)
});
test(t => {
    const ast = ac.convert(new Date('2018-06-13 10:22:30'));
    t.is(ast.getHours(), 15);
    t.is(ast.getMinutes(), 30);  // 90秒 * 20倍速 / 60(s/m)
});
