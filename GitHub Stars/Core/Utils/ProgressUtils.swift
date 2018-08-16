//
//  ProgressUtils.swift
//  Twist
//
//  Created by Wesley Gomes on 17/11/16.
//  Copyright © 2016 Wesley Gomes. All rights reserved.
//

import Foundation
import SVProgressHUD

class ProgressUtils {
    
    //To dismiss progress, only in error and message types
    static var canDismissOnTap = false
    static var completion: (() -> Void)?
    static let defaultLoadingMessage = "Carregando..."
    
    // MARK: -
    
    static func configure() {
        //Progress init config
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 80))
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissOnTap), name: .SVProgressHUDDidReceiveTouchEvent, object: nil)
    }
    
    static var isVisible: Bool {
        return SVProgressHUD.isVisible()
    }
    
    static func show(with message: String? = nil) {
        canDismissOnTap = false
        SVProgressHUD.show(withStatus: message ?? defaultLoadingMessage)
    }
    
    static func success(_ message: String, _ completion: (() -> Void)? = nil) {
        canDismissOnTap = true
        SVProgressHUD.showSuccess(withStatus: message)
        if let completion = completion {
            self.completion = completion
            UIViewController().delay(SVProgressHUD.displayDuration(for: message)) {
                self.completion?()
            }
        }
        postFeedBackNotification(.success)
    }
    
    static func error(_ message: String, _ completion: (() -> Void)? = nil) {
        canDismissOnTap = true
        SVProgressHUD.showError(withStatus: message)
        if let completion = completion {
            self.completion = completion
            UIViewController().delay(SVProgressHUD.displayDuration(for: message)) {
                self.completion?()
            }
        }
        postFeedBackNotification(.error)
    }
    
    static func info(_ message: String, _ completion: (() -> Void)? = nil) {
        canDismissOnTap = true
        SVProgressHUD.showInfo(withStatus: message)
        if let completion = completion {
            self.completion = completion
            UIViewController().delay(SVProgressHUD.displayDuration(for: message)) {
                self.completion?()
            }
        }
        postFeedBackNotification(.warning)
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    @objc static func dismissOnTap() {
        if canDismissOnTap {
            completion?()
            canDismissOnTap = false
            completion = nil
            SVProgressHUD.dismiss()
        }
    }
    
    static func postFeedBackNotification(_ type: UINotificationFeedbackType) {
        if #available(iOS 10.0, *) {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(type)
        }
    }
}
