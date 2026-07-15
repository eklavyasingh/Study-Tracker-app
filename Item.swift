//
//  Item.swift
//  Lead Time
//
//  Created by Eklavya Singh M S on 13/07/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
