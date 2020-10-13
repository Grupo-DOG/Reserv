//
//  ViewController.swift
//  Reserv
//
//  Created by Carlos Cardona on 12/10/20.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var reservLogoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var company = [Company]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureLogoImageView()
        
        configureUrlData()
        
    }
    
    func configureUrlData() {
        let urlString = "https://raw.githubusercontent.com/CarlosCardonaM/ReservJSON/main/companies"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                
            }
        }
    }
    
    func configureLogoImageView() {
        reservLogoImageView.layer.cornerRadius = CGFloat(10)
        reservLogoImageView.image = UIImage(named: "logo")
        reservLogoImageView.contentMode = .scaleAspectFill
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCompanies = try? decoder.decode(Companies.self, from: json) {
            company = jsonCompanies.companies
            tableView.reloadData()
        }
        
    }

}

// MARK: - Table View Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        company.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InfoTableViewCell
        
        let logo = company[indexPath.row].logo
        cell.companyLogo.image = UIImage(named: logo)
        
        let company = self.company[indexPath.row]
        cell.setCell(company)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = SFSafariViewController(url: URL(string: company[indexPath.row].url)!)
        present(vc, animated: true)
    }
    
    
}

