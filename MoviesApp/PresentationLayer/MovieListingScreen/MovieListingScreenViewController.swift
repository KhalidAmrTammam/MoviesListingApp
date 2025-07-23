//
//  MovieListingScreenViewController.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//

import UIKit
import Combine

class MovieListingScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    @Published private var searchText: String = ""
    private let viewModel: MovieListingViewModel
    private var cancellables = Set<AnyCancellable>()
    private var allMovies: [Movies] = []
    private var movies: [Movies] = []
    private var spinner: UIActivityIndicatorView?
    

    init(factory: UseCaseFactory = AppFactory.shared) {
        self.viewModel = MovieListingViewModel(useCase: factory.makeMovieListUseCase())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = MovieListingViewModel(useCase: AppFactory.shared.makeMovieListUseCase())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.fetchMovies()
        setupSearchBar()
       

    }

    private func setupSearchBar() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterMovies(searchText: text)
            }
            .store(in: &cancellables)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search movies..."
        searchBar.showsCancelButton = true
    }
    private func setupTableView() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.showSpinner()
                case .loaded(let movies):
                    self.removeSpinner()
                    self.allMovies = movies
                    self.movies = movies
                    self.tableView.reloadData()
                case .empty:
                    self.removeSpinner()
                    self.showMessage("No movies available.")
                case .error(let error):
                    self.removeSpinner()
                    self.showMessage("Something went wrong: \(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
    }

    private func showSpinner() {
        if spinner == nil {
            let newSpinner = UIActivityIndicatorView(style: .large)
            newSpinner.center = view.center
            newSpinner.startAnimating()
            view.isUserInteractionEnabled = false
            view.addSubview(newSpinner)
            spinner = newSpinner
        }
    }

    private func removeSpinner() {
        spinner?.stopAnimating()
        view.isUserInteractionEnabled = true
        spinner?.removeFromSuperview()
        spinner = nil
    }


    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

extension MovieListingScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped movie: \(movies[indexPath.row].title)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MovieListingScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchText = ""
    }


    private func filterMovies(searchText: String) {
        if searchText.isEmpty {
            movies = allMovies
        } else {
            movies = allMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }

}
