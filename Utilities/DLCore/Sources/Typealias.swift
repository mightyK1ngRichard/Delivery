//
// Typealias.swift
// iOS-Delivery24
//
// Created by Dmitriy Permyakov on 13.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public typealias DLVoidBlock = () -> Void
public typealias DLViewBlock<T: UIView> = (T) -> Void
public typealias DLIntBlock = (Int) -> Void
public typealias DLStringBlock = (String) -> Void
public typealias DLBoolBlock = (Bool) -> Void
public typealias DLGenericBlock<T> = (T) -> Void
public typealias DLResultBlock<T, T1: Error> = (Result<T, T1>) -> Void
