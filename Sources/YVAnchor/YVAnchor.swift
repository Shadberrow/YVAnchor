import UIKit

public protocol YVAnchor {}

extension UIView: YVAnchor {}

extension YVAnchor where Self: UIView {

    public var leading : NSLayoutXAxisAnchor { get { return leadingAnchor } }
    public var trailing: NSLayoutXAxisAnchor { get { return trailingAnchor } }
    public var top     : NSLayoutYAxisAnchor { get { return topAnchor } }
    public var bottom  : NSLayoutYAxisAnchor { get { return bottomAnchor } }
    public var left    : NSLayoutXAxisAnchor { get { return leftAnchor } }
    public var right   : NSLayoutXAxisAnchor { get { return rightAnchor } }
    public var xAxis   : NSLayoutXAxisAnchor { get { return centerXAnchor } }
    public var yAxis   : NSLayoutYAxisAnchor { get { return centerYAnchor } }
    public var centerX : NSLayoutXAxisAnchor { get { return centerXAnchor } }
    public var centerY : NSLayoutYAxisAnchor { get { return centerYAnchor } }
    public var width   : NSLayoutDimension   { get { return widthAnchor } }
    public var height  : NSLayoutDimension   { get { return heightAnchor } }

    @discardableResult
    public func pin<T>(_ side: NSLayoutConstraint.Attribute, to: NSLayoutAnchor<T>, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint()

        switch side {
        case .top       : constraint = top.constraint(equalTo: to as! NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: constant)
        case .left      : constraint = left.constraint(equalTo: to as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: constant)
        case .leading   : constraint = leading.constraint(equalTo: to as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: constant)
        case .right     : constraint = right.constraint(equalTo: to as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: -constant)
        case .trailing  : constraint = trailing.constraint(equalTo: to as! NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: -constant)
        case .bottom    : constraint = bottom.constraint(equalTo: to as! NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: -constant)
        default: break
        }

        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func size(width: CGFloat = 0, height: CGFloat = 0) -> (width: NSLayoutConstraint?, height: NSLayoutConstraint?) {
        translatesAutoresizingMaskIntoConstraints = false
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
        if width    != 0 {
            widthConstraint = widthAnchor.constraint(equalToConstant: width)
            widthConstraint.isActive = true
        }
        if height   != 0 {
            heightConstraint = heightAnchor.constraint(equalToConstant: height)
            heightConstraint.isActive = true
        }
        return (width: widthConstraint, height: heightConstraint)
    }

    @discardableResult
    public func size(_ size: CGSize) -> (width: NSLayoutConstraint?, height: NSLayoutConstraint?) {
        return self.size(width: size.width, height: size.height)
    }

    public func centered(in view: UIView, constant: CGPoint = CGPoint(x: 0, y: 0)) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant.x).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant.y).isActive = true
    }

    @discardableResult
    public func centerX(in view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func centerY(in view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func square(_ side: CGFloat) -> (width: NSLayoutConstraint?, height: NSLayoutConstraint?) {
        return size(width: side, height: side)
    }

    @discardableResult
    public func square(_ side: CGFloat, cornerRadius radius: CGFloat) -> (width: NSLayoutConstraint?, height: NSLayoutConstraint?) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return size(width: side, height: side)
    }

    @discardableResult
    public func circle(_ radius: CGFloat) -> (width: NSLayoutConstraint?, height: NSLayoutConstraint?) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return size(width: radius*2, height: radius*2)
    }

    public func fill(in view: UIView, constants: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        pin(.top, to: view.top, constant: constants.top)
        pin(.left, to: view.left, constant: constants.left)
        pin(.right, to: view.right, constant: constants.right)
        pin(.bottom, to: view.bottom, constant: constants.bottom)
    }

}


extension YVAnchor where Self: UIView {

    @discardableResult
    public func width(_ width: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: width)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func width(equalTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalTo: dimension, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func width(lessThanOrEqualTo dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: m)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func width(lessThanOrEqualToConstant constant: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func width(greaterThanOrEqualTo dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: m)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func width(greaterThanOrEqualToConstant constant: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }

}



extension YVAnchor where Self: UIView {

    @discardableResult
    public func height(_ height: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: height)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func height(equalTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalTo: dimension, multiplier: multiplier)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func height(lessThanOrEqualTo dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: m)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func height(lessThanOrEqualToConstant constant: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func height(greaterThanOrEqualTo dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(greaterThanOrEqualTo: dimension, multiplier: m)
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    public func height(greaterThanOrEqualToConstant constant: CGFloat = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }

}
