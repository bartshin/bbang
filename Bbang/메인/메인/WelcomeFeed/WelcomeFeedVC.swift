//
//  WelcomeFeedVC.swift
//  Bbang
//
//  Created by bart Shin on 26/05/2021.
//

import UIKit

class WelcomeFeedVC: SlideViewController {
	
	fileprivate var cards: [CardInfo] = CardInfo.dummyCards
	fileprivate var cardsIsOpened: [Bool] = []

	override func viewDidLoad() {
		self.itemSize = CGSize(width: 300, height: 250)
		super.viewDidLoad()
		
		registerCell()
		cardsIsOpened = Array(repeating: false, count: cards.count)
	}
	
	fileprivate func registerCell() {
	
		let nib = UINib(nibName: String(describing: WelcomeFeedCard.self), bundle: nil)
		collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: WelcomeFeedCard.self))
	}
}

extension WelcomeFeedVC {
	
	override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
		guard let cardCell = cell as? WelcomeFeedCard else {
			return
		}
		let toOpen = cardsIsOpened[indexPath.row]
		let card = cards[indexPath.row]
		cardCell.cardImage.image = UIImage(named: card.imageName)
		cardCell.titleLabel.text = card.title
		cardCell.descriptionText.text = card.description
		cardCell.changeState(toOpen: toOpen, animated: false)
	}
	 
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cardCell = collectionView.cellForItem(at: indexPath) as? SlideCardCell else {
			return
		}
		cardCell.changeState(toOpen: !cardsIsOpened[indexPath.row
		], animated: true)
		cardsIsOpened[indexPath.row].toggle()
	}
	
	override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		cardsIsOpened.enumerated().forEach { (index, isOpened) in
			if isOpened,
				 let cell = collectionView?.cellForItem(at: IndexPath(row: index, section: 0)) as? SlideCardCell {
				cell.changeState(toOpen: false)
				cardsIsOpened[index] = false
			}
		}
	}
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WelcomeFeedCard.self), for: indexPath)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		cards.count
	}
}

fileprivate struct CardInfo {
	var title: String
	var description: String
	var imageName: String
	
	static var dummyCards: [CardInfo] { [
		CardInfo(title: "????????? ?????????", description: "????????? ???????????? ????????? ????????? ????????? ?????? ???????????? ????????? ?????????", imageName: "cardimage1"),
	 CardInfo(title: "????????? ????????? ?????????", description: "???????????? ????????? ?????? ????????? ??????, ???????????? ??????????????? ?????? ????????? ?????????", imageName: "cardimage2"),
	 CardInfo(title: "??????????????? ???????????? ??????", description: "Italiano Tiramisu Cake", imageName: "cardimage3"),
	 CardInfo(title: "Card 4", description: "create your own egg & cheese sandwich ??? $4.50 add bacon, sausage or ham ??? $6.25 substitute egg whites ??? add $0.50. 1. BREAD (pick 1) ??? bagel (toasted)", imageName: "cardimage4"),
	 CardInfo(title: "Card 5", description: "create your own egg & cheese sandwich ??? $4.50 add bacon, sausage or ham ??? $6.25 substitute egg whites ??? add $0.50. 1. BREAD (pick 1) ??? bagel (toasted)", imageName: "cardimage5")
 ]}
}
