//
//  PageViewController.swift
//  PageDemo
//
//  Created by Samuli Tamminen on 18.7.2017.
//  Copyright © 2017 Samuli Tamminen. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {

    func pageViewController(pageViewController: UIPageViewController,
                            didUpdatePageCount count: Int)

    func pageViewController(pageViewController: UIPageViewController,
                            didUpdatePageIndex index: Int)
}


class PageViewController: UIPageViewController {

    weak var pageDelagate: PageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }

        pageDelagate?.pageViewController(pageViewController: self, didUpdatePageCount: pages.count)
    }

    func openPage(at index: Int) {
        guard 0..<pages.count ~= index
            else { return }

        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
        pageDelagate?.pageViewController(pageViewController: self, didUpdatePageIndex: index)
    }

    private lazy var pages: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "firstPage"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondPage"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "thirdPage")
        ]
    }()
}

extension PageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.index(of: viewController),
            currentIndex > 0
            else { return nil }

        return pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let currentIndex = pages.index(of: viewController),
            currentIndex < pages.count - 1
            else { return nil }

        return pages[currentIndex + 1]
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let pageIndex = pages.index(of: firstViewController) {
            pageDelagate?.pageViewController(pageViewController: self, didUpdatePageIndex: pageIndex)
        }
    }
}
