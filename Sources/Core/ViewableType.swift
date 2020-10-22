//
//  ViewableType.swift
//  SDUIKit
//
//  Created by SoalHunag on 2019/2/19.
//  Copyright © 2019 SoalHuang. All rights reserved.
//

import UIKit
import SnapKit
import SDFoundation

public protocol ViewableType: NSObjectProtocol {
    
    var view: UIView! { get }
    
    var viewController: UIViewController? { get }
}

extension ViewableType {
    
    public var isUserInteractionEnabled: Bool {
        get { return view.isUserInteractionEnabled }
        set { view.isUserInteractionEnabled = newValue }
    }
    
    public var tag: Int {
        get { return view.tag }
        set { view.tag = newValue }
    }
    
    public var layer: CALayer {
        return view.layer
    }
    
    @available(iOS 9.0, *)
    public var canBecomeFocused: Bool {
        return view.canBecomeFocused
    }
    
    @available(iOS 9.0, *)
    public var isFocused: Bool {
        return view.isFocused
    }
    
    @available(iOS 9.0, *)
    public var semanticContentAttribute: UISemanticContentAttribute {
        get { return view.semanticContentAttribute }
        set { view.semanticContentAttribute = newValue }
    }
    
    @available(iOS 10.0, *)
    public var effectiveUserInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        return view.effectiveUserInterfaceLayoutDirection
    }
}

extension ViewableType {
    
    public var frame: CGRect {
        get { return view.frame }
        set { view.frame = newValue }
    }
    
    public var bounds: CGRect {
        get { return view.bounds }
        set { view.bounds = newValue }
    }
    
    public var center: CGPoint {
        get { return view.center }
        set { view.center = newValue }
    }
    
    public var transform: CGAffineTransform {
        get { return view.transform }
        set { view.transform = newValue }
    }
    
//    @available(iOS 12.0, *)
//    public var transform3D: CATransform3D {
//        get { return view.transform3D }
//        set { view.transform3D = newValue }
//    }
    
    @available(iOS 4.0, *)
    public var contentScaleFactor: CGFloat {
        get { return view.contentScaleFactor }
        set { view.contentScaleFactor = newValue }
    }
    
    public var isMultipleTouchEnabled: Bool {
        get { return view.isMultipleTouchEnabled }
        set { view.isMultipleTouchEnabled = newValue }
    }

    public var isExclusiveTouch: Bool {
        get { return view.isExclusiveTouch }
        set { view.isExclusiveTouch = newValue }
    }
    
    public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return view.hitTest(point, with: event)
    }

    public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return view.point(inside: point, with: event)
    }

    public func convert(_ point: CGPoint, to view: UIView?) -> CGPoint {
        return self.view.convert(point, to: view)
    }

    public func convert(_ point: CGPoint, from view: UIView?) -> CGPoint {
        return self.view.convert(point, from: view)
    }
    
    public func convert(_ rect: CGRect, to view: UIView?) -> CGRect {
        return self.view.convert(rect, to: view)
    }
    
    public func convert(_ rect: CGRect, from view: UIView?) -> CGRect {
        return self.view.convert(rect, from: view)
    }
    
    public var autoresizesSubviews: Bool {
        get { return view.autoresizesSubviews }
        set { view.autoresizesSubviews = newValue }
    }
    
    public var autoresizingMask: UIView.AutoresizingMask {
        get { return view.autoresizingMask }
        set { view.autoresizingMask = newValue }
    }
    
    public func sizeThatFits(_ size: CGSize) -> CGSize {
        return view.sizeThatFits(size)
    }
    
    public func sizeToFit() {
        view.sizeToFit()
    }
}

extension ViewableType {
    
    public var superview: UIView? {
        return view.superview
    }

    public var subviews: [UIView] {
        return view.subviews
    }

    public var window: UIWindow? {
        return view.window
    }
    
    public func removeFromSuperview() {
        view.removeFromSuperview()
    }

    public func insertSubview(_ view: UIView, at index: Int) {
        self.view.insertSubview(view, at: index)
    }
    
    public func exchangeSubview(at index1: Int, withSubviewAt index2: Int) {
        self.view.exchangeSubview(at: index1, withSubviewAt: index2)
    }
    
    public func addSubview(_ view: UIView) {
        view.removeFromSuperview()
        self.view.addSubview(view)
    }
    
    public func insertSubview(_ view: UIView, belowSubview siblingSubview: UIView) {
        view.removeFromSuperview()
        self.view.insertSubview(view, belowSubview: siblingSubview)
    }
    
    public func insertSubview(_ view: UIView, aboveSubview siblingSubview: UIView) {
        view.removeFromSuperview()
        self.view.insertSubview(view, aboveSubview: siblingSubview)
    }
    
    public func bringSubviewToFront(_ view: UIView) {
        self.view.bringSubviewToFront(view)
    }
    
    public func sendSubviewToBack(_ view: UIView) {
        self.view.sendSubviewToBack(view)
    }
    
    public func didAddSubview(_ subview: UIView) {
        view.didAddSubview(subview)
    }
    
    public func willRemoveSubview(_ subview: UIView) {
        view.willRemoveSubview(subview)
    }
    
    public func willMove(toSuperview newSuperview: UIView?) {
        view.willMove(toSuperview: newSuperview)
    }
    
    public func didMoveToSuperview() {
        view.didMoveToSuperview()
    }
    
    public func willMove(toWindow newWindow: UIWindow?) {
        view.willMove(toWindow: newWindow)
    }
    
    public func didMoveToWindow() {
        view.didMoveToWindow()
    }
    
    public func isDescendant(of view: UIView) -> Bool {
        return self.view.isDescendant(of: view)
    }
    
    public func viewWithTag(_ tag: Int) -> UIView? {
        return view.viewWithTag(tag)
    }
    
    public func setNeedsLayout() {
        view.setNeedsLayout()
    }
    
    public func layoutIfNeeded() {
        view.layoutIfNeeded()
    }
    
    public func layoutSubviews() {
        view.layoutSubviews()
    }
    
    @available(iOS 8.0, *)
    public var layoutMargins: UIEdgeInsets {
        get { return view.layoutMargins }
        set { view.layoutMargins = newValue }
    }
    
    @available(iOS 11.0, *)
    public var directionalLayoutMargins: NSDirectionalEdgeInsets {
        get { return view.directionalLayoutMargins }
        set { view.directionalLayoutMargins = newValue }
    }
    
    @available(iOS 8.0, *)
    public var preservesSuperviewLayoutMargins: Bool {
        get { return view.preservesSuperviewLayoutMargins }
        set { view.preservesSuperviewLayoutMargins = newValue }
    }
    
    @available(iOS 11.0, *)
    public var insetsLayoutMarginsFromSafeArea: Bool {
        get { return view.insetsLayoutMarginsFromSafeArea }
        set { view.insetsLayoutMarginsFromSafeArea = newValue }
    }
    
    @available(iOS 8.0, *)
    public func layoutMarginsDidChange() {
        view.layoutMarginsDidChange()
    }
    
    @available(iOS 11.0, *)
    public var safeAreaInsets: UIEdgeInsets {
        return view.safeAreaInsets
    }
    
    @available(iOS 11.0, *)
    public func safeAreaInsetsDidChange() {
        view.safeAreaInsetsDidChange()
    }
    
    @available(iOS 9.0, *)
    public var layoutMarginsGuide: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    @available(iOS 9.0, *)
    public var readableContentGuide: UILayoutGuide {
        return view.readableContentGuide
    }
    
    @available(iOS 11.0, *)
    public var safeAreaLayoutGuide: UILayoutGuide {
        return view.safeAreaLayoutGuide
    }
}

extension ViewableType {
    
    public func draw(_ rect: CGRect) {
        view.draw(rect)
    }
    
    public func setNeedsDisplay() {
        view.setNeedsDisplay()
    }
    
    public func setNeedsDisplay(_ rect: CGRect) {
        view.setNeedsDisplay(rect)
    }
    
    public var clipsToBounds: Bool {
        get { return view.clipsToBounds }
        set { view.clipsToBounds = newValue }
    }
    
    public var backgroundColor: UIColor? {
        get { return view.backgroundColor }
        set { view.backgroundColor = newValue }
    }
    
    public var alpha: CGFloat {
        get { return view.alpha }
        set { view.alpha = newValue }
    }
    
    public var isOpaque: Bool {
        get { return view.isOpaque }
        set { view.isOpaque = newValue }
    }
    
    public var clearsContextBeforeDrawing: Bool {
        get { return view.clearsContextBeforeDrawing }
        set { view.clearsContextBeforeDrawing = newValue }
    }
    
    public var isHidden: Bool {
        get { return view.isHidden }
        set { view.isHidden = newValue }
    }
    
    public var contentMode: UIView.ContentMode {
        get { return view.contentMode }
        set { view.contentMode = newValue }
    }
    
    @available(iOS 8.0, *)
    public var mask: UIView? {
        get { return view.mask }
        set { view.mask = newValue }
    }
    
    @available(iOS 7.0, *)
    public var tintColor: UIColor! {
        get { return view.tintColor }
        set { view.tintColor = newValue }
    }
    
    @available(iOS 7.0, *)
    public var tintAdjustmentMode: UIView.TintAdjustmentMode {
        get { return view.tintAdjustmentMode }
        set { view.tintAdjustmentMode = newValue }
    }
    
    @available(iOS 7.0, *)
    public func tintColorDidChange() {
        view.tintColorDidChange()
    }
}

extension ViewableType {
    
    @available(iOS 3.2, *)
    public var gestureRecognizers: [UIGestureRecognizer]? {
        get { return view.gestureRecognizers }
        set { view.gestureRecognizers = newValue }
    }
    
    @available(iOS 3.2, *)
    public func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @available(iOS 3.2, *)
    public func removeGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        view.removeGestureRecognizer(gestureRecognizer)
    }
    
    @available(iOS 6.0, *)
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return view.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}

extension ViewableType {
    
    @available(iOS 7.0, *)
    public func addMotionEffect(_ effect: UIMotionEffect) {
        view.addMotionEffect(effect)
    }
    
    @available(iOS 7.0, *)
    public func removeMotionEffect(_ effect: UIMotionEffect) {
        view.removeMotionEffect(effect)
    }
    
    @available(iOS 7.0, *)
    public var motionEffects: [UIMotionEffect] {
        get { return view.motionEffects }
        set { view.motionEffects = newValue }
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public var constraints: [NSLayoutConstraint] {
        return view.constraints
    }
    
    @available(iOS 6.0, *)
    public func addConstraint(_ constraint: NSLayoutConstraint) {
        view.addConstraint(constraint)
    }
    
    @available(iOS 6.0, *)
    public func addConstraints(_ constraints: [NSLayoutConstraint]) {
        view.addConstraints(constraints)
    }
    
    @available(iOS 6.0, *)
    public func removeConstraint(_ constraint: NSLayoutConstraint) {
        view.removeConstraint(constraint)
    }
    
    @available(iOS 6.0, *)
    public func removeConstraints(_ constraints: [NSLayoutConstraint]) {
        view.removeConstraints(constraints)
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public func updateConstraintsIfNeeded() {
        view.updateConstraintsIfNeeded()
    }
    
    @available(iOS 6.0, *)
    public func updateConstraints() {
        view.updateConstraints()
    }
    
    @available(iOS 6.0, *)
    public func needsUpdateConstraints() -> Bool {
        return view.needsUpdateConstraints()
    }
    
    @available(iOS 6.0, *)
    public func setNeedsUpdateConstraints() {
        view.setNeedsUpdateConstraints()
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public var translatesAutoresizingMaskIntoConstraints: Bool {
        get { return view.translatesAutoresizingMaskIntoConstraints }
        set { view.translatesAutoresizingMaskIntoConstraints = newValue }
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public func alignmentRect(forFrame frame: CGRect) -> CGRect {
        return view.alignmentRect(forFrame: frame)
    }
    
    @available(iOS 6.0, *)
    public func frame(forAlignmentRect alignmentRect: CGRect) -> CGRect {
        return view.frame(forAlignmentRect: alignmentRect)
    }
    
    @available(iOS 6.0, *)
    public var alignmentRectInsets: UIEdgeInsets {
        return view.alignmentRectInsets
    }
    
    @available(iOS 9.0, *)
    public var forFirstBaselineLayout: UIView {
        return view.forFirstBaselineLayout
    }
    
    @available(iOS 9.0, *)
    public var forLastBaselineLayout: UIView {
        return view.forLastBaselineLayout
    }
    
    @available(iOS 6.0, *)
    public var intrinsicContentSize: CGSize {
        return view.intrinsicContentSize
    }
    
    @available(iOS 6.0, *)
    public func invalidateIntrinsicContentSize() {
        view.invalidateIntrinsicContentSize()
    }
    
    @available(iOS 6.0, *)
    public func contentHuggingPriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        return view.contentHuggingPriority(for: axis)
    }
    
    @available(iOS 6.0, *)
    public func setContentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        return view.setContentHuggingPriority(priority, for: axis)
    }
    
    @available(iOS 6.0, *)
    public func contentCompressionResistancePriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        return view.contentCompressionResistancePriority(for: axis)
    }
    
    @available(iOS 6.0, *)
    public func setContentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        view.setContentCompressionResistancePriority(priority, for: axis)
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return view.systemLayoutSizeFitting(targetSize)
    }
    
    @available(iOS 8.0, *)
    public func systemLayoutSizeFitting(_ targetSize: CGSize,
                                        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                        verticalFittingPriority: UILayoutPriority) -> CGSize {
        return view.systemLayoutSizeFitting(targetSize,
                                            withHorizontalFittingPriority: horizontalFittingPriority,
                                            verticalFittingPriority: verticalFittingPriority)
    }
}

extension ViewableType {
    
    @available(iOS 9.0, *)
    public var layoutGuides: [UILayoutGuide] {
        return view.layoutGuides
    }
    
    @available(iOS 9.0, *)
    public func addLayoutGuide(_ layoutGuide: UILayoutGuide) {
        view.addLayoutGuide(layoutGuide)
    }
    
    @available(iOS 9.0, *)
    public func removeLayoutGuide(_ layoutGuide: UILayoutGuide) {
        view.removeLayoutGuide(layoutGuide)
    }
}

extension ViewableType {
    
    @available(iOS 9.0, *)
    public var leadingAnchor: NSLayoutXAxisAnchor {
        return view.leadingAnchor
    }
    
    @available(iOS 9.0, *)
    public var trailingAnchor: NSLayoutXAxisAnchor {
        return view.trailingAnchor
    }
    
    @available(iOS 9.0, *)
    public var leftAnchor: NSLayoutXAxisAnchor {
        return view.leftAnchor
    }
    
    @available(iOS 9.0, *)
    public var rightAnchor: NSLayoutXAxisAnchor {
        return view.rightAnchor
    }
    
    @available(iOS 9.0, *)
    public var topAnchor: NSLayoutYAxisAnchor {
        return view.topAnchor
    }
    
    @available(iOS 9.0, *)
    public var bottomAnchor: NSLayoutYAxisAnchor {
        return view.bottomAnchor
    }
    
    @available(iOS 9.0, *)
    public var widthAnchor: NSLayoutDimension {
        return view.widthAnchor
    }
    
    @available(iOS 9.0, *)
    public var heightAnchor: NSLayoutDimension {
        return view.heightAnchor
    }
    
    @available(iOS 9.0, *)
    public var centerXAnchor: NSLayoutXAxisAnchor {
        return view.centerXAnchor
    }
    
    @available(iOS 9.0, *)
    public var centerYAnchor: NSLayoutYAxisAnchor {
        return view.centerYAnchor
    }
    
    @available(iOS 9.0, *)
    public var firstBaselineAnchor: NSLayoutYAxisAnchor {
        return view.firstBaselineAnchor
    }
    
    @available(iOS 9.0, *)
    public var lastBaselineAnchor: NSLayoutYAxisAnchor {
        return view.lastBaselineAnchor
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public func exerciseAmbiguityInLayout() {
        view.exerciseAmbiguityInLayout()
    }
}

extension ViewableType {
    
    @available(iOS 10.0, *)
    public func constraintsAffectingLayout(for axis: NSLayoutConstraint.Axis) -> [NSLayoutConstraint] {
        return view.constraintsAffectingLayout(for: axis)
    }
    
    @available(iOS 10.0, *)
    public var hasAmbiguousLayout: Bool {
        return view.hasAmbiguousLayout
    }
}

extension ViewableType {
    
    @available(iOS 6.0, *)
    public var restorationIdentifier: String? {
        get { return view.restorationIdentifier }
        set { view.restorationIdentifier = newValue }
    }
    
    @available(iOS 6.0, *)
    public func encodeRestorableState(with coder: NSCoder) {
        view.encodeRestorableState(with: coder)
    }
    
    @available(iOS 6.0, *)
    public func decodeRestorableState(with coder: NSCoder) {
        view.decodeRestorableState(with: coder)
    }
}

extension ViewableType {
    
    @available(iOS 7.0, *)
    public func snapshotView(afterScreenUpdates afterUpdates: Bool) -> UIView? {
        return view.snapshotView(afterScreenUpdates: afterUpdates)
    }
    
    @available(iOS 7.0, *)
    public func resizableSnapshotView(from rect: CGRect, afterScreenUpdates afterUpdates: Bool, withCapInsets capInsets: UIEdgeInsets) -> UIView? {
        return view.resizableSnapshotView(from: rect, afterScreenUpdates: afterUpdates, withCapInsets: capInsets)
    }
    
    @available(iOS 7.0, *)
    public func drawHierarchy(in rect: CGRect, afterScreenUpdates afterUpdates: Bool) -> Bool {
        return view.drawHierarchy(in: rect, afterScreenUpdates: afterUpdates)
    }
}

extension ViewableType {
    
//    @available(iOS 13.0, *)
//    public var overrideUserInterfaceStyle: UIUserInterfaceStyle {
//        get { return view.overrideUserInterfaceStyle }
//        set { view.overrideUserInterfaceStyle = newValue }
//    }
}

extension ViewableType {
    
    public var viewController: UIViewController? {
        return nil
    }
    
    public func addSub(_ sub: ViewableType) {
        if let _ = sub.superview { sub.removeFromSuper() }
        view.addSubview(sub.view)
    }
    
    public func removeFromSuper() {
        view.removeFromSuperview()
    }
    
    public func insertSubview(_ sub: ViewableType, at index: Int) {
        view.insertSubview(sub.view, at: index)
    }
    
    public func insertSubview(_ aview: ViewableType, belowSubview siblingSubview: ViewableType) {
        view.insertSubview(aview.view, belowSubview: siblingSubview.view)
    }
    
    public func insertSubview(_ aview: ViewableType, aboveSubview siblingSubview: ViewableType) {
        view.insertSubview(aview.view, aboveSubview: siblingSubview.view)
    }
    
    public func bringSubviewToFront(_ aview: ViewableType) {
        view.bringSubviewToFront(aview.view)
    }
    
    public func bringToFront() {
        view.superview?.bringSubviewToFront(view)
    }
    
    public func sendSubviewToBack(_ aview: ViewableType) {
        view.sendSubviewToBack(aview.view)
    }
    
    public func sendToBack() {
        view.superview?.sendSubviewToBack(view)
    }
    
    public func isDescendant(of aview: ViewableType) -> Bool {
        return view.isDescendant(of: aview.view)
    }
}

extension UIView: ViewableType {
    
    public var view: UIView! {
        return self
    }
}

extension UIView {
    
    func isSub<T: ViewableType>(of type: T.Type) -> Bool {
        if self is T { return true }
        return superview?.isSub(of: type) ?? false
    }
}

extension UIViewController: ViewableType {
    
    public var viewController: UIViewController? {
        return self
    }
}

extension ViewableType {
    
    public var snp: SnapKit.ConstraintViewDSL {
        return view.snp
    }
}

public extension SDExtension where T: ViewableType {
    
    func isSub<T: ViewableType>(of type: T.Type) -> Bool {
        return base.view.isSub(of: type)
    }
}

public extension SDExtension where T: ViewableType {
    
    var snp: SnapKit.ConstraintViewDSL {
        return base.view.snp
    }
    
    func debugBorder() {
        
        if base.layer.borderWidth > 0 {
            return
        }
        
        let rc = UIColor(hex: Int.random(in: (0...0xffffff)))
        base.layer.borderColor = rc.cgColor
        base.layer.borderWidth = 1
        
        base.subviews.forEach { $0.sd.debugBorder() }
    }
}


public protocol TableType: ViewableType {
    
    var table: UITableView { get }
}

public protocol CollectionType: ViewableType {
    
    var collection: UICollectionView { get }
}

public protocol TableCellType: ViewableType {
    
    var cell: UITableViewCell { get }
}

public protocol CollectionCellType: ViewableType {
    
    var cell: UICollectionViewCell { get }
}

extension UITableViewCell: TableCellType {
    public var cell: UITableViewCell { return self }
}

extension UICollectionViewCell: CollectionCellType {
    public var cell: UICollectionViewCell { return self }
}

extension UITableView: TableType {
    public var table: UITableView { return self }
}

extension UICollectionView: CollectionType {
    public var collection: UICollectionView { return self }
}
