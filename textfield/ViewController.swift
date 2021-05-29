//
//  ViewController.swift
//  textfield
//
//  Created by Inti Albuquerque on 29/05/21.
//

import UIKit
import SwiftUI
class ViewController: UINavigationController {
  
    override func viewDidLoad() {
        let vc = UIHostingController(rootView: MultipleTextFieldsView())
        self.pushViewController(vc, animated: true)
    }


}
