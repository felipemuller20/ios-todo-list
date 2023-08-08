//
//  TableViewController.swift
//  todolist
//
//  Created by Felipe Muller on 08/08/23.
//

import UIKit

class CreateTaskTableViewController: UITableViewController, UITextFieldDelegate { // textFieldDelegate para criar funçao de adicionar
    
    private var datePicker: UIDatePicker = UIDatePicker() // cria o datePicker para selecionar data e hora. no didLoad, determinar .dateAndTime
    private var selectedIndexPath: IndexPath?
    private var dateFormatter: DateFormatter = DateFormatter()
    
    @IBAction func tapSaveTaskButton(_ sender: Any) { // Botao "save" arrastado para cá como action. Sempre que clicado, aciona essa func
        print("Saved")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .dateAndTime
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // quantas loinhas terão em cada seção
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3 // quantas seções tem
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // Adiciona um title para cada section
        if section == 0 {
            return "Task Name"
        }
        if section == 1 {
            return "Category"
        }
        return "Date and Time"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // retorna as cells
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTimeTableViewCell
        datePicker.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 100)
        cell.dateTimeTextField.inputView = datePicker
        cell.dateTimeTextField.delegate = self // para dizer que o delegate é essa classe atual. Utilizaremos na funcáo textFieldDidBeginEditing...
        cell.dateTimeTextField.inputAccessoryView = accessoryView() // funçao para adicionar o toolbar para selecionar a data.
        return cell
    }

    
    // MARK: UITextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? DateTimeTableViewCell // superview pega as views acima. a celula está duas views abaixo da datetimetableview. No caso, cell seria o DateView e precisamos pegar o DateTimeTableViewCell
        if let dateCell = cell { // garante que existe
            self.selectedIndexPath = tableView.indexPath(for: dateCell) // passa para a variavel da classe par aindicar qual indexPath estamos e poder setar na cell correta.
        }
    }
    
    
    // MARK: UIView Functions
    func accessoryView() -> UIView { // Cria um "toolBar" para selecionar a hora. Essa toolBar irá aparecer apenas quando o datePicker também aparecer.
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(CreateTaskTableViewController.selectDate))
        
        toolBar.setItems([barItemSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func selectDate() {
        if let indexPath = self.selectedIndexPath {
            let cell = tableView.cellForRow(at: indexPath) as? DateTimeTableViewCell
            if let dateCell = cell {
                dateFormatter.dateFormat = "dd/MM/yyy HH:mm"
                dateCell.dateTimeTextField.text = dateFormatter.string(from: datePicker.date) // ao clicar em done, seleciona a data na datetimetableviewcell
                self.view.endEditing(true) // remove o datepicker da tela
            }
        }
    }
}
