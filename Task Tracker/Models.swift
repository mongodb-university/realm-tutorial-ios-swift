//
//  Models.swift
//  Task Tracker
//
//  Copyright © 2020-2021 MongoDB, Inc. All rights reserved.
//

import Foundation
import RealmSwift


enum TaskStatus: String {
  case Open
  case InProgress
  case Complete
}

// TODO: Realm-ify Task model
class Task {
   var name: String = ""
   var statusEnum: TaskStatus = .Open
}

struct Member {
    let id: String
    let name: String
    init(document: Document) {
        self.id = document["_id"]!!.stringValue!
        self.name = document["name"]!!.stringValue!
    }
}
