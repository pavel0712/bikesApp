//
//  Notification+Name.swift
//  bikeCitizens
//
//  Created by Paul on 01.03.22.
//

import Foundation

extension Notification.Name {

    static var coreDataDidChange: Notification.Name {
          return .init(rawValue: "com.bike.coredata.didChange") }

}
