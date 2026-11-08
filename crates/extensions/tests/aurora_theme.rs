//! Ensures the local Aurora theme stays valid as the theme schema evolves.

#[test]
fn aurora_theme_parses_and_validates() {
	let path = concat!(
		env!("CARGO_MANIFEST_DIR"),
		"/../../extensions/themes/aurora.serein-extension"
	);
	let bytes = std::fs::read(path).expect("Aurora theme package exists");
	let package = extensions::parse_package(&bytes).expect("Aurora theme parses");
	assert_eq!(package.manifest.kind, extensions::ExtensionKind::Theme);
	let theme = package.theme.expect("Aurora theme has a theme object");
	theme.validate().expect("Aurora theme validates");
	let style = theme.style;
	assert_eq!(style.widget_radius, Some(14));
	assert_eq!(style.window_radius, Some(16));
	assert_eq!(style.menu_radius, Some(14));
	assert_eq!(style.item_spacing, Some([6, 6]));
	assert_eq!(style.control_height, Some(34));
}
