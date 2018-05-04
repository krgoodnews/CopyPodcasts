//
//  EpisodesController.swift
//  CopyPodcasts
//
//  Created by Goodnews on 2018. 3. 10..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
	
	var podcast: Podcast? {
		didSet {
			navigationItem.title = podcast?.trackName
			
			fetchEpisodes()
		}
	}
	
	fileprivate func fetchEpisodes() {
		print("Looking for episodes at feed url:", podcast?.feedUrl ?? "")
		
		guard let feedUrl = podcast?.feedUrl else { return }
		
		APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
			self.episodes = episodes
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	fileprivate let cellID = "cellID"
	
	var episodes: [Episode] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		setupNavigationBarButtons()
	}
	
	// MARK: - setup Work
	
	fileprivate func setupNavigationBarButtons() {
		
		navigationItem.rightBarButtonItems = [
			UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite)),
			UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchSavedPodcasts))
		]
	}
	
	@objc fileprivate func handleFetchSavedPodcasts() {
		print("Fetching saved Podcasts from UserDefaults")
		
		// how to retrieve our Podcast object from UserDefaults
		let savedPodcasts = UserDefaults.standard.savedPodcasts()
		
		savedPodcasts.forEach({ (p) in
			print(p.trackName ?? "")
		})
	}
	
	@objc fileprivate func handleSaveFavorite() {
		
		guard let podcast = self.podcast else { return }
		
		// 1. Transform podcast into data
		var listOfPodcasts = UserDefaults.standard.savedPodcasts()
		listOfPodcasts.append(podcast)
		
		let data = NSKeyedArchiver.archivedData(withRootObject: listOfPodcasts)
		
		UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey)
		print("Saving info into UserDefaults")

	}
	
	fileprivate func setupTableView() {
		let nib = UINib(nibName: "EpisodeCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: cellID)
		tableView.tableFooterView = UIView()
	}
	
	// MARK: - UITableView
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let episode = self.episodes[indexPath.row]

		UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
		
		
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.episodes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! EpisodeCell
		let episode = self.episodes[indexPath.row]
		
		cell.episode = episode
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 134
	}
	
	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
		activityIndicatorView.color = .darkGray
		activityIndicatorView.startAnimating()
		return activityIndicatorView
	}
	
	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return episodes.isEmpty ? 200 : 0
	}
}
