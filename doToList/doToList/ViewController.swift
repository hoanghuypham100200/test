//
//  ViewController.swift
//  doToList
//
//  Created by Huy on 11/12/24.
//

import UIKit

class ViewController: UIViewController {
    var array: [PersonModel] = [
        PersonModel(name: "huy", age: 12),
        PersonModel(name: "nam", age: 13)
    ]
    var arrayString: [String] = ["5","4","7","27","1"]
    
    
    
    var numberInt : Int = 12
    var numberDouble : Double = 12.3
    var numberFloat : Float = 12.3
    var boolen : Bool = true
    let string : String = "hello world"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var array1 = array
        array1[1].name = "dai"
        print("===> 1")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            print("===> 2")
//        }
        
        for age in arrayString {
            if (age == "5") {
                break
            }
            print("age: ",age)
        }
        print(ScreenType.home)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("==>2")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("===>3")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("===>4")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("===>5")
    }
    
    
}

struct PersonModel: Codable {
   var name: String
   var age: Int
}

enum ScreenType: String {
   case home, setting, detail
}
