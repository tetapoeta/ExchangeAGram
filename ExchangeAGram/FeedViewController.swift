//
//  FeedViewController.swift
//  ExchangeAGram
//
//  Created by alvaro on 27/10/14.
//  Copyright (c) 2014 Alvaro. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedArray:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        println("Inicio 1")
        
        let request = NSFetchRequest(entityName: "FeedItem")
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        println("Inicio 1.1")
        
        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
        feedArray = context.executeFetchRequest(request, error: nil)!
        
        println("Inicio 1.2")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func snapBarButtonItemTapped(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            var cameraController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaTypes
            cameraController.allowsEditing = false
            
            println("Pasamos por aqui 1")
            
            self.presentViewController(cameraController, animated: true, completion: nil)
            
            println("Pasamos por aqui 1.2")
        }
        else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            var photoLibraryController = UIImagePickerController()
            photoLibraryController.delegate = self
            photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            let mediaTypes:[AnyObject] = [kUTTypeImage]
            photoLibraryController.mediaTypes = mediaTypes
            photoLibraryController.allowsEditing = false
            
            println("Pasamos por aqui 2")
            
            self.presentViewController(photoLibraryController, animated: true, completion: nil)
            
            println("Pasamos por aqui 2.2")
        }
        else {
            var alertController = UIAlertController(title: "Alert", message: "Your device does not support a camera or photo library", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        println("Pasamos por aqui 3")
        
        
        let image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        /* Esta funcion convierte la imagen en una representacion en JPEG */
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: managedObjectContext!)
        let feedItem = FeedItem(
        
        println("Pasamos por aqui 3.1")
        
        feedItem.image = imageData
        feedItem.caption = "test caption"
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        feedArray.append(feedItem)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        println("Pasamos por aqui 3.2")
        
        self.collectionView.reloadData()
        
        println("Pasamos por aqui 3.3")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        println("@@@@@@@@@@@@@@@@@@@@@@@@@@")
        var cell:FeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FeedCell
        let thisItem = feedArray[indexPath.row] as FeedItem
        cell.imageView.image = UIImage(data: thisItem.image)
        cell.captionLabel.text = thisItem.caption
        
        return cell
    }
    
}