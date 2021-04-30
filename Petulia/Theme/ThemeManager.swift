//
//  ThemeManager.swift
//  Petulia
//
//  Created by Johan on 18.12.2020.
//  Copyright © 2020 Johandre Delgado . All rights reserved.
//

import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
  @Published private(set) var accentColor = Color.pink
  @Published private(set) var setDark = false
  
  @AppStorage(Keys.prefferedAccentColor) private var prefferedAccentColor = ""
  @AppStorage(Keys.isDark) private(set) var isDark = false
  
  private(set) var colors: [Color] = [
    .yellow,
    .goldNana,
    .orange,
    .greenShadow,
    .green,
    .greenSkirred,
    .blueLight,
    .blue,
    .picoBlue,
    .purpleVibes,
    .purpleLight,
    .purple,
    .red,
    .pink,
    .pinky,
    .sodaGrey

  ]
  
  init() {
    loadAccentColor()
  }

  func loadAccentColor() {
    if let loadedAccent = Color.color(from: prefferedAccentColor) {
      accentColor = loadedAccent
    } else {
      print("\n\(#function) - Unable to get accent color from: \(prefferedAccentColor)")
    }
  }
  
  func setAccentColor(to color: Color) {
    accentColor = color
    saveAccentColor()
  }
  
  func saveAccentColor() {
    let stringColor = Color.string(from: accentColor)
    prefferedAccentColor = stringColor
  }
  
  func loadDark() {
    if isDark {
      setDark = isDark
    } else {
      print("\n\(#function) - Unable to get darkness from: \(isDark)")
    }
  }
  
  func setDark(to settDark: Bool) {
    setDark = settDark
    saveDark()
  }
  
  func saveDark() {
    let darkValue = setDark
    isDark = darkValue
  }
  
}
