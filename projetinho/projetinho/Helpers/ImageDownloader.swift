import UIKit

protocol ImageDownloadable {
    func download(from url: URL, completion: @escaping (UIImage?) -> Void)
    func cancel()
}

final class ImageDownloader: ImageDownloadable {
    private var dataTask: URLSessionDataTask?
    private let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    func download(from url: URL, completion: @escaping (UIImage?) -> Void) {
        dataTask = session.dataTask(with: url) { data ,_ ,_ in
            guard let data = data else {
                return completion(nil)
            }
            completion(UIImage(data: data))
        }

        dataTask?.resume()
    }
    
    func cancel() {
        dataTask?.cancel()
    }
}


