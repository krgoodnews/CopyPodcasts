//
//  CMTime+.swift
//  CopyPodcasts
//
//  Created by Goodnews on 2018. 3. 28..
//  Copyright © 2018년 krgoodnews. All rights reserved.
//

import AVKit

extension CMTime {

	func toDisplayString() -> String {
		
		// Float -> Int 과정에서 Fatal Error이 떠서 변경
		let floatTotalSeconds = CMTimeGetSeconds(self)
		guard !(floatTotalSeconds.isNaN || floatTotalSeconds.isInfinite) else {
			return "--:--"
		}
		let totalSeconds = Int(CMTimeGetSeconds(self))
//		print("Total seconds:", totalSeconds)
		
		let seconds = totalSeconds % 60
		let minutes = totalSeconds / 60
		
		let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
		
		return timeFormatString
	}
}
