//
//  NoticeBar.swift
//  NoticeBar
//
//  Created by Qiun Cheng on 2016/12/10.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

public enum NoticeBarDefaultType: String {
    case info = "notice_bar_info"
    case attention = "notice_bar_attention"
    case success = "notice_bar_success"
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

public enum NoticeBarAnimationType {
    case top
    case bottom
    case left
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

public enum NoticeBarStyle {
    case onStatusBar
    case belowStatusBar
    case onNavigationBar
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

public struct NoticeBarConfig {
    public init() { }

    public var title: String?
    public var image: UIImage? = nil
    public var margin: CGFloat = 10.0
    public var textColor: UIColor = UIColor.black
    public var backgroundColor = UIColor.white
    public var animationType = NoticeBarAnimationType.top
    public var barStyle = NoticeBarStyle.onNavigationBar

    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor, barStyle: NoticeBarStyle, animationType: NoticeBarAnimationType) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
        self.animationType = animationType
    }

    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor, barStyle: NoticeBarStyle) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
    }

    public init(title: String?, textColor: UIColor, backgroundColor: UIColor, barStyle: NoticeBarStyle) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
    }

    public init(title: String?, image: UIImage?, textColor: UIColor, backgroundColor: UIColor) {
        self.title = title
        self.image = image
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }

    public init(title: String?, textColor: UIColor, backgroundColor: UIColor) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
}

open class NoticeBar: UIView {

    private var config = NoticeBarConfig()

    open var defaultType: NoticeBarDefaultType?

    open var titleLabel: UILabel? {
        return _titleLabel
    }


    open var imageView: UIImageView? {
        return _imageView
    }

    private var _titleLabel: UILabel?
    private var _imageView: UIImageView?

    public func show(duration: TimeInterval, completed: @escaping (_ finished: Bool) -> Void) {
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
            completed(finished)
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

    public convenience init(title: String?, defaultType: NoticeBarDefaultType ) {

        var config = defaultType.defaultConfig
        config.title = title

        self.init(config: config)
        self.defaultType = defaultType
    }

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

    private func show(duration: TimeInterval, willShow: (Void) -> Void, completed: @escaping (_ finished: Bool) -> Void) {

        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for view in subviews {
                if view.isKind(of: NoticeBar.self) {
                    return
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
                                completed(finished)
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
