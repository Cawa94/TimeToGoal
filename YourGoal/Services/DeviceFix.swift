//
//  DeviceFix.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 26/10/2020.
//

import Foundation
import DeviceKit

class DeviceFix: NSObject {

    static let currentDevice = Device.current

    override private init() {}

    static var isIpad: Bool {
        currentDevice.isPad
    }

    static var isSmallScreen: Bool {
        is47Screen || is40Screen
    }

    static var isRoundedScreen: Bool {
        is58Screen || is65Screen
    }

    static var is65Screen: Bool { // or 67
        currentDevice == .iPhoneXSMax
            || currentDevice == .iPhone11ProMax
            || currentDevice == .iPhone12ProMax
            || currentDevice == .simulator(.iPhoneXSMax)
            || currentDevice == .simulator(.iPhone11ProMax)
            || currentDevice == .simulator(.iPhone12ProMax)
    }

    static var is58Screen: Bool { // or 61
        currentDevice == .iPhoneX
            || currentDevice == .iPhoneXR
            || currentDevice == .iPhoneXS
            || currentDevice == .iPhone11
            || currentDevice == .iPhone11Pro
            || currentDevice == .iPhone12
            || currentDevice == .iPhone12Pro
            || currentDevice == .simulator(.iPhoneX)
            || currentDevice == .simulator(.iPhoneXR)
            || currentDevice == .simulator(.iPhoneXS)
            || currentDevice == .simulator(.iPhone11)
            || currentDevice == .simulator(.iPhone11Pro)
            || currentDevice == .simulator(.iPhone12)
            || currentDevice == .simulator(.iPhone12Pro)
    }

    static var is47Screen: Bool {
        currentDevice == .iPhone6
            || currentDevice == .iPhone6s
            || currentDevice == .iPhone7
            || currentDevice == .iPhone8
            || currentDevice == .simulator(.iPhone6)
            || currentDevice == .simulator(.iPhone6s)
            || currentDevice == .simulator(.iPhone7)
            || currentDevice == .simulator(.iPhone8)
    }

    static var is40Screen: Bool {
        currentDevice == .iPhone4
            || currentDevice == .iPhone4s
            || currentDevice == .iPhone5
            || currentDevice == .iPhone5c
            || currentDevice == .iPhone5s
            || currentDevice == .iPhoneSE
            || currentDevice == .iPhoneSE2
            || currentDevice == .iPhone12Mini
            || currentDevice == .simulator(.iPhone4)
            || currentDevice == .simulator(.iPhone4s)
            || currentDevice == .simulator(.iPhone5)
            || currentDevice == .simulator(.iPhone5c)
            || currentDevice == .simulator(.iPhone5s)
            || currentDevice == .simulator(.iPhoneSE)
            || currentDevice == .simulator(.iPhoneSE2)
            || currentDevice == .simulator(.iPhone12Mini)
    }

}
