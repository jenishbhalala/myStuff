//
//  UIViewController.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import UIKit

extension UIViewController
{
    func pushViewController(Storyboard:String,ViewController:String, animation:Bool)
    {
        let storyBoard = UIStoryboard(name: Storyboard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: ViewController)
        self.navigationController?.pushViewController(vc, animated: animation)
    }
    
    func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
            return topViewController(base: base)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    //MARK:- Activity
    func showIndicator(view: UIView) {
        let container: UIView = UIView()
        container.tag = 555
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3022527825)
        
        activityIndicator.frame = CGRect (x: 0, y: 0, width: 80, height: 80)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = container.center
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.main.async {
            container.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            view.addSubview(container)
        }
    }
    
    func hideIndicator(view: UIView) {
        DispatchQueue.main.async {
            view.viewWithTag(555)?.removeFromSuperview()
        }
    }
}

public func loadViewController(Storyboard:String,ViewController:String) -> UIViewController
{
    let storyBoard = UIStoryboard(name: Storyboard, bundle: nil)
    let vc = storyBoard.instantiateViewController(withIdentifier: ViewController)
    return vc
}

