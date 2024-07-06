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
| rust     | 109.91    |
| c        | 151.00    |
| go       | 308.40    |
| elixir   | 377.03    |
| julia    | 408.80    |
| ruby     | 494.27    |
| java     | 582.40    |
| node     | 592.86    |
| python   | 852.99    |

### [string-trim](/string-trim)
| Language | Time (ms) |
| -------- | --------- |
| rust     | 16.32     |
| node     | 107.34    |
