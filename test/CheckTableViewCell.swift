//
//  CheckTableViewCell.swift
//  test
//
//  Created by Audrey Lucas on 6/26/24.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject {
    func checkTableViewCell(_cell: CheckTableViewCell, didChangeCheckedState checked: Bool)
}

class CheckTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: CheckTableViewCellDelegate?
    
    @IBAction func checked(_sender: Checkbox) {
        updateChecked()
        delegate?.checkTableViewCell(_cell: self, didChangeCheckedState: checkbox.checked)
    }
    
    func set(title: String, checked: Bool) {
        label.text = title
        checkbox.checked = checked
        updateChecked()
    }
    
    private func updateChecked() {
        
        let attributedString = NSMutableAttributedString(string: label.text!)
                
                if checkbox.checked {
                    attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
                    print("Checkbox is checked, strikethrough added.")
                } else {
                    attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
                    print("Checkbox is unchecked, strikethrough removed.")
                }
                
                label.attributedText = attributedString
    }

    
}
