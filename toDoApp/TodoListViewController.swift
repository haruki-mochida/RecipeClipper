//
//  TodoListViewController.swift
//  toDoApp
//
//  Created by 持田晴生 on 2023/11/16.
//

import UIKit
import Firebase


class TodoListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ①ログイン済みかどうか確認
        if let user = Auth.auth().currentUser {
            // ②ログインしているユーザー名の取得
            Firestore.firestore().collection("users").document(user.uid).getDocument(completion: {(snapshot,error) in
                if let snap = snapshot {
                    if let data = snap.data() {
                        self.userNameLabel.text = data["name"] as? String
                    }
                } else if let error = error {
                    print("ユーザー名取得失敗: " + error.localizedDescription)
                }
            })
        }
    }

    
    @IBAction func tapAddButton(_ sender: Any) {

    }
    
    @IBAction func tapLogoutButton(_ sender: Any) {
           // ①ログイン済みかどうかを確認
           if Auth.auth().currentUser != nil {
               // ②ログアウトの処理
               do {
                   try Auth.auth().signOut()
                   print("ログアウト完了")
                   // ③成功した場合はログイン画面へ遷移
                   let storyboard: UIStoryboard = self.storyboard!
                   let next = storyboard.instantiateViewController(withIdentifier: "ViewController")
                   self.present(next, animated: true, completion: nil)
               } catch let error as NSError {
                   print("ログアウト失敗: " + error.localizedDescription)
                   // ②が失敗した場合
                   let dialog = UIAlertController(title: "ログアウト失敗", message: error.localizedDescription, preferredStyle: .alert)
                   dialog.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(dialog, animated: true, completion: nil)
               }
           }
       }
    
    @IBAction func changeDoneControl(_ sender: UISegmentedControl) {

    }
    
}
