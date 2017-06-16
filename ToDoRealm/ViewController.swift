//
//  ViewController.swift
//  ToDoRealm
//
//  Created by ShinokiRyosei on 2017/05/04.
//  Copyright © 2017年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var todoes = { () -> Results<ToDo> in 

        let realm = try! Realm()
        return realm.objects(ToDo.self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()

        var sum: Int = 0
        for obj in todoes {

            sum = sum + obj.id
        }
    }

    @IBAction func add() {

        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return todoes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = todoes[indexPath.row].title
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "toDetail", sender: todoes[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetail" {

            let controller = segue.destination as! DetailViewController
            if let todo = sender as? ToDo {
                controller.todoId = todo.id
            }
        }
    }
}

