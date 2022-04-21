const start = process.hrtime.bigint();

for (let i = 0; i < 1000000; i++) {
    let trimmed = "            The President of the United States   ".trim();
}

const end = process.hrtime.bigint();

console.log(`${Math.round((Number(end - start) / 1000000) * 1000) / 1000}ms`);
