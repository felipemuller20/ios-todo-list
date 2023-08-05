//
//  TaskViewController.swift
//  todolist
//
//  Created by Felipe Muller on 05/08/23.
//

import UIKit

let collegeCategory = Category(name: "Faculdade", color: UIColor.red)
let workCategory = Category(name: "Trabalho", color: UIColor.blue)

let tasksList: [Task] = [
    Task(task: "Realizar as tarefas", category: collegeCategory),
    Task(task: "Organizar a agenda da semana de forma que tudo fique pronto para iniciar a semana com todas as tarefas já definidas por mim e pela equipe.", category: workCategory)
]

class TasksTableViewController: UITableViewController {
    private var dateFormatter: DateFormatter = DateFormatter() // cria um dateformatter que utilizaremos para setar as variáveis
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // setamos o retorno de "cell" como sendo uma view do tipo TaskTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell //TaskCell é o identifier que escolhemos lá na main view
        let task = tasksList[indexPath.row]
        
        dateFormatter.dateFormat = "HH:mm"
        cell.timeLabel.text = dateFormatter.string(from: task.date)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        cell.dateLabel.text = dateFormatter.string(from: task.date)
        
        cell.categoryLabel.text = task.category.name
        cell.categoryLabel.textColor = task.category.color
        cell.taskContentLabel.text = task.task
        cell.separatorView.backgroundColor = task.category.color
        
        return cell
    }
}
