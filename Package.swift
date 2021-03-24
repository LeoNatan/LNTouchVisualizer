// swift-tools-version:5.1

import PackageDescription

let package = Package(
	name: "LNTouchVisualizer",
	platforms: [
		.iOS(.v12),
		.macOS(.v10_15)
	],
	products: [
		.library(
			name: "LNTouchVisualizer",
			type: .dynamic,
			targets: ["LNTouchVisualizer"]),
		.library(
			name: "LNTouchVisualizer-Static",
			type: .static,
			targets: ["LNTouchVisualizer"]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "LNTouchVisualizer",
			dependencies: [],
			path: "LNTouchVisualizer",
			exclude: [
				"LNTouchVisualizerExample",
				"Supplements"
			],
			publicHeadersPath: "include",
			cSettings: [
				.headerSearchPath("."),
				.headerSearchPath("Private"),
			]),
	]
)
