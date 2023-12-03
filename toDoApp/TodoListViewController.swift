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

    // Firestoreから取得するTodoのid,title,detail,isDoneを入れる配列を用意
    var todoIdArray: [String] = []
    var todoTitleArray: [String] = []
    var todoDetailArray: [String] = []
    var todoIsDoneArray: [Bool] = []
    // 画面下部の未完了、完了済みを判定するフラグ(falseは未完了)
    var isDone: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
// ①ログイン済みかどうか確認
        if let user = Auth.auth().currentUser {

            // ユーザー名を取得する処理省略

            Firestore.firestore().collection("users/\(user.uid)/todos").whereField("isDone", isEqualTo: isDone).order(by: "createdAt").addSnapshotListener({ (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    var idArray:[String] = []
                    var titleArray:[String] = []
                    var detailArray:[String] = []
                    var isDoneArray:[Bool] = []
                    for doc in querySnapshot.documents {
                        let data = doc.data()
                        idArray.append(doc.documentID)
                        titleArray.append(data["title"] as! String)
                        detailArray.append(data["detail"] as! String)
                        isDoneArray.append(data["isDone"] as! Bool)
                    }
                    self.todoIdArray = idArray
                    self.todoTitleArray = titleArray
                    self.todoDetailArray = detailArray
                    self.todoIsDoneArray = isDoneArray
                    self.tableView.reloadData()

                } else if let error = error {
                    print("TODO取得失敗: " + error.localizedDescription)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard: UIStoryboard = self.storyboard!
        let next = storyboard.instantiateViewController(withIdentifier: "TodoEditViewController") as! TodoEditViewController
        next.todoId = todoIdArray[indexPath.row]
        next.todoTitle = todoTitleArray[indexPath.row]
        next.todoDetail = todoDetailArray[indexPath.row]
        next.todoIsDone = todoIsDoneArray[indexPath.row]
        self.present(next, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTitleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoTitleArray[indexPath.row]
        return cell
    }

    @IBAction func tapAddButton(_ sender: Any) {
        // ①Todo作成画面に画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let next = storyboard.instantiateViewController(withIdentifier: "TodoAddViewController")
        self.present(next, animated: true, completion: nil)
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
        switch sender.selectedSegmentIndex {
        case 0:
            isDone = false
            getTodoDataForFirestore()
        case 1:
            isDone = true
            getTodoDataForFirestore()
        default:
            isDone = false
            getTodoDataForFirestore()
        }
    }

    // FirestoreからTodoを取得する処理
    func getTodoDataForFirestore() {
        if let user = Auth.auth().currentUser {
            Firestore.firestore().collection("users/\(user.uid)/todos").whereField("isDone", isEqualTo: isDone).order(by: "createdAt").getDocuments(completion: { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    var idArray:[String] = []
                    var titleArray:[String] = []
                    var detailArray:[String] = []
                    var isDoneArray:[Bool] = []
                    for doc in querySnapshot.documents {
                        let data = doc.data()
                        idArray.append(doc.documentID)
                        titleArray.append(data["title"] as! String)
                        detailArray.append(data["detail"] as! String)
                        isDoneArray.append(data["isDone"] as! Bool)
                    }
                    self.todoIdArray = idArray
                    self.todoTitleArray = titleArray
                    self.todoDetailArray = detailArray
                    self.todoIsDoneArray = isDoneArray
                    print(self.todoTitleArray)
                    self.tableView.reloadData()

                } else if let error = error {
                    print("TODO取得失敗: " + error.localizedDescription)
                }
            })
        }
    }

}
