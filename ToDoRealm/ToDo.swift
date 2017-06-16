//
//  ToDo.swift
//  ToDoRealm
//
//  Created by ShinokiRyosei on 2017/05/04.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class ToDo: Object {

    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var detailDescription: String = ""
    dynamic var createdAt: NSDate = NSDate()
    dynamic var dueDate: NSDate = NSDate()

    override static func primaryKey() -> String? {

        return "id"
    }

    static func lastId() -> Int {

        let realm = try! Realm()
        if let todo = realm.objects(ToDo.self).sorted(byKeyPath: "id", ascending: false).first {

            return todo.id + 1
        } else {

            return 1
        }
    }

    func dayBegin() -> NSDate {

        let date = Date()
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .month, .day], from: date)
        let year = component.year!
        let month = String(format: "%02d", component.month!)
        let day = component.day!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.date(from: "\(year)/\(month)/\(day) 00:00:00")! as NSDate
    }
}
