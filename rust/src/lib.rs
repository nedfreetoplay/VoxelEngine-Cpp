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

#[path ="ffi/logger.rs"]
mod logger;

fn print_from_rust() {
    let l = logger::new_logger("lib.rs");
    logger::log(&l, 0, "Hello from Rust");

    ffi::hello_from_cpp();
}