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
            let textFields: [UITextField] = [firstValueTextField, secondValueTextField, thirdValueTextField, fourthValueTextField, fifthValuetextField]
            // textFieldの値をInt型に変換
            let values = textFields.map { $0.textToInt }
            // extensionで追加したInt型の拡張機能であるaddingReportingOverflowWithErrorメソッドを実行
               // addingReportingOverflowWithError()メソッドはthrowsキーワードがついているため、実行前にtryをつける
            let totalValue = try values.reduce(0, { try $0.addingReportingOverflowWithError($1) })
            // エラーが発生しなかった場合の処理
            resultLabel.text = "\(totalValue)"
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
    var textToInt: Int {
        text.flatMap { Int($0) } ?? 0
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
        // 条件: result.overflowの結果の否定
        guard !result.overflow else {
           // false:
             // 本来はfalse(overflowしてない場合)の処理を書くが、!resultとあるように否定している。
            throw OverflowError()
        }
        // true:
           // addingReportingOverflow()メソッドの戻り値はtupleであるため、代入されたresultは値にアクセスできる
        return result.partialValue
    }
}
