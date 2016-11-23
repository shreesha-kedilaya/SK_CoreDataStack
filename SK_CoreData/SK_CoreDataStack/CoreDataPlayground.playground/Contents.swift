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
    
    override func initializeCoreData() {
        print("Called the child")
    }
}

let inheritenceobject = CoreDataInheritence()