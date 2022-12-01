//
//  ImageManager.swift
//  iGram
//
//  Created by Alexandr Kozin on 01.12.2022.
//

import Foundation
import FirebaseStorage // holds images and videos
import SwiftUI

let imageCache = NSCache<AnyObject, UIImage>()

class ImageManager {
    
    // MARK: PROPERTIES
    
    static let instance = ImageManager()
    
    private var REF_STOR = Storage.storage()
    
    
    // MARK: PUBLIC FUNCTIONS
    // Functions we call from other places in the app
    
    func uploadProfileImage(userID: String, image: UIImage) {
        
        // Get the path where we will save the image
        let path = getProfileImagePath(userID: userID)
        
        // Save image to path
        uploadImage(path: path, image: image) { (_) in }
    }
    
    func uploadPostImage(postID: String, image: UIImage, handler: @escaping (_ success: Bool) -> ()) {
        
        // Get the path where we will save the image
        let path = getPostImagePath(postID: postID)
        
        // Save image to path
        uploadImage(path: path, image: image) { (success) in
            handler(success)
        }
        
    }
    
    func downloadProfileImage(userID: String, handler: @escaping (_ image: UIImage?) -> ()) {
        
        // Get the path where the image is saved
        let path = getProfileImagePath(userID: userID)
        
        // Download the image from path
        downloadImage(path: path) { (returnedImage) in
            handler(returnedImage)
        }
    }
    
    func downloadPostImage(postID: String, handler: @escaping (_ image: UIImage?) -> ()) {
        
        // Get the path where the image is saved
        let path = getPostImagePath(postID: postID)
        
        // Download the image from path
        downloadImage(path: path) { (returnedImage) in
            handler(returnedImage)
        }
    }
    
    
    // MARK: PRIVATE FUNCTIONS
    // Functions we call from this file only
    
    private func getProfileImagePath(userID: String) -> StorageReference {
        let userPath = "users/\(userID)/profile"
        let storagePath = REF_STOR.reference(withPath: userPath)
        return storagePath
        
    }
    
    private func getPostImagePath(postID: String) -> StorageReference {
        let postPath = "posts/\(postID)/1"
        let storagePath = REF_STOR.reference(withPath: postPath)
        return storagePath
    }
    
    private func uploadImage(path: StorageReference, image: UIImage, hanlder: @escaping (_ success: Bool) -> ()) {
        
        var compression: CGFloat = 1.0 // Loops down by 0.05
        let maxFileSize: Int = 240 * 240 // Maximum file size that we want to save
        let maxCompression: CGFloat = 0.05 // Maximum compression we ever allow
        
        // Get image data
        guard var originalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            hanlder(false)
            return
        }
        
        // Check maximum file size
        while (originalData.count > maxFileSize) && (compression > maxCompression) {
            compression -= 0.05
            if let compressedData = image.jpegData(compressionQuality: compression) {
                originalData = compressedData
            }
            print(compression)
        }
        
        
        // Get image data
        guard let finalData = image.jpegData(compressionQuality: compression) else {
            print("Error getting data from image")
            hanlder(false)
            return
        }
        
        // Get photo metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Save data to path
        path.putData(finalData, metadata: metadata) { (_, error) in
            
            if let error = error {
                // ERROR
                print("Error uploading image. \(error)")
                hanlder(false)
                return
            } else {
                // SUCCESS
                print("Success uploading image")
                hanlder(true)
                return
            }
        }
    }
    
    private func downloadImage(path: StorageReference, handler: @escaping (_ image: UIImage?) ->()) {
        
        if let cachedImage = imageCache.object(forKey: path) {
            print("Image found in cache")
            handler(cachedImage)
            return
        } else {
            path.getData(maxSize: 27 * 1024 * 1024) { (returnedImageData, error) in
                
                if let data = returnedImageData, let image = UIImage(data: data) {
                    // Success getting image data
                    imageCache.setObject(image, forKey: path)
                    handler(image)
                    return
                } else {
                    print("Error getting data from path for image")
                    handler(nil)
                    return
                }
            }
        }
    }
    
}
