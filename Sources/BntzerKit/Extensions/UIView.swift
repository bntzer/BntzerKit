//
//  File.swift
//  
//
//  Created by Steve Bentz on 8/31/21.
//

#if os(iOS)
import Foundation
import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        self.layer.mask = mask
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        /*
        layer.addShadow(offset: offset, color: color, radius: radius, opacity: opacity)
        
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor*/
    }
    
    func corners(_ cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
    func border(color: UIColor, width: Int) {
        layer.borderColor = color.cgColor
        layer.borderWidth = CGFloat(width)
    }
    
    // MARK: - NSLayoutConstraint Convenience Methods
    func addAutoLayoutSubview(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func insertAutoLayoutSubview(_ view: UIView, belowSubview: UIView) {
        insertSubview(view, belowSubview: belowSubview)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func insertAutoLayoutSubview(_ view: UIView, aboveSubview: UIView) {
        insertSubview(view, aboveSubview: aboveSubview)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBorders(color: UIColor, thickness: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = thickness
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    var allSubviews: Set<UIView> {
        var all = subviews
        for subview in all {
            all.append(contentsOf: subview.allSubviews)
        }
        return Set(all)
    }
    
    func firstSubview<T>(ofType classType: T.Type) -> T? {
        return allSubviews.first { $0 is T } as? T
    }
    
    func firstSubview(withClassName className: String) -> UIView? {
        return allSubviews.first { type(of: $0).description() == className }
    }
    
    func subviews<T>(ofType classType: T.Type) -> [T] {
        return allSubviews.compactMap { $0 as? T }
    }
    
    func firstSuperview<T>(ofType classType: T.Type) -> T? {
        if let superview = superview as? T {
            return superview
        } else {
            return superview?.firstSuperview(ofType: classType)
        }
    }
    
    @discardableResult
    func activate(_ constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func addSubview(_ subview: UIView, withConstraints constraints: ((_ subview: UIView, _ superview: UIView) -> [NSLayoutConstraint])) -> [NSLayoutConstraint] {
        addAutoLayoutSubview(subview)
        let constraints = constraints(subview, self)
        return activate(constraints)
    }
    
    // MARK: - Layout
    
    public func activate(_ constraints: NSLayoutConstraint...) {
        NSLayoutConstraint.activate(constraints)
    }
    
    public func fillSuperview(priority p: UILayoutPriority = .required) {
        guard let superview = self.superview else { return }
        activate(
            leftAnchor.constraint(equalTo: superview.leftAnchor, priority: p),
            rightAnchor.constraint(equalTo: superview.rightAnchor, priority: p),
            topAnchor.constraint(equalTo: superview.topAnchor, priority: p),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, priority: p)
        )
    }
    
    @discardableResult
    public func fillSuperviewLayoutMargins(priority p: UILayoutPriority = .required) -> (left: NSLayoutConstraint, right: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
        guard let superview = self.superview else {
            fatalError("\(self) has not been added as a subview")
        }
        let left = leftAnchor.constraint(equalTo: superview.leftMargin, priority: p)
        let right = rightAnchor.constraint(equalTo: superview.rightMargin, priority: p)
        let top = topAnchor.constraint(equalTo: superview.topMargin, priority: p)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomMargin, priority: p)
        activate(left, right, top, bottom)
        return (left, right, top, bottom)
    }
    
    func centerInSuperview() {
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            ])
    }
    
    func fillLayoutGuide(_ layoutGuide: UILayoutGuide) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Layout Shortcuts
    func rightToRight(constant: CGFloat = 0) {
        guard let superview = self.superview else { return }
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: constant).isActive = true
    }
    
    // MARK: - Layout Margins Guide Shortcut
    
    var leftMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.leftAnchor
    }
    
    var leadingMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.leadingAnchor
    }
    
    var rightMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.rightAnchor
    }
    
    var trailingMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.trailingAnchor
    }
    
    var centerXMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.centerXAnchor
    }
    
    var widthMargin: NSLayoutDimension {
        return layoutMarginsGuide.widthAnchor
    }
    
    var topMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.topAnchor
    }
    
    var bottomMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.bottomAnchor
    }
    
    var centerYMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.centerYAnchor
    }
    
    var heightMargin: NSLayoutDimension {
        return layoutMarginsGuide.heightAnchor
    }
    
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    func rotate(degrees: CGFloat) {
        self.transform = CGAffineTransform.identity

        let radians = degrees / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        
        self.transform = rotation
    }
    
    func cropCircle() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    /// Constrain 4 edges of `self` to specified `view`.
    func edges(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }
    
    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }
    
    func blur(_ effect: UIBlurEffect.Style = .dark) {
        let blurEffect = UIBlurEffect(style: effect)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
    }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }
    
    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }}

extension Comparable {
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        return min(max(self, lowerBound), upperBound)
    }
}

//extension UIView {
//    func firstSubview<T>(ofType classType: T.Type) -> T? {
//        return allSubviews.first { $0 is T } as? T
//    }
//
//    func firstSubview(withClassName className: String) -> UIView? {
//        return allSubviews.first { type(of: $0).description() == className }
//    }
//
//    public func subviews<T>(ofType classType: T.Type) -> [T] {
//        return allSubviews.compactMap { $0 as? T }
//    }
//}


// MARK: - Constraint + Priority

extension UILayoutPriority {
    static let stackViewWrapping = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
}

extension UIView {
    func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axes: NSLayoutConstraint.Axis...) {
        for axis in axes {
            setContentCompressionResistancePriority(priority, for: axis)
        }
    }
    
    func setContentHuggingPriority(_ priority: UILayoutPriority, for axes: NSLayoutConstraint.Axis...) {
        for axis in axes {
            setContentHuggingPriority(priority, for: axis)
        }
    }
}

// MARK: NSLayoutDimension + Float
public extension NSLayoutDimension {
    
    // Anchor
    
    func constraint(equalTo anchor: NSLayoutDimension, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    // Constant
    
    func constraint(equalToConstant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualToConstant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualToConstant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualToConstant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualToConstant: c)
        constraint.priority = p
        return constraint
    }
    
    // Anchor, Constant
    
    func constraint(equalTo anchor: NSLayoutDimension, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    // Anchor, Multiplier
    
    func constraint(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, multiplier: m)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, multiplier: m)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, multiplier: m)
        constraint.priority = p
        return constraint
    }
    
    // Anchor, Multiplier, Constant
    
    func constraint(equalTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, multiplier: m, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, multiplier: m, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier m: CGFloat, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, multiplier: m, constant: c)
        constraint.priority = p
        return constraint
    }
}

// MARK: NSLayoutYAxisAnchor + Float
public extension NSLayoutYAxisAnchor {
    
    // Anchor
    
    func constraint(equalTo anchor: NSLayoutYAxisAnchor, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    // Anchor, Constant
    
    func constraint(equalTo anchor: NSLayoutYAxisAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
}

// MARK: NSLayoutXAxisAnchor + Float
public extension NSLayoutXAxisAnchor {
    
    // Anchor
    
    func constraint(equalTo anchor: NSLayoutXAxisAnchor, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor)
        constraint.priority = p
        return constraint
    }
    
    // Anchor, Constant
    
    func constraint(equalTo anchor: NSLayoutXAxisAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(lessThanOrEqualTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
    
    func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant c: CGFloat, priority p: UILayoutPriority) -> NSLayoutConstraint {
        let constraint = self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        constraint.priority = p
        return constraint
    }
}

protocol ReuseIdentifier {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
  
  /// Return a suggested name that can be used as an cellIdentifier.
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
}

extension UIView: ReuseIdentifier {}
#endif
