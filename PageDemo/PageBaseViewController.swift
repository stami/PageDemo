//
//  PageBaseViewController.swift
//  PageDemo
//
//  Created by Samuli Tamminen on 18.7.2017.
//  Copyright © 2017 Samuli Tamminen. All rights reserved.
//

import UIKit

class PageBaseViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!

    var pageViewController: PageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(PageBaseViewController.handleNextButtonTap))
        nextButton.addGestureRecognizer(tap)
    }

    @objc
    func handleNextButtonTap() {
        if pageControl.currentPage < pageControl.numberOfPages - 1 {
            // Go to next page
            pageViewController?.openPage(at: pageControl.currentPage + 1)
        } else {
            // Finish
            performSegue(withIdentifier: "unwindToMainViewController", sender: self)
        }

    }

    func updateNextButtonIfNeeded() {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            nextButton.setTitle("Finish", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if let pageViewController = segue.destination as? PageViewController {
            pageViewController.pageDelagate = self
            self.pageViewController = pageViewController
        }
    }
}

extension PageBaseViewController: PageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }

    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        updateNextButtonIfNeeded()
    }
}
