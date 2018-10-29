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
    const pad = function(s, ...v) {
        return String.raw(s, ...v.map(i => i.toString().padStart(2, '0')));
    };
    const h = ast.getHours();
    const m = ast.getMinutes();
    const s = ast.getSeconds();

    // eslint-disable-next-line no-console
    console.log(pad`現在のアストルティア時刻は${h}時${m}分${s}秒`);

    let t = 0;
    if (6 <= h && h < 18) {
        t = Math.round(((18 - h) * 3600 - m * 60 - s) / 1200);

        // eslint-disable-next-line no-console
        console.log(`約${t}分で夜になります`);
    } else {
        const xh = (h + 6) % 24;
        t = Math.round(((12 - xh) * 3660 - m * 60 - s) / 1200);

        // eslint-disable-next-line no-console
        console.log(`約${t}分で朝になります`);
    }
}
module.exports.print = print;
