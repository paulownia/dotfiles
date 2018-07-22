function convert(now = new Date()) {
    const jst0h = new Date();
    jst0h.setHours(0);
    jst0h.setMinutes(0);
    jst0h.setSeconds(0);
    jst0h.setMilliseconds(0);

    // 現在時刻との差分をとって、0:00からの経過時間を取得
    const diff = now.getTime() - jst0h.getTime();

    // ASTの時刻を求める。今日の0:00からの経過時間を20倍したDateオブジェクトを作成
    return new Date(jst0h.getTime() + diff * 20);
}
module.exports.convert = convert;

function print(jst = new Date()) {
    const ast = convert(jst);

    // フォーマットして出力
    const pad = (n) => n.toString().padStart(2, '0');
    const h = pad(ast.getHours());
    const m = pad(ast.getMinutes());
    const s = pad(ast.getSeconds());

    // eslint-disable-next-line no-console
    console.log(`${h}時${m}分${s}秒`);
}
module.exports.print = print;
