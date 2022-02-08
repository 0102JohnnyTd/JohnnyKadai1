//
//  ViewController.swift
//  JohnnyKadai1
//
//  Created by Johnny Toda on 2022/02/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var firstValueTextField: UITextField!

    @IBOutlet weak private var secondValueTextField: UITextField!

    @IBOutlet weak private var thirdValueTextField: UITextField!

    @IBOutlet weak private var fourthValueTextField: UITextField!

    @IBOutlet weak private var fifthValuetextField: UITextField!

    @IBOutlet weak private var caluclateButton: UIButton! {
        didSet {
            caluclateButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }
    @objc func didTapButton() {
        let firstValue = firstValueTextField.textToInt
        let secondValue = secondValueTextField.textToInt
        let thirdValue = thirdValueTextField.textToInt
        let fourthValue = fourthValueTextField.textToInt
        let fifthValue = fifthValuetextField.textToInt

        let total = firstValue + secondValue + thirdValue + fourthValue + fifthValue
        resultLabel.text = String(total)
    }

//    func executeCalculation() {
//        let firstValue:Int? = Int(firstValueTextField.text ?? "")
//        let secondValue:Int? = Int(secondValueTextField.text ?? "")
//        let thirdValue:Int? = Int(thirdValueTextField.text ?? "")
//        let fourthValue:Int? = Int(fourthValueTextField.text ?? "")
//        let fifthValue:Int? = Int(fifthValuetextField.text ?? "")
//
//        let result = firstValue + secondValue + thirdValue + fourthValue + fifthValue
//    }

    @IBOutlet weak private var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension UITextField {
    var textToInt: Int {
        let text = self.text
        let int = text.flatMap{Int($0)} ?? 0
        return int
    }
}
