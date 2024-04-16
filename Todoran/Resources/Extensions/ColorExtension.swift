//
//  ColorExtension.swift
//  Todoran
//
//  Created by Doran on 4/10/24.
//

import SwiftUI
//원하는 컬러 생성
extension Color {
 
    static let peach = Color(hex: "#ff8882")
    static let ivory = Color(hex: "f8ede3")
    static let brown = Color(hex: "897853")  // #을 제거하고 사용해도 됩니다.
    
    static let purple01 = Color(hex: "f5c2fe")
    static let purple02 = Color(hex: "f0a2fd")
    static let purple03 = Color(hex: "ed92fd")
    
    static let pink01 = Color(hex: "FF8EA8")
    static let pink02 = Color(hex: "E7B0BA")
    static let pink03 = Color(hex: "FFDEE5")
    static let pink04 = Color(hex: "FF446F")
    static let pink05 = Color(hex:"FBEAEE")
    
    static let gray01 = Color(hex:"EAECEF")
    static let gray02 = Color(hex:"C7C7CC")
    static let gray03 = Color(hex:"8E8E93")
    
    
    static let selectDate = Color(hex:"FF89A3")
    static let todayDate = Color(hex:"BCC9E2")
    static let scheduleDot = Color(hex:"FF446F")
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
