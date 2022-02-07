//
//  FullImageViewController.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import UIKit

class FullImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var imageToShow: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = imageToShow
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
