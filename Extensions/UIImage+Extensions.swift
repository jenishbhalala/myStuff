//
//  UIImage+Extensions.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import Foundation
import UIKit

public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}

extension UIImage {
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .PNG: imageData = UIImagePNGRepresentation(self)
        case .JPEG(let compression): imageData = UIImageJPEGRepresentation(self, compression)
        }
        return imageData?.base64EncodedString()
    }
}
