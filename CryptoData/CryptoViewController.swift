//
//  ViewController.swift
//  CryptoData
//
//  Created by Мария Изюменко on 31.01.2022.
//

import UIKit

class CryptoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModels = [CryptoTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Nomics()
        tableView.separatorStyle = .none
        
    }
    
    func Nomics() {
        NomicsAPICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap ({ CryptoTableViewCellViewModel(
                    name: $0.name ?? "", symbol: $0.symbol ?? "", price: $0.price ?? "")
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("no good")
            }
        }
    }
    
    func sortAlert() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let sortPrice = UIAlertAction(title: "Sort by price", style: .default, handler: { [self] action in
            let priceSorted = [CryptoTableViewCellViewModel]()
            priceSorted.sorted (by: { $0.price < $1.price })
            
        })
        let sortName = UIAlertAction(title: "Sort by name", style: .default, handler: { action in
            let nameSorted = [CryptoTableViewCellViewModel]()
            nameSorted.sorted (by:{ $0.name < $1.name })
            
            
        })
                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
                ac.addAction(sortPrice)
                ac.addAction(sortName)
                ac.addAction(cancel)
                present(ac, animated: true, completion: nil)

            }
    
    @IBAction func sortButton(_ sender: UIBarButtonItem) {
        sortAlert()
    }
    
}

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else { fatalError()
       }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView (_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
