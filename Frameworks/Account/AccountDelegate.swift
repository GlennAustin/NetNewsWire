//
//  AccountDelegate.swift
//  Account
//
//  Created by Brent Simmons on 9/16/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import Articles
import RSWeb

protocol AccountDelegate {

	// Local account does not; some synced accounts might.
	var supportsSubFolders: Bool { get }
	var opmlImportInProgress: Bool { get }
	
	var server: String? { get }
	var credentials: Credentials? { get set }
	var accountMetadata: AccountMetadata? { get set }
	
	var refreshProgress: DownloadProgress { get }

	func refreshAll(for account: Account, completion: (() -> Void)?)
	func sendArticleStatus(for account: Account, completion: @escaping (() -> Void))
	func refreshArticleStatus(for account: Account, completion: @escaping (() -> Void))
	
	func importOPML(for account:Account, opmlFile: URL, completion: @escaping (Result<Void, Error>) -> Void)
	
	func renameFolder(for account: Account, with folder: Folder, to name: String, completion: @escaping (Result<Void, Error>) -> Void)
	func deleteFolder(for account: Account, with folder: Folder, completion: @escaping (Result<Void, Error>) -> Void)

	func createFeed(for account: Account, url: String, completion: @escaping (Result<Feed, Error>) -> Void)
	func renameFeed(for account: Account, with feed: Feed, to name: String, completion: @escaping (Result<Void, Error>) -> Void)
	func deleteFeed(for account: Account, with feed: Feed, completion: @escaping (Result<Void, Error>) -> Void)
	
	func addFeed(for account: Account, to container: Container, with: Feed, completion: @escaping (Result<Void, Error>) -> Void)
	func removeFeed(for account: Account, from container: Container, with: Feed, completion: @escaping (Result<Void, Error>) -> Void)

	func restoreFeed(for account: Account, feed: Feed, folder: Folder?, completion: @escaping (Result<Void, Error>) -> Void)
	func restoreFolder(for account: Account, folder: Folder, completion: @escaping (Result<Void, Error>) -> Void)

	func markArticles(for account: Account, articles: Set<Article>, statusKey: ArticleStatus.Key, flag: Bool) -> Set<Article>?

	// Called at the end of account’s init method.
	func accountDidInitialize(_ account: Account)

	static func validateCredentials(transport: Transport, credentials: Credentials, completion: @escaping (Result<Bool, Error>) -> Void)
	
}
