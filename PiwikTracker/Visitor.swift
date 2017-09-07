//
//  Visitor.swift
//  PiwikTracker
//
//  Created by Cornelius Horstmann on 26.02.17.
//  Copyright © 2017 PIWIK. All rights reserved.
//

import Foundation

struct Visitor {
    /// Unique ID per visitor (device in this case). Should be
    /// generated upon first start and never changed after.
    /// api-key: _id
    var id: String
    
    /// An optional user identifier such as email or username.
    /// api-key: uid
    var userId: String?
}

extension Visitor {
    static func current() -> Visitor {
        guard let id = PiwikUserDefaults.standard.clientId else {
            PiwikUserDefaults.standard.clientId = newVisitorID()
          print(PiwikUserDefaults.standard.clientId)
            return current()
        }
        print(id)
        //let userId: String? = nil // we can add the userid later
        guard let userId = PiwikUserDefaults.standard.userId else {
            let newUserId = "Offline User - \(id)"
            PiwikUserDefaults.standard.userId = newUserId
            return Visitor(id: id, userId: newUserId)
        }
        return Visitor(id: id, userId: userId)
    }
    
    static func newVisitorID() -> String {
      guard let id = Device.deviceID else {
        let uuid = UUID().uuidString
        let sanitizedUUID = uuid.replacingOccurrences(of: "-", with: "")
        let start = sanitizedUUID.startIndex
        let end = sanitizedUUID.index(start, offsetBy: 16)
        return sanitizedUUID.substring(with: start..<end)
      }
      return id
    }
}
