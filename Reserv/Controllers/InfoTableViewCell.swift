//
//  InfoTableViewCell.swift
//  Reserv
//
//  Created by Carlos Cardona on 12/10/20.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    
    var company: Company?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(_ comp:Company) {
        self.company = comp
        
        // Make sure that we have a company
        guard self.company != nil else {
            return
        }
        
        // Set the title and date Label
        self.companyName.text = company?.nombre
        
        // Set the thumbnail
        guard self.company!.logo != "" else {
            return
        }
        
        // Check cache before downloading data
        if let cachedData = CacheManager.getVideoCache(self.company!.logo) {
            
            // Set the thumbnail imageview
            self.companyLogo.image = UIImage(data: cachedData)
            return
        }
        
        // Download the thumbnail data
        let url = URL(string: self.company!.logo)
        
        // Get the shared url session object
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                // Save the data in cache
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                // Check that the downloades url matches the video thumbnail url that this cell is currently set to display
                if url!.absoluteString != self.company?.logo {
                    // Video cell has been recycled for another video
                    print("::: Is not")
                    return
                }
                // Create the image object
                let image = UIImage(data: data!)
                
                // Set ythe image vew
                DispatchQueue.main.async {
                    self.companyLogo.image = image
                }
                
                
            } 
        }
        // Start data task
        dataTask.resume()
    }

}
