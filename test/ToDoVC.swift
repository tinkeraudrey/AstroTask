import UIKit

class ToDoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self // Set delegate to self for handling row actions
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        // Setting background color
        view.backgroundColor = UIColor(red: 211/255, green: 171/255, blue: 164/255, alpha: 1.0) // #D3ABA4
        table.backgroundColor = UIColor(red: 211/255, green: 171/255, blue: 164/255, alpha: 1.0) // #D3ABA4
        
        // "Add Task" button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.rightBarButtonItem?.tintColor = .black // Make button text color black
        
        // Set table view properties
        table.separatorStyle = .none // Optional: Remove cell separators
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list item!", preferredStyle: .alert)
        alert.addTextField { field in field.placeholder = "Enter item..."}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                    currentItems.append(text)
                    UserDefaults.standard.setValue(currentItems, forKey: "items")
                    self?.items.append(text)
                    self?.table.reloadData()
                }
            }
        }))
        
        present(alert, animated:true)
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.backgroundColor = UIColor(red: 211/255, green: 171/255, blue: 164/255, alpha: 1.0) // #D3ABA4
        
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // Enable editing for all rows
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (_, indexPath) in
            // Handle delete action
            self?.handleDelete(at: indexPath)
        }
        
        // Customize delete action background color
        deleteAction.backgroundColor = UIColor(red: 99/255, green: 118/255, blue: 166/255, alpha: 1.0) // #6376A6
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false // Disable cell highlighting
    }
    
    private func handleDelete(at indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .automatic)
        
        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
        currentItems.remove(at: indexPath.row)
        UserDefaults.standard.setValue(currentItems, forKey: "items")
    }
}
