//
//  AddFruitViewController.swift
//  Hiro42Kadai15
//
//  Created by 白石裕幸 on 2021/12/06.
//

import UIKit

protocol AddFruitViewControllerDelegate: AnyObject {
    func getFruit(checkItem: CheckItem)
}

class AddFruitViewController: UIViewController {
    @IBOutlet private weak var enterFruitTextField: UITextField!

    weak var delegate: AddFruitViewControllerDelegate?

    @IBAction private func executeSaveButton(_ sender: Any) {
        guard let text = enterFruitTextField.text, !text.isEmpty else { return }
        delegate?.getFruit(checkItem: .init(name: text, isChecked: false))
    }
}
