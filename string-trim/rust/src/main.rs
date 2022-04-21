fn main() {
    let now = std::time::Instant::now();
    for _i in 0..1000000 {
        let s = "            The President of the United States   ";
        let _trimmed = s.trim();
    }
    println!("{}ms", now.elapsed().as_micros() as f32 / 1000.0);
}
