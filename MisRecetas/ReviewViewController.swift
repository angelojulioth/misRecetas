//
//  ReviewViewController.swift
//  MisRecetas
//
//  Created by Angelo Valderrama on 4/5/17.
//  Copyright © 2017 Angelo Valderrama. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var ratingStackView: UIStackView!
    
    
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet var ratingButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    
    var ratingSelected : String?
    var recipe : Recipe!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImageView.image = recipe.image
        // transformar botones con las opciones de reviews - escalar a 0 y mandar hacia abajo en y
        let initialScale = CGAffineTransform(scaleX: 0, y: 0)
        let initialPosition = CGAffineTransform(translationX: 0, y: view.frame.size.height)
        self.dislikeButton.transform = initialScale.concatenating(initialPosition)
        self.ratingButton.transform = initialScale.concatenating(initialPosition)
        self.likeButton.transform = initialScale.concatenating(initialPosition)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
         */
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [], animations: {
            self.dislikeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (success) in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [], animations: {
                self.ratingButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { (success) in
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, options: [], animations: {
                    self.likeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            })
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func ratingPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            ratingSelected = "dislike"
        case 2:
            ratingSelected = "rating"
        case 3:
            ratingSelected = "like"
        default:
            break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }

    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            
        } else {
            
//            print("Dispositivo en modo retrato")
        }
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    // hide status bar
    override var prefersStatusBarHidden: Bool { return true }

}
