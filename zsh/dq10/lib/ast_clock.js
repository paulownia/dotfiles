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
  const {minutes, next} = calcMinutesToNext(h, m ,s);

  /* eslint-disable no-console */
  console.log(pad`現在のアストルティア時刻は${h}時${m}分${s}秒`);
  console.log(`約${minutes}分で${next}になります`);
  /* eslint-enable no-console */
}
module.exports.print = print;

function calcMinutesToNext(h, m, s) {
  const next = (6 <= h && h < 18) ? '夜' : '朝';

  const dh = (29 - h) % 12 + 1;
  const minutes = Math.round((dh * 3600 - m * 60 - s) / 1200);

  return {minutes, next};
}

module.exports.calcMinutesToNext = calcMinutesToNext;

