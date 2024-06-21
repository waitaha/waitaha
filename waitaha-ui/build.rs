fn main() {
    slint_build::compile("ui/hello.slint").unwrap();
    slint_build::print_rustc_flags().unwrap();
}
