//
//  DetailViewController.swift
//  Todo
//
//  Created by admin on 15/2/24.
//  Copyright (c) 2015年 jhpost. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItem.delegate = self
        // Do any additional setup after loading the view.
        if todo == nil{
            childButton.selected = true
            navigationController?.title = "新增Todo"
            navigationItem.title = "新增Todo"
        }
        else {
            navigationController?.title = "修改Todo"
            navigationItem.title = "修改Todo"
            if todo?.image == "selected child"{
                childButton.selected = true
            }
            else if todo?.image == "selected shopping"{
                shoppingButton.selected = true
            }
            else if todo?.image == "selected phone"{
                phoneButton.selected = true
            }
            else if todo?.image == "selected plane"{
                travelButton.selected = true
            }
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons(){
        childButton.selected = false
        phoneButton.selected = false
        shoppingButton.selected = false
        travelButton.selected = false
    }
    
    @IBAction func childTap(sender: AnyObject) {
        resetButtons()
        childButton.selected = true
    }
    
    @IBAction func phoneTap(sender: AnyObject) {
        resetButtons()
        phoneButton.selected = true
    }
    
    @IBAction func shoppingTap(sender: AnyObject) {
        resetButtons()
        shoppingButton.selected = true
    }
    
    @IBAction func travelTap(sender: AnyObject) {
        resetButtons()
        travelButton.selected = true
    }
    
    @IBAction func okTap(sender: AnyObject) {

        var image = ""
        if childButton.selected {
            image = "selected child"
        }
        if phoneButton.selected {
            image = "selected phone"
        }
        if shoppingButton.selected {
            image = "selected shopping"
        }
        if travelButton.selected {
            image = "selected plane"
        }
        if todo == nil{
            //新增
            let uuuid = NSUUID().UUIDString
            var todo = TodoModel(id: uuuid, image: image, title: todoItem.text, date: todoDate.date)
            todos.append(todo)
        }
        else{
            //修改
            todo?.image = image
            todo?.title = todoItem.text
            todo?.date = todoDate.date
        }
        

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    } // called when 'return' key pressed. return NO to ignore.
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
