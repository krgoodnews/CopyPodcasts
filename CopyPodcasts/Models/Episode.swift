//
//  Episode.swift
//  CopyPodcasts
//
//  Created by Goodnews on 2018. 3. 11..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
	let title: String
	let pubDate: Date
	let description: String
	let author: String
	
	var imageUrl: String?
	
	
	init(feedItem: RSSFeedItem) {
		self.title = feedItem.title ?? ""
		self.pubDate = feedItem.pubDate ?? Date()
		self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
		self.author = feedItem.iTunes?.iTunesAuthor ?? ""
		
		self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
	}
}
