//
//  ViewController.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 8.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class MovieListViewController: UIViewController {
    
    private let viewModel: MovieListViewModel
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        
        fetchPopularMovies()
        
        bindViewModel()

    }
    
    private func layoutUI() {
        view.backgroundColor = .white
        title = "Movies"
        
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageCellConfigurator.reuseId)
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoCellConfigurator.reuseId)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func fetchPopularMovies() {
        viewModel.fetchPopularMovies()
    }
    
    private func bindViewModel() {
        viewModel.didLoadTableItems = { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
//MARK: TableView Data Source
extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
        return cell
    }
}

//MARK: TableView Delegate
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let config = viewModel.movies[indexPath.row] as? InfoCellConfigurator {
            let selectedMovie = config.item
            let movieDetailViewModel = MovieDetailViewModel(movie: selectedMovie, service: MovieServiceImplementation())
            let page = MovieDetailsViewController(viewModel: movieDetailViewModel)
            
            navigationController?.pushViewController(page, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? ImageTableViewCell {
            cell.selectionStyle = .none
        }
        cell.contentView.layer.masksToBounds = true
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: CGFloat(44)), type: .ballRotateChase, color: #colorLiteral(red: 0, green: 0.1776865125, blue: 0.456256032, alpha: 1), padding: 2.0)
            spinner.startAnimating()
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            DispatchQueue.global(qos: .utility).async {
                self.viewModel.fetchPopularMovies()
                for _ in 0..<3 {
                    sleep(1)
                }
                DispatchQueue.main.async {
                    spinner.stopAnimating()
                    tableView.tableFooterView?.isHidden = true
                }
            }
        }
    }
    
}

