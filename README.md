# YVAnchor

# About
Syntax sugar for working with anchors in swift.
Now you will never ever forget to activate your constraint or set `translatesAutoresizingMaskIntoConstraints` parameter 😜

# Usage

Instead of this:
```swift
subview.translatesAutoresizingMaskIntoConstraints = false
subview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
```
Use this:
```swift
subview.pin(.left, to: view.left, constant: 30)
```

# Example

## Sample layout constraints

![](https://github.com/Shadberrow/YVAnchor/blob/master/Resources/demo001.png)

## Animation

![](https://github.com/Shadberrow/YVAnchor/blob/master/Resources/demo002.png)

# Note

Before constraints setup add all subviews to the view hierarchy.
