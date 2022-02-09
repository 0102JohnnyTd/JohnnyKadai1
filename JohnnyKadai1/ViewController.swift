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

        let totalValue = firstValue + secondValue + thirdValue + fourthValue + fifthValue
        resultLabel.text = String(totalValue)

        // 入力値の合計がInt.maxを超えるとクラッシュするのを防ぎたかったが、結局わからなかった。
        //        if totalValue > Int.max {
        //            resultLabel.text = "合計値が大きすぎるため扱うことができません"
        //        } else {
        //            resultLabel.text = String(totalValue)
        //        }

    }

    @IBOutlet weak private var resultLabel: UILabel!
}

// 修飾子extensionでUITextFieldクラスにコンピューテッドプロパティを追加する
extension UITextField {
    // String?型のtextプロパティをInt型に変換して値を取得するコンピューテッドプロパティの宣言
    var textToInt: Int {
        // flatMap(_:)メソッドでtextをString？型からInt型に変換する
        let convertedValue = text.flatMap { Int($0) } ?? 0
        // 戻り値
        return convertedValue
    }
}
