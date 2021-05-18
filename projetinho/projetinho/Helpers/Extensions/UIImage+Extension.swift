import UIKit
import Foundation

extension UIImageView {
    private enum AssociatedKeys {
        static var imageDownloaderKey = "image_downloader"
    }
    
    private var imageDownloader: ImageDownloadable? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.imageDownloaderKey) as? ImageDownloadable
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.imageDownloaderKey,
                    newValue as ImageDownloadable?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    func setImage(path: String, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = URL(string: path) else {
            completion?(nil)
            return
        }
        
        if imageDownloader == nil {
            imageDownloader = ImageDownloader()
        }
        cancelRequest()
        
        imageDownloader?.download(from: url) { [weak self] image in
            DispatchQueue.main.async {
                if let completion = completion {
                    completion(image)
                } else {
                    self?.image = image
                }
            }
        }
    }
    
    func cancelRequest() {
        imageDownloader?.cancel()
        image = nil
    }
}
