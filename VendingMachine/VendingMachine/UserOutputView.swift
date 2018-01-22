//
//  UserOutputView.swift
//  VendingMachine
//
//  Created by Eunjin Kim on 2018. 1. 22..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class UserOutputView: OutputView {
    
    func printAddAmoutMenu(availableBeverage: [ObjectIdentifier:[Beverage]]) {
        for (index, menu) in availableBeverage.enumerated() {
            print("\(index+1))\(menu.value[0].kindOf) \(menu.value[0].price)(\(menu.value.count)개)")
        }
    }
    
    func printPurchaseBeverage(choiceBeverage: Beverage) {
        print("\(choiceBeverage.kindOf)를 구매하셨습니다. \(choiceBeverage.price)원을 차감합니다.")
    }
    
    func printCurrentCoins(coins: Int) {
        print("\n현재 투입한 금액이 \(coins)원입니다. 다음과 같은 음료가 있습니다.")
    }
    
    func printDoingMenu() {
        print("1. 금액추가(1 금액)")
        print("2. 음료구매(2 메뉴번호)")
        print("> ", terminator: "")
    }
    
    func menuOfPurchaseBeverage(menuNumber: Int, availableBeverage: [ObjectIdentifier : [Beverage]]) -> ObjectIdentifier {
        self.availableBeverage = availableBeverage
        do {
            let choiceBeverageKey = try getBeverageKey(menuNumber: menuNumber)
            if let choiceBeverage = availableBeverage[choiceBeverageKey]?.first {
                printPurchaseBeverage(choiceBeverage: choiceBeverage)
                return choiceBeverageKey
            }
        }catch {
            print("get Beverage error")
        }
        return ObjectIdentifier(self)
    }
    
    func getBeverageKey(menuNumber: Int) throws -> ObjectIdentifier {
        for (index, beverage) in self.availableBeverage.enumerated() {
            if menuNumber == (index + 1) {
                return beverage.key
            }
        }
        throw InventoryBox.VendingMachinError.invalidBeverage
    }

}
