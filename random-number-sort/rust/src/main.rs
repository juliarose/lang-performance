use std::time::Instant;
use rand::Rng;
use thousands::Separable;

fn main() {
    let now = Instant::now();
    
    let mut rng = rand::rng();
    let mut values = (0..1000000)
        .map(|_| rng.random_range(0..1000000))
        .collect::<Vec<u32>>();
    
    values.sort_unstable();
    
    let _values = values
        .iter()
        .map(|a| a.separate_with_commas())
        .collect::<Vec<String>>();
    let duration = now.elapsed();
    
    println!("{}ms", duration.as_micros() as f32 / 1000.0);
}
