# Ubud

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=5a240e4e7463140001ebe6ea&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/5a240e4e7463140001ebe6ea/build/latest?branch=master)
[![Build Status](https://travis-ci.org/lkmfz/Ubud.svg?branch=master)](https://travis-ci.org/lkmfz/Ubud)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Ubud.svg)](https://cocoapods.org/pods/Ubud)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
<a href="https://swift.org">
 <img src="https://img.shields.io/badge/Swift-4-orange.svg"
      alt="Swift" />
</a>
<a href="https://developer.apple.com/xcode">
  <img src="https://img.shields.io/badge/Xcode-9-blue.svg"
      alt="Xcode">
</a>
<a href="https://opensource.org/licenses/MIT">
  <img src="https://img.shields.io/badge/License-MIT-red.svg"
      alt="MIT">
</a>
<a href="https://github.com/lkmfz/Ubud/issues">
   <img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat"
        alt="Contributions Welcome">
</a>

<p>
  <img src="https://raw.githubusercontent.com/lkmfz/Ubud/master/Resources/screenshot1.png" title="screenshot 1">
  <img src="https://raw.githubusercontent.com/lkmfz/Ubud/master/Resources/screenshot2.png" title="screenshot 2">
</p>

## Requirements
**iOS 9** or later

## Installation
### [CocoaPods](https://cocoapods.org/)
To integrate Ubud using CocoaPods, add the following to your Podfile:
````ruby
pod 'Ubud'
````
### [Carthage](https://cocoapods.org/)
To integrate Ubud using Carthage, add the following to your Cartfile:
````ruby
github 'lkmfz/Ubud'
````
Run `carthage update` to build the framework and drag the built `Ubud.framework` into your Xcode project.

## Usage

To present the `UbudController` view, just put this one line code.
```swift
UbudController.show(presentedBy: self, dataSource: self, paginationDelegate: self, atIndex: indexPath.item)
```

### UbudControllerDataSource

```swift
enum PhotoDataSource {
    case image(UIImage)
    case url(String)
}
```

To display images from list of URL`String`

```swift
// MARK: - UbudControllerDataSource

func numberOfOPhotos(in controller: UbudController) -> Int {
  return urls.count
}

func imageSourceForItem(in controller: UbudController, atIndex index: Int) -> PhotoDataSource {
  let imageURL = urls[index].url.absoluteString
  return .url(imageURL)
}
```

To display images from list of `UIImage`
```swift
// MARK: - UbudControllerDataSource

func numberOfOPhotos(in controller: UbudController) -> Int {
    return images.count
}

func imageSourceForItem(in controller: UbudController, atIndex index: Int) -> PhotoDataSource {
    let image = images[index]
    return .image(image)
}
```

### UbudControllerDelegate
Customize the `UbudController` style
```swift
// MARK: - UbudControllerDelegate

func statusBarHidden(in controller: UbudController) -> Bool {
    return false
}

func statusBarStyle(in controller: UbudController) -> UIStatusBarStyle {
    return .lightContent
}

func dismissButtonContent(in controller: UbudController) -> DismissButtonContent {
    return .text("Dismiss")
}
```

### UbudControllerPaginationDelegate

```swift
enum ImagesPaginationStyle {
    case textIndicator
    case dotIndicator
}
```

Customize the pagination indicator style
```swift
// MARK: - UbudControllerPaginationDelegate

func imagesPaginationStyle(in controller: UbudController) -> ImagesPaginationStyle? {
    return .dotIndicator
}

func imagesPaginationDidChange(in controller: UbudController, atIndex index: Int) {
    /// Do anything on tapped image page content
}
```

## License
Ubud is released under the [MIT License](https://github.com/lkmfz/Ubud/blob/master/LICENSE.md).
