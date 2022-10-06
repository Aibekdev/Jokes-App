//
//  OnboardingScreenViewController.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class OnboardingScreenViewController: BaseViewController {
    
    // MARK: - Outlets
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height - 268)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.className)
        return collectionView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal);    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .customYellow
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = interactor?.pages.count ?? 0
        pc.currentPageIndicatorTintColor = .customYellow
        pc.layer.borderColor = UIColor.gray.cgColor
        pc.pageIndicatorTintColor = .customGray
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    // MARK: - Properties
    var router: OnboardingRoutingLogic?
    var interactor: OnboardingInteractor?
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubviews()
        setupLayouts()
    }
    
    // MARK: - Methods
    private func addSubviews() {
        [collectionView, pageControl, continueButton].forEach { view.addSubview($0) }
    }
    
    private func setupLayouts() {
        pageControl.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.height.equalTo(20)
            maker.right.left.equalToSuperview()
            maker.bottom.equalToSuperview().inset(160)
        }
        
        continueButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.height.equalTo(60)
            maker.width.equalTo(345)
            maker.bottom.equalToSuperview().inset(57)
        }
        
        collectionView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(88)
            maker.left.right.equalToSuperview()
            maker.bottom.equalTo(pageControl.snp.top).inset(201)
        }
    }
}

// MARK: - Actions
extension OnboardingScreenViewController {
    @objc private func handleNext() {
        let currentPage = pageControl.currentPage
        let pagesCount = interactor?.pages.count ?? .zero
        let nextIndex = min(currentPage + 1, pagesCount - 1)
        executeNext(nextIndex: nextIndex)
    }
    
    private func executeNext(nextIndex: Int) {
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: indexPath,
                                    at: .left,
                                    animated: true)
        collectionView.isPagingEnabled = true
        
        let title = nextIndex == 2 ? "Start" : "Next"
        
        continueButton.setTitle(title, for: .normal);
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension OnboardingScreenViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let nextIndex = Int(x / view.frame.width)
        executeNext(nextIndex: nextIndex)
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate
extension OnboardingScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.className, for: indexPath) as! PageCell
        guard let page = interactor?.pages[indexPath.row] else { return cell }
        cell.updateUI(page: page)
        return cell
    }
}

extension OnboardingScreenViewController: OnboardingPresentorOutput {
    func displayData(pages: [PageModel]) {
        pageControl.numberOfPages = pages.count
        collectionView.reloadData()
    }
}
