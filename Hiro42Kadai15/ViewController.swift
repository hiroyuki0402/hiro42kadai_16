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
        defaultValues()
        Practitioner.shared.actions { [weak self] text in
            self?.fruitsInStock.append(.init(name: text, isChecked: false))
            self?.tableView.reloadData()
        } back: {
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func defaultValues() {
        fruitsInStock.append(.init(name: "りんご", isChecked: false))
        fruitsInStock.append(.init(name: "みかん", isChecked: true))
        fruitsInStock.append(.init(name: "バナナ", isChecked: false))
        fruitsInStock.append(.init(name: "パイナップル", isChecked: true))
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

class Practitioner {
    static let shared = Practitioner()
    struct Event {
        static var save: (String) -> Void = {_ in }
        static var back: () -> Void = {}
    }
    private init() {}
    public func actions(save: @escaping(String) -> Void, back: @escaping() -> Void) {
        Event.save = save
        Event.back = back
    }
}
