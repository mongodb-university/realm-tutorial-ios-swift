//
//  Models.swift
//  Task Tracker
//
//  Copyright © 2020-2021 MongoDB, Inc. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: String = ""
    @Persisted var name: String = ""
    @Persisted var memberOf: List<Project>
}
class Project: EmbeddedObject {
    @Persisted var name: String?
    @Persisted var partition: String?
    convenience init(partition: String, name: String) {
        self.init()
        self.partition = partition
        self.name = name
    }
}

enum TaskStatus: String {
  case Open
  case InProgress
  case Complete
}

class Task: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var owner: String?
    @Persisted var status: String = ""

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
