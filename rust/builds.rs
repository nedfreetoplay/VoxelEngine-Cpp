#[allow(unused_must_use)]
fn main() {
    cxx_build::bridge("src/lib.rs")
        .bridge("src/ffi/logger.rs");
    println!("cargo:rerun-if-changed=src/lib.rs");
    println!("cargo:rerun-if-changed=build.rs");
}