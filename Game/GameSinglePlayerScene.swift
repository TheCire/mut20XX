//
//  GameSinglePlayerScene.swift
//  MUT20XX
//
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameSinglePlayerScene: SKScene {
	
	
	private var bgNode: SKNode!
	private var boardNode: BoardNode!
	private var game = Game.shared
	
	
	private var hasLoadedScene = false
	override func sceneDidLoad() {
		guard hasLoadedScene == false else { return }
		hasLoadedScene = true
		
		bgNode = childNode(withName: "background")!
		boardNode = bgNode.childNode(withName: "PlayerBoard") as! BoardNode
		
		lastUpdateTime = 0
		game.newGame()
		game.start()
	}
	
	
	
	
	
	// MARK: - Events
	
	override func keyDown(with event: NSEvent) {
//		switch event.keyCode {
//		default:
//			print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
//		}
	}
	
	
	
	
	
	
	// MARK: - Updating
	private var lastUpdateTime : TimeInterval = 0
	private var lastRotationTime : TimeInterval = 0

	override func update(_ currentTime: TimeInterval) {
		if lastUpdateTime == 0 {
			lastUpdateTime = currentTime
		}
		defer { lastUpdateTime = currentTime }
		
		
		let timing = Game.UpdateTiming(now: currentTime, delta: currentTime - lastUpdateTime)
		game.update(timing: timing)
		
		
		boardNode.board = game.state.localPlayer.state.board
		boardNode.fallingPiece = game.state.localPlayer.state.currentPiece
	}
}
