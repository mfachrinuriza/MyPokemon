//
//  CustomUIView.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import UIKit

@IBDesignable
class CustomUIView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Corner Radius
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    // MARK: - Border
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.black.cgColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    // MARK: - Shadow
    
    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor ?? UIColor.black.cgColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffsetX: CGFloat {
        get {
            return self.layer.shadowOffset.width
        }
        set {
            self.layer.shadowOffset = CGSize(
                width: newValue,
                height: self.shadowOffsetY
            )
        }
    }
    
    
    @IBInspectable
    var shadowOffsetY: CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.shadowOffset = CGSize(
                width: self.shadowOffsetX,
                height: newValue
            )
        }
    }
    
    @IBInspectable var startColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }
    @IBInspectable var endColor: UIColor = .clear {
        didSet {
            updateGradient()
        }
    }
    
    // Create gradient layer
    let gradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        // Set the gradient frame
        gradientLayer.frame = rect
        
        // Set the colors
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        // Gradient is linear from left to right
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        // Add gradient layer into the button
        layer.insertSublayer(gradientLayer, at: 0)
        
        clipsToBounds = true
    }
    
    func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    func updateCornerRadius() {
        // Round the button corners
        layer.cornerRadius = cornerRadius
    }
}
