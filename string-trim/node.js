const start = process.hrtime.bigint();
let str = "            The President of the United States   ";
let strs = [];
for (let i = 0; i < 1000000; i++) {
    strs.push(str.trim());
}

const end = process.hrtime.bigint();

console.log(`${Math.round((Number(end - start) / 1000000) * 1000) / 1000}ms`);
