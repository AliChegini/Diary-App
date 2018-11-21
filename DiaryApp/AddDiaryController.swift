//
//  AddDiaryController.swift
//  DiaryApp
//
//  Created by Ehsan on 21/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

class AddDiaryController: UIViewController {
    
    @IBOutlet weak var userInput: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func save(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
