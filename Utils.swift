//
//  Utils.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import Foundation
import UIKit
import Photos
import SVProgressHUD

struct SCREEN {
    static var SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static var SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static var SCREEN_MAX_LENGTH    = max(SCREEN_WIDTH, SCREEN_HEIGHT)
    static var SCREEN_MIN_LENGTH    = min(SCREEN_WIDTH, SCREEN_HEIGHT)
}

struct DEVICE
{
    
    static let IS_IPHONE_4_OR_LESS  =  UIDevice.current.userInterfaceIdiom == .phone && SCREEN.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          =  UIDevice.current.userInterfaceIdiom == .phone && SCREEN.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          =  UIDevice.current.userInterfaceIdiom == .phone && SCREEN.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && SCREEN.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && SCREEN.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && SCREEN.SCREEN_MAX_LENGTH == 1366.0
    
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && (SCREEN.SCREEN_MAX_LENGTH == 812.0 || SCREEN.SCREEN_MAX_LENGTH == 896.0)
}
public class Utils{
    class Theme{
        
        static func colorPrimary() -> UIColor {
            return UIColor(hex: "#03A9F4")
        }
        
        static func colorWhiteSecondary() -> UIColor {
            return UIColor(hex: "#FCFEFF")
        }
        
        static func primaryTintColor() -> UIColor {
            return UIColor(hex: "#A2A5A6")
        }
        
        static func defaultFont(size:CGFloat = 20) -> UIFont {
            return UIFont(name: elMessiriFontRegular, size: size)!
        }
        
        static func strikeThroughColor() -> UIColor {
            return UIColor(hex:"#95989A")
        }
        
    }
    
    class Navigation{
        
        static func mainStoryboard(storyboard: String) -> UIStoryboard {
            return UIStoryboard(name: storyboard, bundle: nil)
        }
        
        static func instantiateViewController(storyboard: String, withIdentifier: String) -> UIViewController{
            return mainStoryboard(storyboard: storyboard).instantiateViewController(withIdentifier: withIdentifier) as UIViewController
        }
        
        static func rootController(storyboard: String, withIdentifier: String) {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let controller = self.instantiateViewController(storyboard: storyboard, withIdentifier: withIdentifier)
            appDelegate.window?.rootViewController = controller
            appDelegate.window?.makeKeyAndVisible()
        }
        
        static func rootNavController(storyboard: String, withIdentifier: String) {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let controller = self.instantiateViewController(storyboard: storyboard, withIdentifier: withIdentifier)
            let navigation = DBUINavigationController.init(rootViewController: controller)
            navigation.isNavigationBarHidden = true
            appDelegate.window?.rootViewController = navigation
            appDelegate.window?.makeKeyAndVisible()
        }
        
        static func introController(storyboard: String, withIdentifier: String) {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let controller = self.instantiateViewController(storyboard: storyboard, withIdentifier: withIdentifier) as! UIPageViewController
            
            appDelegate.window?.rootViewController = controller
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    class CardDetails{
        static func getCardImage(cardType: DBCreditCardType) -> UIImage{
            switch cardType {
            case .mastercard:
                return  #imageLiteral(resourceName: "masterCardLogo")
            case .visa,
                 .visaElectron:
                return   #imageLiteral(resourceName: "Visa")
            case .americanExpress:
                return  #imageLiteral(resourceName: "amexCardLogo")
            case .discovery:
                return  #imageLiteral(resourceName: "discoverCardLogo")
            case .maestro:
                return  #imageLiteral(resourceName: "maestroCardLogo")
            case .dinnersClub:
                return  #imageLiteral(resourceName: "Diners Club")
            case .jcb:
                return  #imageLiteral(resourceName: "JCB")
            default:
                return UIImage.init()
            }
        }
    }
    class Notification{
        
        enum AlertStyle {
            case info
            case success
            case error
            case warning
            case notice
        }
        // Mark: Notifications
        static func sendAlertNotification(title: String, message: String, style: AlertStyle){
            
            switch style {
            case .info:
                let alert = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: localizedString(key: "OK".localized()), style: UIAlertActionStyle.default, handler: nil))
                
                let controller = UIApplication.shared.keyWindow!.visibleViewController!
                controller.present(alert, animated: true, completion: nil)
            case .success:
              print("success")
            case .error:
                let alert = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: localizedString(key: "OK".localized()), style: UIAlertActionStyle.default, handler: nil))
        
                let controller = UIApplication.shared.keyWindow!.visibleViewController!
                controller.present(alert, animated: true, completion: nil)
            case .warning:
                print("warning")
            case .notice:
                print("notice")
            }
        }
    }
    
    static func SDKVersion() -> String? {
        if let path = Bundle.main.path(forResource: "OPPWAMobile-Resources.bundle/version", ofType: "plist") {
            if let versionDict = NSDictionary(contentsOfFile: path) as? [String: String] {
                return versionDict["OPPVersion"]
            }
        }
        return ""
    }
    
    static func amountAsString() -> String {
        return String(format: "%.2f", Config.amount) + " " + Config.currency
    }
    
    static func showResult(presenter: UIViewController, success: Bool, message: String?) {
        let title = success ? "Success" : "Failure"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: UIAlertActionStyle.default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    static func configureCheckoutSettings() -> OPPCheckoutSettings {
        let checkoutSettings = OPPCheckoutSettings.init()
        checkoutSettings.paymentBrands = Config.checkoutPaymentBrands
        checkoutSettings.shopperResultURL = Config.urlScheme + "://result"
        
        checkoutSettings.theme.navigationBarBackgroundColor = Config.mainColor
        checkoutSettings.theme.confirmationButtonColor = Config.mainColor
        checkoutSettings.theme.accentColor = Config.mainColor
        checkoutSettings.theme.cellHighlightedBackgroundColor = Config.mainColor
        checkoutSettings.theme.sectionBackgroundColor = Config.mainColor.withAlphaComponent(0.05)
        
        return checkoutSettings
    }

    
}
public enum EHttpStatusCode : Int {
    case OK = 200                       // /GET, /DELETE result is successful
    case CREATED = 201                  // /POST or /PUT is successful
    case NOT_MODIFIED = 304             // If caching is enabled and etag matches with the server
    case BAD_REQUEST = 400              // Possibly the parameters are invalid
    case INVALID_CREDENTIAL = 401       // INVALID CREDENTIAL, possible invalid token
    case NOT_FOUND = 404                // The item you looked for is not found
    case CONFLICT = 409                 // Conflict - means already exist
    case AUTHENTICATION_EXPIRED = 419   // Expired
    case NOT_IMPLEMENTED = 501
    case UNPROCESSIBLE_ENTITY = 422// Not implemented
}

func showProgress(maskType : SVProgressHUDMaskType = .none) {
    SVProgressHUD.show()
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(UIColor.clear)
    SVProgressHUD.setDefaultAnimationType(.native)
    SVProgressHUD.setDefaultMaskType(maskType)
}
func hideProgress() {
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
}

func localizedString(key:String)->String
{
        guard let path = Bundle.main.path(forResource: LanguageManager.currentLanguageCode(), ofType: "lproj") else {
            return ""
        }
        return Bundle(path: path)!.localizedString(forKey: key, value: nil, table: nil)
}


//func localizedString(key: String) -> String{
//
//    return NSLocalizedString(key, comment: "")
//}
func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
extension UIButton {
    @discardableResult func changeTintColor(imgName: String, color: UIColor) -> UIButton {
        let image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = color // set a color
        return self
    }
}
extension String {
    @discardableResult func splitString(text: String) -> [String] {
        let splitArr = text.split{$0 == " "}.map(String.init)
        return splitArr
    }
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
}
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String, fontName: String, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: fontName, size: size)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        boldString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSRange(location: 0, length: text.count))
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
extension String {
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

    init?(htmlEncodedString: String) {
        
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        
        guard let attributedString = try? NSAttributedString(data: data, options: [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
            ], documentAttributes: nil) else {
                return nil
        }
        self.init(attributedString.string)
    }
    
    func toDate( dateFormat format  : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: self)!
    }
}


extension Date {
    func toString(withFormat format: String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.isLenient = true
        formatter.locale = Locale.init(identifier: language())
        let myString = formatter.string(from: self)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        return formatter.string(from: yourDate!)
    }
}
extension CAShapeLayer {
    public func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}
//MARK: - Add badge to navigation rightbar button
public var handle: UInt8 = 0;

extension UIBarButtonItem {
    
    var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor(red: 200.0/255, green: 235.0/255, blue: 131.0/255, alpha: 1.0), andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x - 10), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - 4, y: offset.y), size: CGSize(width: 8, height: 16))
        label.foregroundColor = filled ? UIColor.black.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}


