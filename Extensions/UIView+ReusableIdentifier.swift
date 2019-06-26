//
//  UIView+ReusableIdentifier.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import UIKit

protocol ReuseIdentifier {
  
  static var reuseIdentifier: String { get }
  
}

extension ReuseIdentifier {
  
  /// Return a suggested name that can be used as an cellIdentifier.
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
}

extension UICollectionViewCell: ReuseIdentifier {}
extension UITableViewCell: ReuseIdentifier {}
extension UITableViewHeaderFooterView: ReuseIdentifier {}
