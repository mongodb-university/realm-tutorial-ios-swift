//
//  Models.swift
//  Task Tracker
//
//  Created by MongoDB on 2020-05-07.
//  Copyright © 2020 MongoDB, Inc. All rights reserved.
//

import Foundation
import RealmSwift


enum TaskStatus: String {
  case Open
  case InProgress
  case Complete
}

class Task: Object {
    @objc dynamic var _id: ObjectId = ObjectId.generate()
    @objc dynamic var name: String = ""
    @objc dynamic var owner: String?
    @objc dynamic var status: String = ""
    override static func primaryKey() -> String? {
        return "_id"
    }

    var statusEnum: TaskStatus {
        get {
            return TaskStatus(rawValue: status) ?? .Open
        }
        set {
            status = newValue.rawValue
        }
    }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

struct Member {
    let id: String
    let name: String
    init(document: Document) {
        self.id = document["_id"]!!.stringValue!
        self.name = document["name"]!!.stringValue!
    }
}
