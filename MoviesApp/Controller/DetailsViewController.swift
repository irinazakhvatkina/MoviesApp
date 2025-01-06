//
//  DetailsViewController.swift
//  MoviesApp
//
//  Created by Irina Zakhvatkina on 06/01/25.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    private let movie: Movie

    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let posterImageView = UIImageView()

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureMovieDetails()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)

        posterImageView.contentMode = .scaleAspectFit
        titleLabel.font = .boldSystemFont(ofSize: 24)
        overviewLabel.numberOfLines = 0

        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func configureMovieDetails() {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        if let posterPath = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
