//
//  TestCombination.swift
//  TestRxSwiftMacOS
//
//  Created by Calvix on 2017/4/26.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import Foundation

import RxSwift

func testCombine() -> Void {
    
    let disposeBag = DisposeBag()
    
    //
    example("startWith"){
        let observableObject = Observable<Int>.create{
            $0.onNext(1)
            $0.onNext(2)
            return Disposables.create()
        }
        
        observableObject.startWith(0)
            .startWith(-1)
            .startWith(-2)
            .subscribe{
                print("1: \($0)")
            }
            .disposed(by: disposeBag)
        
        observableObject.startWith(3)
            .startWith(4)
            .startWith(5)
            .subscribe{
                print("2: \($0)")
            }
            .disposed(by: disposeBag)
    }
    
    example("merge"){
        let o1 = Observable<Int>.just(1)
        let o2 = Observable<Int>.just(2)
        
        Observable.of(o1, o2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //必须同时有两个事件 不然不触发subscribe
    example("zip"){
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject, resultSelector: {
            "\($0) and \($1)";
            })
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        
        stringSubject.onNext("tom")
        intSubject.onNext(1)
        
        stringSubject.onNext("alex")
        intSubject.onNext(2)
        
        stringSubject.onNext("tony")
    }
    
    //
    example("combineLatest"){
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        let combine = Observable.combineLatest(stringSubject, intSubject){
            "\($0) combine: \($1)"
            }
        combine.subscribe{
            print("1: \($0)")
            }
            .disposed(by: disposeBag)
        
        stringSubject.asObserver().onNext("tom")
        stringSubject.onNext("alex")
        stringSubject.asObserver().onNext("tony")
        
        combine.subscribe{
            print("2: \($0)")
        }
        .disposed(by: disposeBag)
        
        intSubject.onNext(12)
        intSubject.onNext(34)
        
        stringSubject.onNext("mark")
    }
    
    //switch的Observable类型要求一致
    example("switchLatest"){
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        let variable = Variable(subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        
        subject1.onNext("apple")
        subject1.onNext("banana")
        
        subject2.onNext("1")
        
        variable.value = subject2
        subject2.onNext("2")
        
    }
    
}
