import UIKit

class TaskDescriptionVC: UIViewController {
    
    var taskName: String?
    var onDescriptionChanged: ((String) -> Void)?
    var onPriorityChanged: ((String) -> Void)?
    
    private var descriptionText: String?
    private var priority: String?
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "Priority:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let prioritySegmentedControl: UISegmentedControl = {
        let items = ["Low", "Medium", "High"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 99/255, green: 118/255, blue: 166/255, alpha: 1.0) // #6376A6
        title = "Task Description"
        
        // Add subviews
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(priorityLabel)
        view.addSubview(prioritySegmentedControl)
        
        // Constraints for description label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for description text view
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Constraints for priority label
        NSLayoutConstraint.activate([
            priorityLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            priorityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priorityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Constraints for priority segmented control
        NSLayoutConstraint.activate([
            prioritySegmentedControl.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: 8),
            prioritySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            prioritySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Load existing description and priority from UserDefaults
        loadDescription()
        loadPriority()
        
        // Set task name as title
        if let taskName = taskName {
            self.title = taskName
        }
        
        // Customize back button color
        navigationController?.navigationBar.tintColor = .black
        
        // Add observer for text view changes
        NotificationCenter.default.addObserver(self, selector: #selector(descriptionDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)
        
        // Add target for priority segmented control changes
        prioritySegmentedControl.addTarget(self, action: #selector(priorityDidChange(_:)), for: .valueChanged)
    }
    
    @objc private func descriptionDidChange(_ notification: Notification) {
        descriptionText = descriptionTextView.text
        onDescriptionChanged?(descriptionText ?? "")
    }
    
    @objc private func priorityDidChange(_ segmentedControl: UISegmentedControl) {
        let selectedPriority = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        priority = selectedPriority
        onPriorityChanged?(selectedPriority ?? "Medium")
    }
    
    private func loadDescription() {
        if let taskName = taskName {
            descriptionText = UserDefaults.standard.string(forKey: "\(taskName)_description")
            descriptionTextView.text = descriptionText
        }
    }
    
    private func loadPriority() {
        if let taskName = taskName {
            priority = UserDefaults.standard.string(forKey: "\(taskName)_priority") ?? "Medium"
            switch priority {
            case "High":
                prioritySegmentedControl.selectedSegmentIndex = 2
            case "Medium":
                prioritySegmentedControl.selectedSegmentIndex = 1
            case "Low":
                prioritySegmentedControl.selectedSegmentIndex = 0
            default:
                prioritySegmentedControl.selectedSegmentIndex = 1
            }
        }
    }
}
