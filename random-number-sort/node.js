const start = process.hrtime.bigint();
new Array(1000000)
    .fill(0)
    .map(() => Math.round(Math.random() * 1000000))
    .sort()
    .map(value => value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
const end = process.hrtime.bigint();

console.log(`${Math.round((Number(end - start) / 1000000) * 1000) / 1000}ms`);
