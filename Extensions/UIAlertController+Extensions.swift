//
//  UIAlertController+Extensions.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController
{
    
}


public func showAlert(Title:String,Message:String,delegate:UIViewController)
{
    let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    delegate.present(alert, animated: true, completion: nil)
}
