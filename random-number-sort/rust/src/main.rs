use std::time::Instant;
use rand::Rng;
use thousands::Separable;
use itertools::sorted;

fn main() {
    let now = Instant::now();
    
    let mut rng = rand::thread_rng();
    let values = sorted(
        (0..100000)
            .map(|_| rng.gen_range(0..100000))
    )
            .map(|a| a.separate_with_commas())
            .collect::<Vec<String>>();
    let duration = now.elapsed();
    
    println!("{}ms", duration.as_micros() as f32 / 1000.0);
}
