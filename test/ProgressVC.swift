import UIKit

class ProgressVC: UIViewController {
    var elapsedTime: TimeInterval = 0
    
    let elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add UI components
        view.addSubview(elapsedTimeLabel)
        
        // Layout constraints
        elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            elapsedTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            elapsedTimeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Start updating elapsed time label
        startUpdatingElapsedTime()
    }
    
    func startUpdatingElapsedTime() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElapsedTimeLabel), userInfo: nil, repeats: true)
    }
    
    @objc func updateElapsedTimeLabel() {
        elapsedTime += 0.1  // Update elapsed time by 0.1 seconds
        
        let minutes = Int(elapsedTime / 60)
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
        let tenths = Int((elapsedTime * 10).truncatingRemainder(dividingBy: 10))
        
        elapsedTimeLabel.text = String(format: "Elapsed Time: %02d:%02d:%01d", minutes, seconds, tenths)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()  // Stop the timer when leaving the view
    }
}
