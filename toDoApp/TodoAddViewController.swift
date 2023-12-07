//
//  TodoAddViewController.swift
//  toDoApp
//
//  Created by 持田晴生 on 2023/11/16.
//

import UIKit
import Firebase


class TodoAddViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
// TextViewのレイアウトをTextField似合わせるためのコード
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        detailTextView.layer.cornerRadius = 5.0
        detailTextView.layer.masksToBounds = true
    }

    @IBAction func tapAddButton(_ sender: Any) {
        if let title = titleTextField.text,
            let detail = detailTextView.text {
                // ②ログイン済みか確認
            if let userId = Auth.auth().currentUser?.uid {
                Firestore.firestore().collection("users/\(userId)/todos").document().setData(
                    [
                     "title": title,
                     "detail": detail,
                     "isDone": false,
                     "createdAt": FieldValue.serverTimestamp()
                    ],merge: true
                    ,completion: { error in
                        if let error = error {
                            // error発生
                            print("TODO作成失敗: " + error.localizedDescription)
                            let dialog = UIAlertController(title: "TODO作成失敗", message: error.localizedDescription, preferredStyle: .alert)
                            dialog.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(dialog, animated: true, completion: nil)
                        } else {
                            // errorなし
                            print("TODO作成成功")
// ④Todo一覧画面に戻る
                            self.dismiss(animated: true, completion: nil)
                        }
                })
            }
        }
    }
}
