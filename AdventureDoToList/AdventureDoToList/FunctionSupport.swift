//
//  FunctionSupport.swift
//  AdventureDoToList
//
//  Created by Huy on 13/12/24.
//
import UIKit
import Foundation

func createAttributedTitleString(regularText: String, boldText: String, fontSize: CGFloat = 18, isReverse: Bool = false) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(
        string: regularText + " " + boldText,
        attributes: [

            .font: isReverse ?UIFont(name: "Bookerly Bold", size: fontSize)! : UIFont(name: "Bookerly", size: fontSize)!,
            .foregroundColor: UIColor.black
        ]
    )
    
    // Xác định phạm vi chữ in đậm
    let boldRange = (regularText + " " + boldText as NSString).range(of: boldText)
    attributedString.addAttributes(
        [
            .font: isReverse ?UIFont(name: "Bookerly", size: fontSize)! : UIFont(name: "Bookerly Bold", size: fontSize)!,
            .foregroundColor: UIColor.black // Thay đổi màu chữ in đậm nếu cần
        ],
        range: boldRange
    )
    
    return attributedString
}
