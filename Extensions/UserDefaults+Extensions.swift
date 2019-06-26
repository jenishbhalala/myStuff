//
//  UserDefaults+Extensions.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import UIKit
import Foundation

extension UserDefaults {
    
    func setCustomObjToUserDefaults(CustomeObj: AnyObject, forKey:String) {
        
        let defaults = UserDefaults.standard
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: CustomeObj)
        defaults.set(encodedData, forKey: forKey)
        defaults.synchronize()
    }
    
    func getCustomObjFromUserDefaults(forKey:String) -> AnyObject? {
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: forKey) != nil {
            let decoded  = defaults.object(forKey: forKey) as! NSData
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)! as AnyObject
            return decodedTeams
        }
        return nil
    }
    
    func removeCustomObject(forKey:String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKey)
        defaults.synchronize()
    }
    
}
