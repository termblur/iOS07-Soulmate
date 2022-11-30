//
//  MyPageViewModel.swift
//  Soulmate
//
//  Created by hanjongwoo on 2022/11/23.
//

import Foundation
import Combine

struct MyPageViewModelActions {
    var showMyInfoEditFlow: (() -> Void)?
    var showServiceTermFlow: (() -> Void)?
    var showHeartShopFlow: (() -> Void)?
    var showDistanceFlow: (() -> Void)?
}

class MyPageViewModel {
    
    let symbols = ["myPageHeart", "myPagePersonalInfo", "distance", "myPagePin"]
    let titles = ["하트샵 가기", "개인정보 처리방침", "거리 설정하기", "버전정보"]
    let subTexts = ["", "", "", "v 3.2.20"]
    
    private weak var coordinator: MyPageCoordinator?
    var actions: MyPageViewModelActions?
    var cancellables = Set<AnyCancellable>()
    
    @Published var userProfileImage = Data()
    @Published var userProfileInfo = UserPreview()
    
    struct Input {
        var didTappedMyInfoEditButton: AnyPublisher<Void, Never>
        var didTappedHeartShopButton: AnyPublisher<Void, Never>
        var didTappedMenuCell: AnyPublisher<Int, Never>
    }
    
    struct Output {}
    
    func setActions(actions: MyPageViewModelActions) {
        self.actions = actions
    }
    
    func transform(input: Input) -> Output {
        
        input.didTappedHeartShopButton
            .sink { [weak self] in
                self?.actions?.showHeartShopFlow?()
            }
            .store(in: &cancellables)
        
        input.didTappedMyInfoEditButton
            .sink { [weak self] in
                self?.actions?.showMyInfoEditFlow?()
            }
            .store(in: &cancellables)
        
        input.didTappedMenuCell
            .sink { [weak self] in
                switch $0 {
                case 0:
                    self?.actions?.showHeartShopFlow?()
                case 1:
                    self?.actions?.showServiceTermFlow?()
                case 2:
                    self?.actions?.showDistanceFlow?()
                default:
                    break
                }
            }
            .store(in: &cancellables)
        return Output()
    }
    
}
