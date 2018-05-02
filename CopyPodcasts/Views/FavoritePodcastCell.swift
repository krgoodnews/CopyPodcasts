//
//  FavoritePodcastCell.swift
//  CopyPodcasts
//
//  Created by Goodnews on 2018. 5. 2..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit

class FavoritePodcastCell: UICollectionViewCell {
	
	let imageView = UIImageView(image: #imageLiteral(resourceName: "appicon"))
	let nameLabel = UILabel()
	let artistNameLabel = UILabel()
	
	fileprivate func stylizeUI() {
		nameLabel.text = "Podcast Name"
		nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		artistNameLabel.font = UIFont.systemFont(ofSize: 14)
		artistNameLabel.text = "Artist Name"
		artistNameLabel.textColor = .lightGray
	}
	
	fileprivate func setupViews() {
		imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
		
		let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, artistNameLabel])
		
		stackView.axis = .vertical
		
		// enable auto layout
		stackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stackView)
		
		
		stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		stylizeUI()
		setupViews()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}