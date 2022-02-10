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

    @IBOutlet weak private var caluclateButton: UIButton!

    @IBAction private func didTapButton(_ sender: Any) {
        do {
            let firstValue = firstValueTextField.textToInt
            let secondValue = secondValueTextField.textToInt
            let thirdValue = thirdValueTextField.textToInt
            let fourthValue = fourthValueTextField.textToInt
            let fifthValue = fifthValuetextField.textToInt

            var totalValue = 0
            totalValue = try totalValue.addingReportingOverflowWithError(firstValue)
            totalValue = try totalValue.addingReportingOverflowWithError(secondValue)
            totalValue = try totalValue.addingReportingOverflowWithError(thirdValue)
            totalValue = try totalValue.addingReportingOverflowWithError(fourthValue)
            totalValue = try totalValue.addingReportingOverflowWithError(fifthValue)

            resultLabel.text = String(totalValue)
        } catch {
            switch error {
            case is OverflowError:
                resultLabel.text = "合計値が大きすぎるため扱うことができません"
            default:
                resultLabel.text = "不明なエラーです"
            }
        }
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

private struct OverflowError: Error {}

private extension Int {
    func addingReportingOverflowWithError(_ other: Int) throws -> Int {
        let result = addingReportingOverflow(other)

        guard !result.overflow else {
            throw OverflowError()
        }
        
        return result.partialValue
    }
}
