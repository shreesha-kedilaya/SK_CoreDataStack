//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
class CoreDataStack {
    init() {
        initializeCoreData()
    }
    
    func initializeCoreData() {
      print("Called the parent")
    }
}

class CoreDataInheritence: CoreDataStack {
    override init() {
        super.init()
    }

    fileprivate fileprivate (set) var integer: Int?
    
    override func initializeCoreData() {
        print("Called the child")

        integer = 3
    }
}

extension CoreDataInheritence {
    func changeTheValue() {
        integer = 8
    }
}

let inheritenceobject = CoreDataInheritence()
