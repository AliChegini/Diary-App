//
//  Photo.swift
//  DiaryApp
//
//  Created by Ehsan on 17/12/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit

public class Photo {
    var imageData: NSData?
}


extension Photo {
    var image: UIImage {
        guard let imageData = self.imageData else {
            return UIImage()
        }
        return UIImage(data: imageData as Data)!
    }
}

