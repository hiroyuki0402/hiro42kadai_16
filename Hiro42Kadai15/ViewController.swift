//
//  ViewController.swift
//  Hiro42Kadai15
//
import UIKit
class ViewController: UIViewController, AddFruitViewControllerDelegate {
    @IBOutlet private weak var tableView: UITableView!
    private var fruitsInStock = [CheckItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultValues()
    }

    private func defaultValues() {
        fruitsInStock.append(.init(name: "りんご", isChecked: false))
        fruitsInStock.append(.init(name: "みかん", isChecked: true))
        fruitsInStock.append(.init(name: "バナナ", isChecked: false))
        fruitsInStock.append(.init(name: "パイナップル", isChecked: true))
    }

    func didSave(checkItem: CheckItem) {
        dismiss(animated: true, completion: nil)
        fruitsInStock.append(checkItem)
        tableView.reloadData()
    }

    func didCancel() {
        dismiss(animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fruitsInStock[indexPath.row].isChecked.toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
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
