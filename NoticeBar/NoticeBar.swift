//
//  Created by Qiun Cheng on 2016/12/10.
//  Copyright © 2016年 http://qiuncheng.com. All rights reserved.
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//

import UIKit

/// The default four *NoticeBarType*, you just tell the NoticeBar what message should show, or you can custom your NoticeBar using **NoticeBarConfig**.
///
public enum NoticeBarDefaultType: String {
    /// The default info *NoticeBar*, with a 'notice_bar_info' image and white backgroundColor.
    case info = "notice_bar_info"
    /// The default *attention* NoticeBar, with a 'notice_bar_attention' image and orange backgroundColor.
    case attention = "notice_bar_attention"
    /// The default *success* NoticeBar, with a 'notice_bar_success' image and white backgroundColor.
    case success = "notice_bar_success"
    /// The default *error* NoticeBar, with a 'notice_bar_error' image and 
    ///
    /// UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0) backgroundColor.
    case error = "notice_bar_error"
}

extension NoticeBarDefaultType {
    fileprivate var image: UIImage? {
        return UIImage(named: self.rawValue, in: Bundle.currentBundle(), compatibleWith: nil)
    }
    fileprivate var defaultConfig: NoticeBarConfig {

        var config: NoticeBarConfig

        switch self {
        case .info:
            config = NoticeBarConfig(title: nil, image: self.image, textColor: UIColor.black, backgroundColor: UIColor.white, barStyle: NoticeBarStyle.onNavigationBar, animationType: NoticeBarAnimationType.top)
            break
        case .success:
            config = NoticeBarConfig(title: nil, image: self.image, textColor: UIColor.black, backgroundColor: UIColor(white: 1.0, alpha: 1.0), barStyle: NoticeBarStyle.onNavigationBar, animationType: NoticeBarAnimationType.top)
            break
        case .error:
            config = NoticeBarConfig(title: nil, image: self.image, textColor: UIColor.white, backgroundColor: UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0), barStyle: NoticeBarStyle.onNavigationBar, animationType: NoticeBarAnimationType.top)
        case .attention:
            config = NoticeBarConfig(title: nil, image: self.image, textColor: UIColor.white, backgroundColor: UIColor.orange, barStyle: NoticeBarStyle.onNavigationBar, animationType: NoticeBarAnimationType.top)

        }
        return config
    }

    fileprivate func statusBarStyles(status: UIStatusBarStyle) -> (beigin: UIStatusBarStyle, end: UIStatusBarStyle) {
        switch (status, self) {
        case (.default, .error):
            return (.lightContent, .default)

        case (.default, .info):
            return (.default, .default)

        case (.default, .success):
            return (.default, .default)

        case (.default, .attention):
            return (.lightContent, .default)

        case (.lightContent, .error):
            return (.lightContent, .lightContent)

        case (.lightContent, .info):
            return (.default, .lightContent)

        case (.lightContent, .success):
            return (.default, .lightContent)

        case (.lightContent, .attention):
            return (.lightContent, .lightContent)

        default:
            return (status, status)
        }
    }
}

/// NoticeBar appear with the animation.
///
/// And there are four different animation type.
/// - top
/// - bottom
/// - left
/// - right
public enum NoticeBarAnimationType {
    /// animate from top, but it doesn't work when NoticeBarStyle is `.onTabbar`.
    case top
    /// animate from bottom, but it doesn't work when NoticeBarStyle is `.onNavigationBar`, '.onStatusBar', `belowStatusBar`.
    case bottom
    /// animate from left.
    case left
    /// animate from right.
    case right
}

extension NoticeBarAnimationType {

    fileprivate func noticeBarViewTransform(with frame: CGRect, _ style: NoticeBarStyle) -> CGAffineTransform {

        var transform = CGAffineTransform.identity

        switch (style, self) {
        case (.onStatusBar, .top):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.belowStatusBar, .top):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onNavigationBar, .top):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onTabbar, .top):
            transform = CGAffineTransform(translationX: 0, y: frame.height)
            break
        case (.onStatusBar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.belowStatusBar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onNavigationBar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: -frame.height)
            break
        case (.onTabbar, .bottom):
            transform = CGAffineTransform(translationX: 0, y: frame.height)
            break
        case (.onStatusBar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.belowStatusBar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.onNavigationBar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.onTabbar, .left):
            transform = CGAffineTransform(translationX: -frame.width, y: 0)
            break
        case (.onStatusBar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        case (.belowStatusBar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        case (.onNavigationBar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        case (.onTabbar, .right):
            transform = CGAffineTransform(translationX: frame.width, y: 0)
            break
        }

        return transform
    }
}

/// Where the NoticeBar you want to show.
///
/// There are four locations you will show the NoticeBar.
/// - onStatusBar
/// - belowStatusBar
/// - onNavigationBar
/// - onTabbar
public enum NoticeBarStyle {
    /// On status bar, it will cover status bar content when showing.
    case onStatusBar
    ///  The NoticeBar content will show below status bar content. You should care the UIStatusBarStyle meanwhile. To enable change UIStatusBarStyle, you should set
    ///
    /// **View controller-based status bar appearance** to **NO**
    /// 
    /// in your application's **info.plist**.
    case belowStatusBar
    ///  On navigation bar, it will cover all the navigation bar and status bar when showing.You should care the UIStatusBarStyle meanwhile. To enable change UIStatusBarStyle, you should set 
    ///
    /// **View controller-based status bar appearance** to **NO**
    ///
    /// in your application's **info.plist**.
    case onNavigationBar
    /// On tab bar, it will cover all tab bar, whatever it has UITabbar or not.
    case onTabbar
}

extension NoticeBarStyle {

    fileprivate func noticeBarProperties() -> NoticeBarProperties {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        var properties: NoticeBarProperties
        switch self {
        case .onNavigationBar:
            properties = NoticeBarProperties(shadowOffsetY: 3, fontSizeScaleFactor: 0.55, textFont: UIFont.systemFont(ofSize: 18), viewFrame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 64.0)))
            break
        case .onStatusBar:
            properties = NoticeBarProperties(shadowOffsetY: 2, fontSizeScaleFactor: 0.75, textFont: UIFont.systemFont(ofSize: 13), viewFrame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 20.0)))
            break
        case .onTabbar:
            properties = NoticeBarProperties(shadowOffsetY: -3, fontSizeScaleFactor: 0.55,textFont: UIFont.systemFont(ofSize: 17), viewFrame: CGRect(origin: CGPoint(x: 0, y: screenHeight - 49.0), size: CGSize(width: screenWidth, height: 49.0)))
            break
        case .belowStatusBar:
            properties = NoticeBarProperties(shadowOffsetY: 2, fontSizeScaleFactor: 0.75, textFont: UIFont.systemFont(ofSize: 13), viewFrame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenWidth, height: 40.0)))
        }

        return properties

    }

    fileprivate func noticeBarOriginY(superViewHeight: CGFloat, _ height: CGFloat) -> CGFloat {
        var originY: CGFloat = 0
        switch self {
        case .onNavigationBar:
            originY = (superViewHeight - height) * 0.5 + 10
            break
        case .onStatusBar:
            originY = (superViewHeight - height) * 0.5
            break
        case .onTabbar:
            originY = (superViewHeight - height) * 0.5
            break
        case .belowStatusBar:
            originY = (superViewHeight * 0.5 - height) * 0.5 + superViewHeight * 0.5
        }
        return originY
    }

    fileprivate var beginWindowLevel: UIWindowLevel {
        switch self {
        case .onStatusBar:
            return UIWindowLevelStatusBar + 1
        default:
            return UIWindowLevelNormal
        }
    }

    fileprivate var endWindowLevel: UIWindowLevel {
        return UIWindowLevelNormal
    }

}

/// The inner properties which are determined by NoticeBarStyle.
fileprivate struct NoticeBarProperties {
    init() { }
    var shadowOffsetY: CGFloat = 0
    var fontSizeScaleFactor: CGFloat = 0
    var textFont = UIFont()
    var viewFrame = CGRect.zero

    init(shadowOffsetY: CGFloat, fontSizeScaleFactor: CGFloat, textFont: UIFont, viewFrame: CGRect) {
        self.shadowOffsetY = shadowOffsetY
        self.fontSizeScaleFactor = fontSizeScaleFactor
        self.textFont = textFont
        self.viewFrame = viewFrame
    }
}

/// The NoticeBar configuration you provide if you want to custom.
public struct NoticeBarConfig {
    /// Create an empty NoticeBarConfig.
    public init() { }

    /// The message you want to show, it will be center if image is nil, or in left.
    public var title: String?
    /// The image you want to show, usually in the left, if it's nil, the title will be center. default is **nil**.
    public var image: UIImage? = nil
    /// The space between image's left and NoticeBar left, default is **10.0**.
    public var margin: CGFloat = 10.0
    /// The title's text color, default is **black**.
    public var textColor: UIColor = UIColor.black
    /// The NoticeBar's background color, default is **white**.
    public var backgroundColor = UIColor.white
    /// The animation NoticeBar appear, default is **NoticeBarAnimationType.top** from top.
    public var animationType = NoticeBarAnimationType.top
    /// The bar style of NoticeBar, default is **NoticeBarStyle.onNavigationBar**.
    public var barStyle = NoticeBarStyle.onNavigationBar

    /// Create a NoticeBarConfig with full of configs excepted 'margin'.
    ///
    /// - Parameters:
    ///   - title: The message you want to show.
    ///   - image: The image you want to show, or set nil.
    ///   - textColor: The title's text color.
    ///   - backgroundColor: The NoticeBar's background color.
    ///   - barStyle: The bar style of NoticeBar.
    ///   - animationType: The animation NoticeBar appear.
    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor, barStyle: NoticeBarStyle, animationType: NoticeBarAnimationType) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
        self.animationType = animationType
    }

    /// Create a NoticeBarConfig with title, image, textColor, backgroundColor, barStyle. others is default.
    ///
    /// - Parameters:
    ///   - title: The message you want to show.
    ///   - image: The image you want to show, or set nil.
    ///   - textColor: The title's text color.
    ///   - backgroundColor: The NoticeBar's background color.
    ///   - barStyle: The bar style of NoticeBar.
    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor, barStyle: NoticeBarStyle) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
    }

    /// Create a NoticeBarConfig with title, textColor, backgroundColor, barStyle. others is default. Especially 'image' will be nil, it means the message will be center with no image.
    ///
    /// - Parameters:
    ///   - title: The message you want to show.
    ///   - textColor: The title's text color.
    ///   - backgroundColor: The NoticeBar's background color.
    ///   - barStyle: The bar style of NoticeBar.
    public init(title: String?, textColor: UIColor, backgroundColor: UIColor, barStyle: NoticeBarStyle) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
    }

    /// Create a NoticeBarConfig with title, image, textColor, backgroundColor. others is default.
    ///
    /// - Parameters:
    ///   - title: The message you want to show.
    ///   - image: The image you want to show, or set nil.
    ///   - textColor: The title's text color.
    ///   - backgroundColor: The NoticeBar's background color.
    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }

    /// Create a NoticeBarConfig with title, textColor, backgroundColor. others is default. Especially 'image' will be nil, it means the message will be center with no image.
    ///
    /// - Parameters:
    ///   - title: The message you want to show.
    ///   - textColor: The title's text color.
    ///   - backgroundColor: The NoticeBar's background color.
    public init(title: String?, textColor: UIColor, backgroundColor: UIColor) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

open class NoticeBar: UIView {

    private var config = NoticeBarConfig()


    /// Return the titleLabel which the message shows.
    open var titleLabel: UILabel? {
        return _titleLabel
    }


    /// Return the imageView which the image shows.
    open var imageView: UIImageView? {
        return _imageView
    }

    /// The default type.
    private var defaultType: NoticeBarDefaultType?
    private var _titleLabel: UILabel?
    private var _imageView: UIImageView?

    /// Show the notice bar when you finished create a NoticeBar instance. And it will dismiss automatically.
    ///
    /// Ususlly you can change **UIStatusBarStyle** before notice bar show, and you also set **UIStatusBarStyle** to pre state.
    ///
    /// - Parameters:
    ///   - duration: How long the notice bar will stay. it's up to you, then it will dismiss automatically
    ///   - completed: When notice bar dimissed, what you want to do. Or you can do nothing, just type nil.
    public func show(duration: TimeInterval, completed: ((_ finished: Bool) -> Void)?) {
        let appStatusBarStyle = UIApplication.shared.statusBarStyle
        self.show(duration: duration, willShow: {
            [weak self] in
            guard let strongSelf = self else { return }
            let currentWindowLevel = strongSelf.config.barStyle.beginWindowLevel
            UIApplication.shared.keyWindow?.windowLevel = currentWindowLevel
            if let type = strongSelf.defaultType {
                let currentStatusBarStyle = type.statusBarStyles(status: appStatusBarStyle).beigin
                UIApplication.shared.statusBarStyle = currentStatusBarStyle
            }

        }, completed: {
           [weak self] (finished) in
            guard let strongSelf = self else { return }
            completed?(finished)
            if finished {
                let currentWindowLevel = strongSelf.config.barStyle.endWindowLevel
                UIApplication.shared.keyWindow?.windowLevel = currentWindowLevel
                if let type = strongSelf.defaultType {
                    let currentStatusBarStyle = type.statusBarStyles(status: appStatusBarStyle).end
                    UIApplication.shared.statusBarStyle = currentStatusBarStyle
                }
            }
        })
    }

    /// Create a NoticeBar instance with title and one of four default type.
    ///
    /// - Parameters:
    ///   - title: The message you want to show, you'd better not type nil.
    ///   - defaultType: one of four default type.
    public convenience init(title: String?, defaultType: NoticeBarDefaultType ) {

        var config = defaultType.defaultConfig
        config.title = title

        self.init(config: config)
        self.defaultType = defaultType
    }

    /// Create a NoticeBar instance with your custom NoticeBarConfig.
    ///
    /// - Parameter config: custom NoticeBarConfig.
    public init(config: NoticeBarConfig) {
        super.init(frame: config.barStyle.noticeBarProperties().viewFrame)
        self.backgroundColor = config.backgroundColor

        self.config = config

        self.layer.shadowOffset = CGSize(width: 0, height: config.barStyle.noticeBarProperties().shadowOffsetY)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.44

        configSubviews()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configSubviews() {
        /// initial label
        _titleLabel = UILabel()
        _titleLabel?.text = config.title
        _titleLabel?.textColor = config.textColor
        _titleLabel?.minimumScaleFactor = config.barStyle.noticeBarProperties().fontSizeScaleFactor
        _titleLabel?.adjustsFontSizeToFitWidth = true
        _titleLabel?.font = config.barStyle.noticeBarProperties().textFont
        addSubview(_titleLabel!)

        var titleLabelOriginX: CGFloat = 0
        var titleLabelOriginY: CGFloat = 0
        var titleLabelHeight: CGFloat = 0
        var titleLabelWidth: CGFloat = 0

        if let image = config.image,
            config.barStyle != .onStatusBar,
            config.barStyle != .belowStatusBar {

            /// initial imageView
            _imageView = UIImageView(image: image)
            _imageView?.contentMode = .scaleAspectFill
            addSubview(_imageView!)

            let imageViewWidth: CGFloat = 25
            let imageViewOriginX = config.margin + 10
            let imageViewOriginY = config.barStyle.noticeBarOriginY(superViewHeight: frame.height, imageViewWidth)
            _imageView?.frame = CGRect(origin: CGPoint(x: imageViewOriginX, y: imageViewOriginY),
                                       size: CGSize(width: imageViewWidth, height: imageViewWidth))

            titleLabelOriginX = _imageView!.frame.maxX + config.margin
            titleLabelOriginY = _imageView!.frame.origin.y
            titleLabelHeight = _imageView!.frame.size.height
            titleLabelWidth = UIScreen.main.bounds.width - titleLabelOriginX - config.margin
            _titleLabel?.textAlignment = NSTextAlignment.left

        } else {
            _titleLabel?.textAlignment = NSTextAlignment.center

            titleLabelHeight = 25
            titleLabelWidth = UIScreen.main.bounds.width - 2 * config.margin
            titleLabelOriginX = config.margin
            titleLabelOriginY = config.barStyle.noticeBarOriginY(superViewHeight: frame.height, titleLabelHeight)
        }

        _titleLabel?.frame = CGRect(x: titleLabelOriginX, y: titleLabelOriginY, width: titleLabelWidth, height: titleLabelHeight)
    }

    private func show(duration: TimeInterval, willShow: (Void) -> Void, completed: ((_ finished: Bool) -> Void)?) {

        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews {
                if view.isKind(of: NoticeBar.self) {
                    view.removeFromSuperview()
                }
            }
        }
        willShow()

        UIApplication.shared.keyWindow?.addSubview(self)
        self.transform = config.animationType.noticeBarViewTransform(with: frame, self.config.barStyle)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.90, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.transform = CGAffineTransform.identity
            }, completion: {
                (finished: Bool) in
                if (finished) {

                    let afterQueue = DispatchQueue(label: "com.qiuncheng.NoticeBar")
                    let delayTime = DispatchTime.now() + duration
                    afterQueue.asyncAfter(deadline: delayTime, execute: {
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let strongSelf = self else { return }
                            /// dismiss
                            UIView.animate(withDuration: 0.4, animations: {
                                strongSelf.transform = strongSelf.config.animationType.noticeBarViewTransform(with: strongSelf.frame, strongSelf.config.barStyle)

                            }, completion: { (finished) in
                                completed?(finished)
                                if (finished) {
                                    strongSelf.removeFromSuperview()
                                }
                            })
                        }
                    })
                }
        })
    }

}
