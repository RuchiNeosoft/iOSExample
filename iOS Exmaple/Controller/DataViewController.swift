//
//  DataViewController.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import UIKit
import SwiftUI

class DataViewController: UIViewController {

    @IBOutlet weak var FlottingCTA: UIView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var listContainer: UIView!
    private let viewModel: ViewModel
    private var currentIndex: Int {
        guard let currentVC = pageViewController.viewControllers?.first else { return 0 }
        return viewControllers.firstIndex(of: currentVC) ?? 0
    }
    private var viewControllers: [UIViewController] = .init()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

    init?(coder: NSCoder, withViewModel viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }

    private func setupUI() {
        viewControllers = viewModel.data.map { data in
            let imageView = ImageView(imageName: data.mainImage)
            let vc = UIHostingController(rootView: imageView)
            vc.view.frame = imageContainer.bounds
            _ = vc.view
            vc.view.layer.cornerRadius = 6
            vc.view.layer.masksToBounds = true
            return vc
        }

        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true)

        addChild(pageViewController)
        imageContainer.addSubview(pageViewController.view)
        pageViewController.view.frame = imageContainer.bounds
        pageViewController.didMove(toParent: self)
        flottingVC()
        updateList()
    }

    private func updateList() {
        let listView = ListView(data: viewModel.data[currentIndex].listItems)
        let listVC = UIHostingController(rootView: listView)
        listVC.view.frame = imageContainer.bounds
        _ = listVC.view

        listContainer.subviews.forEach { $0.removeFromSuperview() }
        addChild(listVC)
        listContainer.addSubview(listVC.view)
        listVC.view.frame = listContainer.bounds
        listVC.didMove(toParent: self)
    }
    
    private func flottingVC() {
        let flottingCTA = FlotingButtonView(data: viewModel.data[currentIndex].listItems)
        let flottingVC = UIHostingController(rootView: flottingCTA)
        _ = flottingVC.view
        self.FlottingCTA.addSubview(flottingVC.view)
        addChild(flottingVC)
        flottingVC.view.frame = FlottingCTA.bounds
        flottingVC.didMove(toParent: self)
    }
    

    private func getData() {
        Task {
            do {
                try await viewModel.getData()
                setupUI()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

extension DataViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        guard viewControllers.indices.contains(previousIndex) else { return nil }
        return viewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        guard viewControllers.indices.contains(nextIndex) else { return nil }
        return viewControllers[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        viewModel.data.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentIndex
    }
}

extension DataViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        updateList()
        flottingVC()
    }
}
