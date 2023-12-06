# 開発環境
・Mac OS 14.0

・Xcode Version 15.0.1

・Swift 5.9


# Todoアプリの機能
・新規登録

・ログイン

・ログアウト

・Todoの一覧が見れる(未完了、完了済み別々で)

・Todoを作成できる(作成画面)

・Todoの編集ができる(編集画面)

・Todoの完了・削除ができる(一覧画面・編集画面でも)

#  新規登録・ログイン・ログアウト
<img width="200" alt="login.gif" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/514870/aad804e4-146e-d499-1901-851fba4497e2.gif">

# Todo作成・編集・削除
<img width="200" alt="todo.gif" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/514870/45e0a737-1fc0-641f-7ff8-e4d50ea46b07.gif">

# Storyboard
<img width="900" alt="image.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/514870/8300a109-4250-d1fa-4496-81c1b878743a.png">

# Firestoreのデータ構造

```
 users
  - ログインID
    - email (String)
  	- name (String)
  	- todos (SubCollection)
      - ランダムID
        - title (String)
        - detail (String)
        - isDone (Bool)
        - createdAt (timeStamp)

```
