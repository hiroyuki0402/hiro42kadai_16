//
//  AddFruitViewController.swift
//  Hiro42Kadai15
//
//  Created by 白石裕幸 on 2021/12/06.
//

import UIKit
class AddFruitViewController: UIViewController {
   @IBOutlet private weak var enterFruitTextField: UITextField!

   @IBAction private func executeSaveButton(_ sender: Any) {
       guard let text = enterFruitTextField.text, !text.isEmpty else { return }
       Practitioner.Event.save(text)
       Practitioner.Event.back()
   }
   @IBAction private func executeCancelButton(_ sender: Any) {
       Practitioner.Event.back()
   }
}
