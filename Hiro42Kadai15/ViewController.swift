//
//  ViewController.swift
//  Hiro42Kadai15
//
import UIKit
class ViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var fruitsInStock = [CheckItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFruitsInStock()
    }
    private func initializeFruitsInStock() {
        fruitsInStock = [
            .init(name: "りんご", isChecked: false),
            .init(name: "みかん", isChecked: true),
            .init(name: "バナナ", isChecked: false),
            .init(name: "パイナップル", isChecked: true)
        ]
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifire = segue.identifier else { return }
        guard let navigationController = segue.destination as? UINavigationController else { return }

        switch identifire {
        case "Homesegue":
            guard let addFruitVc = navigationController.topViewController as? AddFruitViewController else { return }

            addFruitVc.setup { [weak self] fruits in
                self?.fruitsInStock.append(.init(name: fruits, isChecked: false))
                self?.tableView.reloadData()
                self?.dismiss(animated: true, completion: nil)
            } didTapCancel: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
        default: break
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
        checkImgaeView.image = item.isChecked ? UIImage(named: "checkmark") : nil
    }
}
