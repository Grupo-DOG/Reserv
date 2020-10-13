//
//  AboutViewController.swift
//  Reserv
//
//  Created by Carlos Cardona on 13/10/20.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController {

    @IBOutlet var dogImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDogImageView()
    }
    
    func configureDogImageView() {
        dogImageView.image = UIImage(named: "dog")
        dogImageView.contentMode = .scaleAspectFill
    }
    @IBAction func grupoDogTapped(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://grupo-dog.github.io/Landing-Page/")!)
        present(vc, animated: true)
    }
}
