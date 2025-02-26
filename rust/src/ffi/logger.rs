#[cxx::bridge(namespace = "debug")]
mod ffi {
    // extern "Rust" {
    //     fn print_from_rust();
    // }

    unsafe extern "C++" {
        include!("debug/Logger.hpp");

        type Logger;
        type LogLevel;

        fn new_logger(name: &str) -> UniquePtr<Logger>;
        fn log(self: &Logger, level: LogLevel, message: &str);
    }

    impl UniquePtr<Logger> {}

    unsafe extern "C++" {
        fn print() -> LogLevel;
        fn debug() -> LogLevel;
        fn info() -> LogLevel;
        fn warning() -> LogLevel;
        fn error() -> LogLevel;
    }
}

pub use ffi::Logger;

pub use cxx::UniquePtr;

pub fn new_logger(name: &str) -> UniquePtr<Logger> {
    ffi::new_logger(name)
}

pub fn log(logger: &Logger, level: LogLevel, message: &str) {
    ffi::log(logger, level, message);
}