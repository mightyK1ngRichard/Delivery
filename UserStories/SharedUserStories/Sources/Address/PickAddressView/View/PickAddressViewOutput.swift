//
// PickAddressViewOutput.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 29.06.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

@MainActor
protocol PickAddressViewOutput {
    func onFirstAppear()
    func onTapReloadButton()
    func onPickAddress(addressID: Int)
    func onTapAddNewAddress()
}
