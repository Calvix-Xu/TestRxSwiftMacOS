//
//  TestSubject.swift
//  TestRxSwiftMacOS
//
//  Created by Calvix on 2017/4/26.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import Foundation
import RxSwift

func testSubject(){
    let disposeBag = DisposeBag()
    
    //
    example("public subject"){
        let subject = PublishSubject<Int>()
        subject.subscribe{
            print($0)
        }
        .disposed(by: disposeBag)
        
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        
        subject.subscribe({
            print($0)
        }).disposed(by: disposeBag)
        
        subject.onNext(4)
        subject.onNext(5)
    }
    
    //
    example("replaySubject"){
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        subject.subscribe{
            print("1:\($0)")
        }
        .disposed(by: disposeBag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.subscribe({
            print("2:\($0)")
        })
        .disposed(by: disposeBag)
        
        subject.onNext("4")
        subject.onNext("5")
    }
    
    example("BehaviorSubject", {
        let subject = BehaviorSubject<Int>(value: 1)
        
        subject.onNext(10)
        
        subject.subscribe{
            print($0)
        }
        .disposed(by: disposeBag)
        
        subject.onNext(2)
        subject.onNext(3)
        
        subject.subscribe({
            print($0)
        })
        .disposed(by: disposeBag)
        
        subject.onNext(4)
        
    })
    
    example("Variable", { Void in
        let variable = Variable("1")
//        variable.value = "123"
        variable.asObservable().subscribe{
            print("1: \($0)")
        }
        .disposed(by: disposeBag)
        
        variable.value = "2"
        variable.value = "3"
        
        variable.asObservable().subscribe{
            print("2: \($0)")
        }
        .disposed(by: disposeBag)
        
        variable.value = "4"
    })
    
    
}
