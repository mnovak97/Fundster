//
//  ImageUploader.swift
//  Fundster
//
//  Created by Martin Novak on 02.11.2023..
//

import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader {
    
    func uploadProjectImage(image: UIImage,projectImage: Bool, completion: @escaping (String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
               
        var ref: StorageReference
        if projectImage {
            let filename = NSUUID().uuidString
            ref = Storage.storage().reference(withPath: "/projectImages/\(filename)")
        } else {
            let filename = NSUUID().uuidString
            ref = Storage.storage().reference(withPath: "/profileImages/\(filename)")
        }
        
        ref.putData(imageData, metadata: nil) {_, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
