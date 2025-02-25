#[cxx::bridge(namespace = "ned::rust")]
mod ffi {
    extern "Rust" {
        fn print_from_rust();
    }

    unsafe extern "C++" {
        include!("my_file.h");

        fn hello_from_cpp();
    }
}

fn print_from_rust() {
    println!("Hello from Rust!");

    ffi::hello_from_cpp();
}