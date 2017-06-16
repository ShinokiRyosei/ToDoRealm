//
//  DetailViewController.swift
//  ToDoRealm
//
//  Created by ShinokiRyosei on 2017/05/04.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    @IBOutlet weak var dueDatePicker: UIDatePicker!

    var todoId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        descriptionTextField.delegate = self

        let realm = try! Realm()
        if let id = todoId, let todo = realm.objects(ToDo.self).filter("id == \(id)").first {
            titleTextField.text = todo.title
            descriptionTextField.text = todo.detailDescription
            dueDatePicker.date = todo.dueDate as Date
        }
    }

    @IBAction func save() {

        let realm = try! Realm()
        if let id = todoId, let todo = realm.objects(ToDo.self).filter("id == \(id)").first{

            if let title = titleTextField.text, let detailDescription = descriptionTextField.text {

                let realm = try! Realm()
                try! realm.write {

                    todo.title = title
                    todo.detailDescription = detailDescription
                    todo.dueDate = dueDatePicker.date as NSDate
                    realm.add(todo, update: true)
                }

                print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")
            }
        }
        else {

            if let title = titleTextField.text, let detailDescription = descriptionTextField.text {

                let todo = ToDo()
                todo.id = ToDo.lastId()
                todo.title = title
                todo.detailDescription = detailDescription
                todo.dueDate = dueDatePicker.date as NSDate

                let realm = try! Realm()
                try! realm.write {

                    realm.add(todo)
                }

                print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? "")
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
}
