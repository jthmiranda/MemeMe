//
//  Meme.swift
//  MemeMe1.0
//
//  Created by Jonathan Miranda on 4/21/20.
//  Copyright © 2020 Jonathan Miranda. All rights reserved.
//

import UIKit



struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    static let memeTextAttribute: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor(named: "txtColor")!,
        .foregroundColor: UIColor(named: "strokeColor")!,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -4.0
    ]
          
    static let memeLabelAttribute: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor(named: "txtColor")!,
        .foregroundColor: UIColor(named: "strokeColor")!,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 15)!,
        .strokeWidth: -4.0
    ]
}
