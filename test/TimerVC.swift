import UIKit

class TimerVC: UIViewController {

    var timer = Timer()
    var totalTime = 25 * 60 // 25 minutes in seconds
    var isTimerRunning = false
    
    let titleLabel = UILabel()
    let timerLabel = UILabel()
    let startButton = UIButton(type: .system)
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Title Label
        titleLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        titleLabel.center = CGPoint(x: view.center.x, y: 100)
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.text = "Pomodoro Timer"
        view.addSubview(titleLabel)
        
        // Setup Timer Label
        timerLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        timerLabel.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        timerLabel.font = UIFont.systemFont(ofSize: 48)
        timerLabel.textAlignment = .center
        timerLabel.text = timeString(time: TimeInterval(totalTime))
        view.addSubview(timerLabel)
        
        // Setup Start Button
        startButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        startButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        startButton.setTitle("Start Timer", for: .normal)
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.setTitleColor(UIColor.black, for: .normal)
        startButton.backgroundColor = UIColor(hex: "#D4AAA4")
        startButton.layer.cornerRadius = 10
        
        // Setup Reset Button
        resetButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        resetButton.center = CGPoint(x: view.center.x, y: view.center.y + 120)
        resetButton.setTitle("Reset Timer", for: .normal)
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.backgroundColor = UIColor(hex: "#D4AAA4")
        resetButton.layer.cornerRadius = 10
        view.addSubview(resetButton)
    }
    
    @objc func startTimer() {
        if !isTimerRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
            startButton.setTitle("Stop Timer", for: .normal)
        } else {
            timer.invalidate()
            isTimerRunning = false
            startButton.setTitle("Start Timer", for: .normal)
        }
    }
    
    @objc func resetTimer() {
        timer.invalidate()
        isTimerRunning = false
        totalTime = 25 * 60
        timerLabel.text = timeString(time: TimeInterval(totalTime))
        startButton.setTitle("Start Timer", for: .normal)
    }
    
    @objc func updateTimer() {
        if totalTime > 0 {
            totalTime -= 1
            timerLabel.text = timeString(time: TimeInterval(totalTime))
        } else {
            timer.invalidate()
            isTimerRunning = false
            startButton.setTitle("Start Timer", for: .normal)
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
