const STR: &str = "            The President of the United States   ";

fn main() {
    let now = std::time::Instant::now();
    let _trimmed = (0..1000000).map(|_i| STR.trim()).collect::<Vec<&str>>();
    println!("{}ms", now.elapsed().as_micros() as f32 / 1000.0);
}
