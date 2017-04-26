//
//  TestBasicRxSwift.swift
//  TestRxSwiftMacOS
//
//  Created by Calvix on 2017/4/26.
//  Copyright © 2017年 Calvix. All rights reserved.
//

import Foundation
import RxSwift

func example(_ name: String, _ action:(Void) -> Void){
    print("-----example:"+name)
    action()
    print("-----end\n")
}

func testBasic() -> Void {
    let disposeBag = DisposeBag()
    Observable.just("test just")
        .subscribe{
            print($0)
        }
        .disposed(by: disposeBag)
    
    //
    example("never"){
        let disposeBag = DisposeBag()
        Observable<String>.never()
            .subscribe{
                print("never")
            }
            .disposed(by:disposeBag)
    }
    
    //
    example("empty"){
        let disposeBag = DisposeBag()
        Observable<String>.empty()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    //
    func test(){
        let disposeBag = DisposeBag()
        Observable<String>.just("just")
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        
    }
    
    //
    example("of"){
        Observable<Int>.of(1, 2, 3, 4, 5)
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        
    }
    
    //
    example("from"){
        Observable<Int>.of(1, 2, 3, 4, 5)
            .subscribe(onNext: { (event) in
                print(event)
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print($0)
            }, onDisposed: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    //
    example("create") { () in
        Observable<String>.create({ observer in
            observer.on(.next("hello"))
            return Disposables.create()
        })
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    //
    example("create2"){
        Observable<String>.create{
            $0.onNext("hello2")
            return Disposables.create()
            }
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    
    //
    example("range"){
        Observable<Int>.range(start: 1, count: 5)
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    //
    example("repeat"){
        Observable.repeatElement("re e")
            .take(3)
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    //
    example("generate"){
        Observable.generate(
            initialState: 10,
            condition: { $0 < 20},
            iterate: { $0 + 2}
            )
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //
    example("deferred", {
        let deferred = Observable<Int>.deferred({
            print("create deferred")
            return Observable<Int>.create{
                $0.onNext(1)
                $0.onNext(2)
                return Disposables.create()
            }
        })
        deferred.subscribe({
            print($0)
        })
            .disposed(by: disposeBag)
        deferred.subscribe{
            print($0)
            }
            .disposed(by: disposeBag)
    })
    
    //
    example("normal create"){
        let normalSequeuence = Observable<Int>.create{
            print("test")
            $0.onNext(1)
            $0.onNext(2)
            return Disposables.create()
        }
        
        normalSequeuence.subscribe{
            print($0)
            }
            .disposed(by: disposeBag)
        normalSequeuence.subscribe{
            print($0)
            }
            .disposed(by: disposeBag)
    }
    
    //
    enum TestError : Error{
        case error
    }
    
    example("error"){
        Observable<Int>.error(TestError.error)
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
        
    }
    
    
    //
    example("doOn"){
        Observable<String>.create{
            $0.onNext("first")
            $0.onNext("second")
            $0.onNext("third")
            return Disposables.create()
            }
            .do(onNext: {
                print("doOnNext:  \($0)")
            }, onError: {
                print("doOnError:  \($0)")
            }, onCompleted: {
                print("doOnCompleted")
            }, onSubscribe: {
                print("doOnSubscribe")
            }, onSubscribed: {
                print("doOnSubscribed")
            }, onDispose: {
                print("doOnDispose")
            })
            .subscribe{
                print("subscribe: \($0)")
            }
            .disposed(by: disposeBag)
    }
}
