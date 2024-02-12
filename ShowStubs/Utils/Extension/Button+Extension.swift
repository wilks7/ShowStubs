//
//  Button+Extension.swift
//  ShowStubs
//
//  Created by Michael Wilkowski on 6/22/23.
//

import Foundation
import SwiftUI

extension Button where Label == Image {
  init(systemName: String, action: @escaping () -> Void) {
    self.init(action: action, label: { Image(systemName: systemName) })
  }
}
