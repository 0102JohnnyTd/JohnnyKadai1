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
        // エラーが発生する可能性のある処理の記述
        do {
            // textFieldの値をInt型に変換
            let firstValue = firstValueTextField.textToInt
            let secondValue = secondValueTextField.textToInt
            let thirdValue = thirdValueTextField.textToInt
            let fourthValue = fourthValueTextField.textToInt
            let fifthValue = fifthValuetextField.textToInt
            // Int型の合計値を集める箱を宣言
            var totalValue = 0
            // extensionで追加したInt型の拡張機能であるaddingReportingOverflowWithErrorメソッドを実行
               // addingReportingOverflowWithError()メソッドはthrowsキーワードがついているため、実行前にtryをつける
            totalValue = try totalValue.addingReportingOverflowWithError(firstValue)
            totalValue = try totalValue.addingReportingOverflowWithError(secondValue)
            totalValue = try totalValue.addingReportingOverflowWithError(thirdValue)
            totalValue = try totalValue.addingReportingOverflowWithError(fourthValue)
            totalValue = try totalValue.addingReportingOverflowWithError(fifthValue)
            // エラーが発生しなかった場合の処理
            resultLabel.text = String(totalValue)
        } // エラーが発生した場合の処理の記述
        catch {
            // エラーの分岐
            switch error {
            case is OverflowError:
                resultLabel.text = "合計値が大きすぎるため扱えません"
            default:
                resultLabel.text = "不明のエラーが発生しました"
            }
        }
    }

    @IBOutlet weak private var resultLabel: UILabel!
}

// 修飾子extensionでUITextFieldクラスにコンピューテッドプロパティを追加する
extension UITextField {
    // String?型のtextプロパティをInt型に変換して値を取得するコンピューテッドプロパティの宣言
    var textToInt: Int {
        // flatMap(_:)メソッドでtextをString？型からInt型に変換　する
        let convertedValue = text.flatMap { Int($0) } ?? 0
        // 戻り値
        return convertedValue
    }
}
// Errorプロトコルに準拠した構造体を生成
private struct OverflowError: Error {}

// extensionでInt型に拡張機能を追加
private extension Int {
    // throwsをつけてメソッドの中でエラー処理の記述を可能にする
    func  addingReportingOverflowWithError(_ other: Int) throws -> Int {
        // 定数resultにaddingReportingOverflow()メソッドを代入。
        let result = addingReportingOverflow(other)
        // 条件分岐
        guard !result.overflow else {
            // overflowがtrueの場合、throw文によってOverflowErrorを発生させる
            throw OverflowError()
        }
        // overflowがfalseの場合、全体の合計値を返す
           // addingReportingOverflow()メソッドの戻り値はtupleであるため、代入されたresultは値にアクセスできる
        return result.partialValue
    }
}
