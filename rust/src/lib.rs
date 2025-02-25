#[cxx::bridge(namespace = "ned::rust")]
mod ffi {
    extern "Rust" {
        fn print_from_rust();
    }
}

fn print_from_rust() {
    println!("Hello from Rust!");
}