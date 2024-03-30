//
//  ColorEnum.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit

public enum ColorEnum {
    case bg
    case black10
    case black20
    case black30
    case black40
    case black70
    case primary10
    case primary20
    case primary30
}

public class Color: NSObject {
    public class func getColor(name: ColorEnum) -> UIColor? {
        switch name {
        case .bg:
            return UIColor(named: "Bg", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black10:
            return UIColor(named: "black10", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black20:
            return UIColor(named: "black20", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black30:
            return UIColor(named: "black30", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black40:
            return UIColor(named: "black40", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .black70:
            return UIColor(named: "black70", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .primary10:
            return UIColor(named: "primary10", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .primary20:
            return UIColor(named: "primary20", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        case .primary30:
            return UIColor(named: "primary30", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
            
        }
    }
}
