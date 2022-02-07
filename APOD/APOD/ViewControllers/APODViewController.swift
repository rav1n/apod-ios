//
//  APODViewController.swift
//  APOD
//
//  Created by Chouhan Ravindra on 30/01/22.
//

import UIKit

class APODViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UITextView!

    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewFullImageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let provider = APODDataProvider()
    var viewModel: APODViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = APODViewModel(provider: provider)
        configureUI()
        loadData()
    }

    private func loadData() {

        activityIndicator.startAnimating()
        viewModel?.viewModelUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.configureUI()
                self?.activityIndicator.stopAnimating()
                self?.viewFullImageButton.isHidden = false
            }
        }
    }

    private func configureErrorView() {
        let shouldShow = !provider.isRemoteConnectionAvailable && (viewModel?.isShowingOldModel ?? false)
        errorViewHeightConstraint.constant = shouldShow ? 70 : 20
        errorView.isHidden = !shouldShow
    }

    private func configureUI() {
        configureErrorView()
        titleLabel.text = viewModel?.title
        explanationLabel.text = viewModel?.explanation
        imageView.image = viewModel?.image
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFullImage" {
            let controller = segue.destination as! FullImageViewController
            controller.imageToShow = imageView.image
        }
    }

    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {

    }
}
