console.time('perf');
new Array(100000)
    .fill(0)
    .map(() => Math.round(Math.random() * 100000))
    .sort()
    .map(value => value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
console.timeEnd('perf');
