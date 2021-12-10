
/**
 * Assignment 5
 * File Name:       DetailViewController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         3.0
 * Date Created:    December 10  2021
 */

import UIKit
import SQLite

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var todoName: UITextField!
    
    @IBOutlet weak var todoNotes: UITextField!
    
    @IBOutlet weak var hasDueDateSwitch: UISwitch!
    
    @IBAction func hasSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            self.todoDueDate.isHidden = true
        } else {
            self.todoDueDate.isHidden = false
        }
    }
    @IBOutlet weak var todoDueDate: UIDatePicker!
    
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    
    
    @IBAction func updateBtn(_ sender: UIButton) {
        
        let nameV: String = self.todoName.text!
        let notesV: String = self.todoNotes.text!
        let dueDateV: Date = self.todoDueDate.date
        let isCompletedV: Bool = self.isCompletedSwitch.isOn
        let hasDueDateV: Bool = self.hasDueDateSwitch.isOn
        do {
            let alert = UIAlertController(title: "Are you sure you want to update?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                Db().updateDate(
                    rowid: self.todoId!,
                    nameV: nameV,
                    isCompletedV: isCompletedV,
                    notesV: notesV,
                    hasDueDateV: hasDueDateV,
                    dueDateV: dueDateV )
                if let vc = self.storyboard?.instantiateViewController(identifier: "RootController") as? RootController
                {
                    self.navigationController?.popViewController(animated: true)

                }
            }))
            present(alert, animated: false)
            
        } catch {
            print(error)
        }
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        do {
            let alert = UIAlertController(title: "Are you sure you want to delete?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                Db().deleteDate( rowid: self.todoId! )
                
                if let vc = self.storyboard?.instantiateViewController(identifier: "RootController") as? RootController
                {
                    self.navigationController?.popViewController(animated: true)

                }
            }))
            present(alert, animated: false)
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        do {
            let alert = UIAlertController(title: "Are you sure you want to discard the changes?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
                
                if let vc = self.storyboard?.instantiateViewController(identifier: "RootController") as? RootController
                {
                    self.navigationController?.popViewController(animated: true)

                }
            }))
            present(alert, animated: false)
            
        } catch {
            print(error)
        }
    }
    
    var todoId: Int64?
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let isCompleted = Expression<Bool>("isCompleted")
    let notes = Expression<String>("notes")
    let hasDueDate = Expression<Bool>("hasDueDate")
    let dueDate = Expression<Date>("dueDate")

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let detail = Db().getById(rowid: todoId!)
       
        
        self.todoName.text = detail[0].name
        self.todoNotes.text = detail[0].notes
        self.todoDueDate.date = detail[0].dueDate
        
        self.isCompletedSwitch.isOn = detail[0].isCompleted
        self.hasDueDateSwitch.isOn = detail[0].hasDueDate
        
        if ( !self.hasDueDateSwitch.isOn ) {
       
            self.todoDueDate.isHidden = true
        } else {
            self.todoDueDate.isHidden = false
        }
        
    }
    

   
}
