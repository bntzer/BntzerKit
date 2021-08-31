//
//  File.swift
//  
//
//  Created by Steve Bentz on 8/31/21.
//
#if os(iOS)
import Foundation
import UIKit

extension UILabel {

    func underline(_ on: Bool) {
        guard let text = text else { return }
        self.attributedText = nil
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        if on {
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        }
        // Add other attributes if needed
        self.attributedText = attributedText
    }
    
}
#endif
