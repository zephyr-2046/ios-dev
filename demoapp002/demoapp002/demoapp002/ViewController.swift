//
//  ViewController.swift
//  demoapp002
//
//  Created by zephyr yang on 2019-05-29.
//  Copyright © 2019 zephyr yang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" => int, people count = \(people.count)")

        return people.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("tableView:: return a cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let person = people[indexPath.row]
        
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String

        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //tableView.reloadData()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("viewDidLoad is called")
    }

    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default){
            
            [unowned self] action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else { return }
            
            // self.names.append(nameToSave)
            self.save(name: nameToSave)
            print("saveAction:: names count = \(self.people.count)")

            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let aEntity = NSEntityDescription.entity(forEntityName: "Zdata", in: managedContext)
        
        let person = NSManagedObject(entity: aEntity!, insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        person.setValue(23, forKeyPath: "age")
        
        // 4
        do {
            try managedContext.save()
            people.append(person)
        }catch let error as NSError {
            print("could not save. \(error). \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Zdata")
        
        do{
            people = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("could not do fecth, \(error), \(error.userInfo)")
        }
    }
}

