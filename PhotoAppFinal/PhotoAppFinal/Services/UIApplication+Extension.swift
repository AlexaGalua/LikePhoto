//
//  UIApplication+Extension.swift
//  PhotoAppFinal
//
//  Created by A on 4/18/22.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
