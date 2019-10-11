//
//  TripsListView.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

protocol TripsListViewDelegate: class {
    func tripsListViewRetryButtonDidTap(_ view: TripsListView)
    func tripsListView(_ view: TripsListView, didSelectTripAt index: Int)
    func tripsListView(_ view: TripsListView, heightForCellAt index: Int) -> CGFloat
}

final class TripsListView: UIView {
    private(set) var tableView: UITableView!
    private var activityIndicator: UIActivityIndicatorView!
    private var retryButton: UIButton!
    
    weak var delegate: TripsListViewDelegate?
    
    func render() {
        self.backgroundColor = .black
        createBackgroundImageView()
        tableView = createTableView()
        activityIndicator = createActivityIndicator()
        retryButton = createRetryButton()
    }
    
    func setViewState(_ state: TripsListViewModel.ViewState) {
        switch state {
        case .finished:
            tableView.isHidden = false
            activityIndicator.stopAnimating()
            retryButton.isHidden = true
        case .error:
            tableView.isHidden = true
            activityIndicator.stopAnimating()
            retryButton.isHidden = false
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
            retryButton.isHidden = true
        }
    }
    
    @objc func retryTapped() {
        delegate?.tripsListViewRetryButtonDidTap(self)
    }
    
    // MARK: Private
    private func createBackgroundImageView() {
        let iv = UIImageView(image: UIImage(named: "Background"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iv)
        NSLayoutConstraint.activate([
            iv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iv.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iv.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            iv.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func createTableView() -> UITableView {
        let tv = UITableView(frame: .zero,
                             style: .grouped)
        tv.register(TripsListCell.self,
                    forCellReuseIdentifier: ViewConstants.tripsListCellIdentifier)
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.isHidden = true
        tv.separatorColor = .separaratorColor
        tv.separatorInset = .zero
        tv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tv)
        NSLayoutConstraint.activate([
            tv.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tv.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tv.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
        
        return tv
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let a = UIActivityIndicatorView(style: .medium)
        a.color = .white
        a.translatesAutoresizingMaskIntoConstraints = false
        addSubview(a)
        NSLayoutConstraint.activate([
            a.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            a.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        return a
    }
    
    private func createRetryButton() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle("Retry request", for: .normal)
        btn.isHidden = true
        btn.addTarget(self,
                      action: #selector(retryTapped),
                      for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(btn)
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        return btn
    }
}

extension TripsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.tripsListView(self,
                                       heightForCellAt: indexPath.row) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.tripsListView(self,
                                didSelectTripAt: indexPath.row)
    }
}
