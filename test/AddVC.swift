import UIKit

class AddVC: UIViewController {
    // Timer properties
    var timer: Timer?
    var startTime: TimeInterval = 0
    var elapsedTime: TimeInterval = 0
    
    // UI components
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Add UI components
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        
        // Layout constraints
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 10),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func startTimer() {
        startTime = Date.timeIntervalSinceReferenceDate - elapsedTime
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    @objc func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        // Pass elapsed time to BreakVC
        let breakVC = ProgressVC()
        breakVC.elapsedTime = elapsedTime
        navigationController?.pushViewController(breakVC, animated: true)
        
        // Reset timer
        elapsedTime = 0
        updateTimerLabel()
    }
    
    @objc func updateTimerLabel() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        elapsedTime = currentTime - startTime
        
        let minutes = Int(elapsedTime / 60)
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60))
        let tenths = Int((elapsedTime * 10).truncatingRemainder(dividingBy: 10))
        
        timerLabel.text = String(format: "%02d:%02d:%01d", minutes, seconds, tenths)
    }
}
