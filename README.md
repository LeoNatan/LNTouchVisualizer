# LNTouchVisualizer

Touch visualizing framework for iOS.

[![GitHub release](https://img.shields.io/github/release/LeoNatan/LNTouchVisualizer.svg)](https://github.com/LeoNatan/LNTouchVisualizer/releases) [![GitHub stars](https://img.shields.io/github/stars/LeoNatan/LNTouchVisualizer.svg)](https://github.com/LeoNatan/LNTouchVisualizer/stargazers) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/LeoNatan/LNTouchVisualizer/master/LICENSE) <span class="badge-paypal"><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BR68NJEJXGWL6" title="Donate to this project using PayPal"><img src="https://img.shields.io/badge/paypal-donate-yellow.svg?style=flat" alt="PayPal Donation Button" /></a></span>

[![GitHub issues](https://img.shields.io/github/issues-raw/LeoNatan/LNTouchVisualizer.svg)](https://github.com/LeoNatan/LNTouchVisualizer/issues) [![GitHub contributors](https://img.shields.io/github/contributors/LeoNatan/LNPopupController.svg)](https://github.com/LeoNatan/LNTouchVisualizer/graphs/contributors) ![](https://img.shields.io/badge/swift%20package%20manager-compatible-green)

<p align="center"><img src="Supplements/touchvis.gif" width="360"/></p>



## Adding to Your Project

### Swift Package Manager

Swift Package Manager is the recommended way to integrate LNTouchVisualizer in your project.

LNTouchVisualizer supports SPM versions 5.1.0 and above. To use SPM, you should use Xcode 11 to open your project. Click `File` -> `Swift Packages` -> `Add Package Dependency`, enter `https://github.com/LeoNatan/LNTouchVisualizer`. Select the version you’d like to use.

You can also manually add the package to your Package.swift file:

```swift
.package(url: "https://github.com/LeoNatan/LNTouchVisualizer.git", from: "1.0")
```

And the dependency in your target:

```swift
.target(name: "BestExampleApp", dependencies: ["LNTouchVisualizer"]),
```

### Carthage

Add the following to your Cartfile:

```github "LeoNatan/LNTouchVisualizer"```

Make sure you follow the Carthage integration instructions [here](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos).

### Manual

Drag the `LNTouchVisualizer.xcodeproj` project to your project, and add `LNTouchVisualizer.framework` to **Embedded Binaries** in your project target's **General** tab. Xcode should sort everything else on its own.

### CocoaPods

CocoaPods is not supported. There are many reasons for this. Instead of CocoaPods, use Carthage. You can continue using CocoaPods for for your other dependencies and Swift Package Manager for `LNTouchVisualizer`.

## Using the Framework

### Swift

While the framework is written in Objective C, it uses modern Objective C syntax, so using the framework in Swift is very easy and intuitive.

### Project Integration

Import the module in your project:

```swift
import LNTouchVisualizer
```

### Touch Visualization

The easiest way to enable touch visualization for your window scene is to add the following code in your scene delegate:

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
	guard let scene = (scene as? UIWindowScene) else { return }
	scene.touchVisualizerEnabled = true
 
	//This is to configure the system touch visualizer window.
	let rippleConfig = LNTouchConfig.ripple
	rippleConfig.fillColor = .systemRed
	scene.touchVisualizerWindow.touchRippleConfig = rippleConfig
}
```

This will enable touch visualization for your entire scene by adding a passthrough window for touch visualizations, while allowing you to use your own windows for your app’s UI.

If you’d like to use a touch visualization window on your own, check out the `LNTouchVisualizerWindow.h` header for more information.



