//
//  StringSizeProviderProtocol.swift
//  sport-matcher
//
//  Created by Dawid on 30/07/2024.
//

import UIKit

protocol StringSizeProviderProtocol {
    func widthOfString(text: String, usingFont font: UIFont) -> CGFloat
}
