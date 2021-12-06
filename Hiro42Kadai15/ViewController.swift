//
//  ViewController.swift
//  Hiro42Kadai15
//
import UIKit

class ViewController: UIViewController, AddFruitViewControllerDelegate {
    @IBOutlet private weak var tableView: UITableView!
    private var fruitsInStock = FruistList().fruitsInStock

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }

    func getFruit(checkItem: CheckItem) {
        dismiss(animated: true, completion: nil)
        fruitsInStock.append(checkItem)
        tableView.reloadData()
    }

    @IBAction private func addButton(_ sender: Any) {
        performSegue(withIdentifier: "Homesegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Homesegue" {

            guard let navigationController = segue.destination as? UINavigationController else { return }
            guard let addFruitVC = navigationController.topViewController as? AddFruitViewController else { return }
            addFruitVC.delegate = self
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitsInStock.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                as? FruitCell else { fatalError() }
        cell.configure(item: fruitsInStock[indexPath.row])
        return cell
    }

}

class FruitCell: UITableViewCell {
    @IBOutlet private weak var checkImgaeView: UIImageView!
    @IBOutlet private weak var fruitsNameLabel: UILabel!

    func configure(item: CheckItem) {
        fruitsNameLabel.text = item.name
        checkImgaeView.image = item.isChecked ? UIImage(named: "checkMark") : nil
    }
}
