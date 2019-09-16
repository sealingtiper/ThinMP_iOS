import UIKit
import MediaPlayer

class AlbumDetailViewController: UIViewController {
    
    var arg: String!
    
    @IBOutlet var primaryText: UILabel!
    @IBOutlet var secondlyText: UILabel!
    @IBOutlet var artworkView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAsync()
    }
    
    func setAsync() {
        let property = MPMediaPropertyPredicate(value: self.arg, forProperty: MPMediaItemPropertyAlbumPersistentID)
        let query = MPMediaQuery.albums()
        query.addFilterPredicate(property)
        let albums = query.items
        
        if (albums?.count)! > 0 {
            let album = albums?[0]
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.primaryText.text = album!.albumTitle
                    self.secondlyText.text = album!.albumArtist
                    
                    if let artwork = album!.artwork {
                        self.artworkView.contentMode = UIView.ContentMode.scaleAspectFill
                        self.artworkView.clipsToBounds = true
                        self.artworkView.image = artwork.image(at: self.artworkView.bounds.size)
                    }
                }
            }
        }
    }
}
