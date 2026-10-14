import SwiftUI
import Kingfisher

public extension Image {

    static func load(
        url: String
    ) -> KFImage {
        let url = URL(string: url)
        return KFImage.url(url)
          .loadDiskFileSynchronously()
          .fade(duration: 0.25)
          .scaleFactor(UIScreen.main.scale)
    }
    
    static func loadCrop(
        url : String,
        size : CGSize
    ) -> KFImage {
        // anchor: Default is `CGPoint(x: 0.5, y: 0.5)`, which means the center of input image.
        let processor =  CroppingImageProcessor(size: size)
        
        let url = URL(string: url)
        return KFImage.url(url)
            .loadDiskFileSynchronously()
            .setProcessor(processor)
            .fade(duration: 0.25)
    }
    
    static func loadRoundCorner(
        url : String,
        size : CGSize,
        radius : CGFloat,
        cacheKey: String? = nil
    ) -> KFImage {
        let url = URL(string: url)

        let processor = RoundCornerImageProcessor(cornerRadius: radius)        
        return KFImage.url(url, cacheKey: cacheKey)
            .setProcessor(processor)
            .loadDiskFileSynchronously()
            .fade(duration: 0.25)
    }
    
    static func load(
        url : String,
        placeholderImage : Image?
    ) -> KFImage {
        let url = URL(string: url)

        return KFImage.url(url)
            .placeholder { placeholderImage }
            .loadDiskFileSynchronously()
            .fade(duration: 0.25)
    }
}
