//
//  Untitled.swift
//  ChatApp_Project
//
//  Created by Huy on 29/12/24.
//

import UIKit

class DashedBorderView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        addDashedBorder()
    }
    
    private func addDashedBorder() {
        // Remove existing dashed borders before adding a new one
        self.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hex: "#128FEB").cgColor // Color of the dashes
        shapeLayer.lineWidth = 2                    // Thickness of the dashes
        shapeLayer.fillColor = nil                  // No fill color
        shapeLayer.lineDashPattern = [16, 8]         // Pattern: [dash length, gap length]
        shapeLayer.frame = self.bounds
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 25) // Adjust cornerRadius as needed
        shapeLayer.path = path.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
