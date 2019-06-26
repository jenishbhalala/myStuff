//
//  Audio+Extensions.swift
//  Jenish
//
//  Created by Jenish on 08/09/2018.
//  Copyright © 2018  Jenish. All rights reserved.
//

import Foundation
import AudioToolbox

public func playNewMessageSound() {
    AudioServicesPlaySystemSoundWithCompletion(1307){}
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) 
}
