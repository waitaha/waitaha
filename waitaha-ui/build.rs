use slint_build::CompilerConfiguration;

fn main() {
    slint_build::compile_with_config(
        "ui/main.slint",
        CompilerConfiguration::new().with_style(String::from("material")),
    )
    .unwrap();
    slint_build::print_rustc_flags().unwrap();
}
