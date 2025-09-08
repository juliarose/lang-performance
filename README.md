## Language Benchmarks

The benchmarks are simple and are meant to test the performance of the languages in a few different scenarios. This is not meant to be definitive or even particularly accurate, but provides a rough idea of the performance of each language in these scenarios.

## Run
```bash
bash tests.sh
```

## Results
Testing on AMD Ryzen 9 5900X 12-Core Processor

### [random-number-sort]((/random-number-sort))
| Language | Time (ms) |
| -------- | --------- |
| rust     | 74.96     |
| c        | 144.60    |
| go       | 310.78    |
| elixir   | 414.85    |
| julia    | 422.00    |
| ruby     | 499.67    |
| node     | 613.30    |
| java     | 682.80    |
| python   | 1205.34   |

### [string-trim](/string-trim)
| Language | Time (ms) |
| -------- | --------- |
| rust     | 11.27     |
| node     | 150.72    |
| elixir   | 433.68    |
