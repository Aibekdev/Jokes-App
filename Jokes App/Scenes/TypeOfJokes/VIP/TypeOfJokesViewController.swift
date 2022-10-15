//
//  TypeOfJokesViewController.swift
//  Jokes App
//
//  Created by Aibek on 14.10.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class TypeOfJokesViewController: BaseViewController {
    var router: TypeOfJokesRoutingLogic?
    var interactor: TypeOfJokesInteractor?
    

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.separatorInset = .zero
        table.allowsSelection = false
        table.rowHeight = 60
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TypeOfJokesCell.self, forCellReuseIdentifier: TypeOfJokesCell.className)
        return table
    }()
    
    private lazy var jokeHeaderView: TypeOfJokesHeaderView = {
        let view = TypeOfJokesHeaderView()
        let header = TypeOfJokesHeaderModel.init(label: "Type of Jokes")
                                         
        view.updateUI(model: header)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addSubviews()
        setupLayouts()
    }
    
    private func addSubviews() {
        [jokeHeaderView, tableView].forEach { view.addSubview($0) }
    }
    
    private func setupLayouts(){
        jokeHeaderView.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(jokeHeaderView.snp.bottom)
            maker.left.right.bottom.equalToSuperview()
        }
    }
}

//MARK: -UITableViewDataSource and UITableViewDelegate
extension TypeOfJokesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeOfJokesCell.className, for: indexPath) as? TypeOfJokesCell else { return UITableViewCell() }
        guard let joke = interactor?.cells[indexPath.row] as? TypeOfJokesModel else { return cell }
        cell.updateUI(model: joke)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.cells.count ?? 0
    }
}

extension TypeOfJokesViewController: TypeOfJokesPresenterOutput {
    func displayData() {
    }
}
