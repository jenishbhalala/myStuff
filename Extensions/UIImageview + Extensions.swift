//
//  UIImageview + Extensions.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import UIKit

extension UIImageView
{
    
    func circularImageView() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds=true
        self.layer.masksToBounds=true
    }
    func setSDWebImageFromURL(_ url : String) {
        self.sd_setImage(with: URL(string: url))
    }
}
