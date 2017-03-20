//
//  ViewController.swift
//  KVCExample
//
//  Created by Kazuhiro Ikeda on 2017/03/20.
//  Copyright © 2017年 ikezzi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var person = Person(name: "-", age: 0)
    
    enum section: Int {
        case `subscript`
        case method
    }

    enum row: Int {
        case set
        case get
        case error
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(person)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        case (section.subscript.rawValue, row.set.rawValue):
            
            setBySubscript()
            
        case (section.subscript.rawValue, row.get.rawValue):

            getBySubscript()

        case (section.subscript.rawValue, row.error.rawValue):
            
            errorBySubscript()
            
        case (section.method.rawValue, row.set.rawValue):
            
            setByMethod()
            
        case (section.method.rawValue, row.get.rawValue):
            
            getByMethod()
            
        case (section.method.rawValue, row.error.rawValue):
            
            errorByMethod()
            
        default:
            break
        }
    }
    
    private func setBySubscript() {
        
        // サブスクリプトを用いた値設定
        person["name"] = "John"
        person["age"] = 10
        print(person)
    }

    private func getBySubscript() {
        
        // サブスクリプトを用いた値取得
        let name = person["name"]
        let age = person["age"]
        print(name.debugDescription)
        print(age.debugDescription)
    }

    private func errorBySubscript() {
        
        // サブスクリプトを用いたエラー実装(設定時)
        person["hoge"] = "David"
        person["fuga"] = 30
        print(person)

        // サブスクリプトを用いたエラー実装(取得時)
        let name = person["hoge"]
        let age = person["fuga"]
        print(name.debugDescription)
        print(age.debugDescription)
    }

    private func setByMethod() {
        
        // setメソッドを用いた値設定
        do {
            try person.set(value: "Robert", key: "name")
            try person.set(value: 20, key: "age")
            print(person)
        } catch {
            print(error)
        }
    }

    private func getByMethod() {

        // getメソッドを用いた値取得
        do {
            let name = try person.get(key: "name") as? String
            let age = try person.get(key: "age") as? Int
            print(name.debugDescription)
            print(age.debugDescription)
        } catch {
            print(error)
        }
    }

    private func errorByMethod() {
        
        // メソッド用いたエラー実装(設定時)
        do {
            try person.set(value: "David", key: "hoge")
            try person.set(value: 30, key: "fuga")
            print(person)
        } catch {
            print(error)
        }

        // メソッドを用いたエラー実装(取得時)
        do {
            let name = try person.get(key: "hoge") as? String
            let age = try person.get(key: "fuga") as? Int
            print(name.debugDescription)
            print(age.debugDescription)
        } catch {
            print(error)
        }
    }
}

