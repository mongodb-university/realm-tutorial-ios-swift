//
//  Models.swift
//  Task Tracker
//
//  Created by MongoDB on 2020-05-07.
//  Copyright © 2020 MongoDB, Inc. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    // TODO: Add User model (see SDKs panel in Realm UI)
}

class Project: EmbeddedObject {
    // TODO: Add Project model (see SDKs panel in Realm UI)
}

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

