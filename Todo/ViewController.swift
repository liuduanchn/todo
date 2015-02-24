//
//  ViewController.swift
//  Todo
//
//  Created by admin on 15/2/24.
//  Copyright (c) 2015年 jhpost. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []
var filterTodos:[TodoModel] = []

    func dateFromString(dateStr: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(dateStr)
        return date
    }


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [TodoModel(id: "1", image: "selected child", title: "1.去游乐场", date: dateFromString("2015-2-24")!),
            TodoModel(id: "2", image: "selected shopping", title: "2.购物", date: dateFromString("2014-3-28")!),
            TodoModel(id: "3", image: "selected phone", title: "3.打电话", date: dateFromString("2015-2-22")!),
            TodoModel(id: "4", image: "selected plane", title: "4.旅行", date: dateFromString("2015-2-23")!)]
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //设置默认隐藏搜索栏
        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK-UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == searchDisplayController?.searchResultsTableView{
            return filterTodos.count
        }
        else{
            return todos.count
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell
        //绑定数据
        //var todo = todos [indexPath.row] as TodoModel
        var todo : TodoModel
        if tableView == searchDisplayController?.searchResultsTableView{
            todo = filterTodos[indexPath.row] as TodoModel
        }
        else{
            todo = todos[indexPath.row] as TodoModel
        }
        
        
        var image = cell.viewWithTag(101) as UIImageView
        var title = cell.viewWithTag(102) as UILabel
        var date = cell.viewWithTag(103) as UILabel
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        //位置+语言
        let locale = NSLocale.currentLocale()
        let dateFormate = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormate
        date.text = dateFormatter.stringFromDate(todo.date)
        return cell
    }
    
    //MARK-UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todos.removeAtIndex(indexPath.row)
            //self.tableView.reloadData()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //修改tableViewCell
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    //editMode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    //移动tablecell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    //search
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool{
        filterTodos = todos.filter(){$0.title.rangeOfString(searchString) != nil }
        return true
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        println("closed")
        tableView.reloadData()
    }
    
    //sugue之间传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo"{
            var vc = segue.destinationViewController as DetailViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath{
                vc.todo = todos[index.row]
                
            }
        }
    }
    
    
}

