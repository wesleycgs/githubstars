//
//  Extensions.swift
//
//
//  Created by Wesley Gomes on 07/07/16.
//  Copyright © 2016 Wesley Gomes. All rights reserved.
//

import UIKit

// MARK: - String

extension String {
    ///Remove white spaces from String
    func trim() -> String {
        let string = self
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\\s", with: "")
            .replacingOccurrences(of: " ", with: "")
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Before ==>
        //return self.trimmingCharacters(in: .whitespacesAndNewlines)
        //Changed at 02-04-2018, still don't work
        //https://stackoverflow.com/questions/43177943/trimmingcharacters-not-work-on-ios-10-3-xcode8-3
    }
    
    func emptyOrNil() -> String? {
        return self.trim().isEmpty ? nil : self
    }
    
    // MARK: Phone
    mutating func removePhoneMask() -> String {
        let chars: [String] = [" ", "-", "(", ")", "+"]
        return self.replacingOccurrences(ofStrings: chars, with: "")
    }
    
//    mutating func getPhoneDDD() -> String? {
//        if Int(self) == nil, self.characters.count < 2 {
//            return nil
//        }
//
//        let index = self.index(self.startIndex, offsetBy: 2)
//        let sub = self.substring(to: index)
//        return sub
//    }
    
    mutating func replacingOccurrences(ofStrings strings: [String], with replaceString: String) -> String {
        for string in strings {
            self = self.replacingOccurrences(of: string, with: replaceString)
        }
        return self
    }
    
    func convertDateFormater(date: String, originalFormat: String, desiredFormat: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = originalFormat
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        let originalDate = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = desiredFormat
        let dateString = dateFormatter.string(from: originalDate!)
        
        return dateString
    }
    
    // MARK: Getter only
    
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidCPF: Bool {
        let numbers = compactMap({Int(String($0))})
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let soma1 = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let dv1 = soma1 > 9 ? 0 : soma1
        let soma2 = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let dv2 = soma2 > 9 ? 0 : soma2
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    var isValidCEP: Bool {
        let string = self.replacingOccurrences(of: "-", with: "")
        guard let _ = Int(string), string.count == 8 else {
            return false
        }
        return false
    }
    
    func removeHtmlTags() -> String {
        var htmlStr = self
        htmlStr = htmlStr.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        htmlStr = htmlStr.replacingOccurrences(of: "<[^>]*", with: "", options: .regularExpression, range: nil)
        htmlStr = htmlStr.replacingOccurrences(of: "[^<]*>", with: "", options: .regularExpression, range: nil)
        return htmlStr.trimmingCharacters(in: .whitespaces)
    }
}


// MARK: - Array

///Get `optional` Element in Array, case index is out of range return nil safely, instead crashing your app.
extension Array {
    public func elementAtIndex(i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
}

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}


// MARK: - ######## UIKit ########

// MARK: - UIViewController

extension UIViewController {    
    func delay(_ time: TimeInterval, _ execute: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now()+time, execute: execute)
    }
    
    func present(_ viewController: UIViewController) {
        self.present(viewController, animated: true)
    }
    
    func dismiss() {
        self.dismiss(animated: true)
    }
    
//    static func getTopMostController() -> UIViewController {
//        var topController = UIApplication.shared.keyWindow!.rootViewController!
//        while (topController.presentedViewController != nil) {
//            topController = topController.presentedViewController!
//        }
//        return topController
//    }
    
    ///Returns the current UIViewController
    static var topMostController: UIViewController {
        var topController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    //MARK: Getter only
    
    // Check if ViewController is current visible
    var isVisible: Bool {
        return self.isViewLoaded && self.view.window != nil
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var navigationControllerBarHeight: CGFloat {
        return (navigationController?.navigationBar.frame.origin.y ?? 0.0) + (navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    var tabBarHeight: CGFloat {
        return tabBarController?.tabBar.frame.height ?? 0
    }
    
    var wgClassName: String {
        return String(describing: self)
            .components(separatedBy: ".").last.unwrapped
            .components(separatedBy: ":").first.unwrapped
    }
}


// MARK: - UIView

extension UIView {
    
    ///Set alpha animated, default durations is 0.3
    func setAlphaAnimated(_ alpha: CGFloat) {
        setAlphaAnimated(alpha, duration: 0.3)
    }
    
    ///Set alpha animated with duration
    func setAlphaAnimated(_ alpha: CGFloat, duration: TimeInterval) {
        //Do nothing if is already set value
        guard self.alpha != alpha else {
            return
        }
        
        UIView.animate(withDuration: duration, delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.alpha = alpha
        }, completion: nil)
    }
    
    func setMotionEffect(_ value: Double) {
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -value
        verticalMotionEffect.maximumRelativeValue = value
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                 type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -value
        horizontalMotionEffect.maximumRelativeValue = value
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        // Add both effects to your view
        self.addMotionEffect(group)
    }
    
    func applyGradient(colours: [UIColor], radius: Float) -> Void {
        self.applyGradient(colours: colours, locations: nil, radius: radius)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, radius: Float) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.cornerRadius = CGFloat(radius)
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0,y :0.5)
        gradient.endPoint = CGPoint(x: 1.0,y :0.5)
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setNavBarShadow(height: CGFloat) {
        let customView = UIView(frame: CGRect(x: 0, y: -18, width: self.frame.size.width, height: height))
        
        customView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05).cgColor
        customView.layer.shadowOpacity = 1
        customView.layer.shadowOffset = CGSize.zero
        customView.layer.shadowRadius = 2
        customView.layer.shadowPath = UIBezierPath(rect: customView.bounds).cgPath
        customView.layer.shouldRasterize = true
        
        self.addSubview(customView)
    }
    
    func setTabBarShadow() {
        let customView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 115, width: self.frame.size.width, height: 120))
        
        customView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.05).cgColor
        customView.layer.shadowOpacity = 1
        customView.layer.shadowOffset = CGSize.zero
        customView.layer.shadowRadius = 4
        customView.layer.shadowPath = UIBezierPath(rect: customView.bounds).cgPath
        customView.layer.shouldRasterize = true
        
        self.addSubview(customView)
    }
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.05
        self.layer.shadowRadius = 4
    }
    
    func animateTransition(time: TimeInterval? = nil) {
        let transition = CATransition()
        transition.duration = time ?? 1.0
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.layer.add(transition, forKey: nil)
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    /// EZSE: Centers view in superview horizontally
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.x = parentView.w/2 - self.w/2
    }
    
    /// EZSE: Centers view in superview vertically
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.y = parentView.h/2 - self.h/2
    }
    
    /// EZSE: Centers view in superview horizontally & vertically
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}


//MARK - UIImage

extension UIImage {
    public func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        var maybePixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         width,
                                         height,
                                         kCVPixelFormatType_32ARGB,
                                         attrs as CFDictionary,
                                         &maybePixelBuffer)
        
        guard status == kCVReturnSuccess, let pixelBuffer = maybePixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
        
        guard let context = CGContext(data: pixelData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            else {
                return nil
        }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}


// MARK: - UIImageView

extension UIImageView {
    func tintImageColor(_ color: UIColor) {
        if let image = self.image {
            self.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            self.tintColor = color
        }
    }
    
    func setImageAnimated(_ image: UIImage) {
        self.image = image
        let transition = CATransition()
        transition.duration = 1.0
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.layer.add(transition, forKey: nil)
    }
}


extension UILabel {
//    func setHTMLText(_ textHTML: String) {
//
//        let fontName = /*self.font!.fontName*/ "HelveticaNeue"
//        let fontSize = /*self.font!.pointSize*/ CGFloat(15)
//
//        let modifiedFont = String(format:"<span style=\"font-family: \(fontName); font-size: \(fontSize)\">%@</span>", textHTML)
//        let attrStr = try! NSAttributedString(
//            data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
//            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
//            documentAttributes: nil)
//        self.attributedText = attrStr
//    }
}

// MARK: - UITextField

extension UITextField {
    func addCharactersSpacing(spacing: CGFloat, text: String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: spacing, range: NSMakeRange(0, text.count))
        self.attributedText = attributedString
    }
}

// MARK: - UITextView

extension UITextView {
//    func setHTMLText(_ textHTML: String) {
//
//        let fontName = /*self.font!.fontName*/ "HelveticaNeue"
//        let fontSize = /*self.font!.pointSize*/ CGFloat(15)
//
//        let modifiedFont = String(format:"<span style=\"font-family: \(fontName); font-size: \(fontSize)\">%@</span>", textHTML)
//        let attrStr = try! NSAttributedString(
//            data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
//            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
//            documentAttributes: nil)
//        self.attributedText = attrStr
//    }
}


// MARK: - UIScrollView

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }
    
    func scrollToBottom(animated: Bool) {
        setContentOffset(CGPoint(x: contentOffset.x, y: contentSize.height - bounds.size.height + contentInset.bottom), animated: animated)
    }
}


// MARK: - UITableView

extension UITableView {
    /// Reloads rows of the section 0 with automatic animation
    func reloadDataAnimated(animation: UITableViewRowAnimation? = nil, animated: Bool? = nil) {
        guard let animated = animated, animated else {
            self.reloadData()
            return
        }
        self.reloadSections(IndexSet(integer: 0), with: animation ?? .automatic)
    }

    /// Return IndexPath for tableview in item clicked
    func indexPathClicked(_ sender: Any) -> IndexPath {
        let touchPoint = (sender as AnyObject).convert(CGPoint.zero, to: self)
        return self.indexPathForRow(at: touchPoint)!
    }
}


// MARK: - UICollectionView

extension UICollectionView {
    /// Reloads items of the section 0 with automatic animation
    func reloadDataAnimated() {
        self.reloadSections(IndexSet(integer: 0))
    }
    
    /// Return IndexPath for collectionview in item clicked
    func indexPathClicked(_ sender: Any) -> IndexPath {
        let touchPoint = (sender as AnyObject).convert(CGPoint.zero, to: self)
        return self.indexPathForItem(at: touchPoint)!
    }
}

extension UITabBarController {
    
    func setTabBarVisible(_ visible: Bool, animated: Bool) {
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animate the tabBar
        UIView.animate(withDuration: animated ? 0.3 : 0.0) {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
    
    
    // MARK: Getter only
    
    var tabBarIsVisible: Bool {
        return self.tabBar.frame.origin.y < self.view.frame.maxY
    }
}

extension UINavigationController {
    func setNavigationBarTranslucent(/*_ translucent: Bool*/) {
        //if translucent {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        /*} else {
            let bar = UIImage(named: "bar.png")?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 0)
            navigationBar.setBackgroundImage(bar, for: .default)
        }*/
    }
}

// MARK: - UIColor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// Use Hexadecimal color, followed after 0x... eg. UIColor(netHex: 0x009DE0)
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }
}

// MARK: - UIDevice
extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

// MARK: - UIAlertController
extension UIAlertController {
    static func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        UIViewController.topMostController.present(alert)
    }
}

// MARK: - Double
extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    var currency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(for: self) ?? ""
    }
    
    var currencyBR: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(for: self) ?? ""
    }
    
    var timeFormat: String {
        let ti = NSInteger(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, ms)
    }
    
    var timeFormatFormatted: String {
        let ti = NSInteger(self)
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        var durationString = hours > 0 ? String(format: "%dh", hours) : ""
        durationString += String(format: "%dmin", minutes)
        
        return durationString
    }
    
    var distanceFormat: String {
        return String(format: "%.2fkm", self/1000)
    }
}


// MARK: - Wnwrap
extension Optional where Wrapped == String {
    var unwrapped: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var unwrapped: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var unwrapped: Double {
        return self ?? 0
    }
}

extension Optional where Wrapped == Bool {
    var unwrapped: Bool {
        return self ?? false
    }
}

/*
// MARK: - Realm
import RealmSwift

extension Realm {
    func safeWrite(block: (() -> Void)) {
        if self.isInWriteTransaction {
            block()
            do {
                try self.commitWrite()
            } catch {
                print("\(error)")
            }
        } else {
            do {
                try self.write(block)
            } catch {
                print("\(error)")
            }
        }
    }
}
*/

