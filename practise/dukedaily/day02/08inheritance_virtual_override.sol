/**
1. 合约之间存在继承关系，使用关键字：is
2. 如果父合约的方法想被子合约继承，则需要使用关键字：virtual
3. 如果子合约想覆盖父合约的方法，则需要使用关键字：override
4. 在子合约中如果想调用父合约的方法，需要使用关键字：super
5. 继承的顺序很重要，遵循最远继承，即后面继承的合约会覆盖前面父合约的方法
6. super会调用继承链条上的每一个合约的相关函数，而不仅仅是最近的父合约
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    // This is called an event. You can emit events from your function
    // and they are logged into the transaction log.
    // In our case, this will be useful for tracing function calls.
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo called");
    }

    function bar() public virtual {
        emit Log("A.bar called");
    }
}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}

contract D is B, C {
    // Try:
    // - Call D.foo and check the transaction logs.
    //   Although D inherits A, B and C, it only called C and then A.


    function foo() public override(B, C) {
        super.foo();
    }

  	// Try:
    // - Call D.bar and check the transaction logs
    //   D called C, then B, and finally A.
    //   Although super was called twice (by B and C) it only called A once.
    function bar() public override(B, C) {
        super.bar();
    }
}

/**
详细解析：

1. D调用foo的时候，由于B，C中的foo都没有使用super，所以只是覆盖问题，根据最远继承，C
   覆盖了B，所以执行顺序为：D -> C -> A；
2. D调用bar的时候，由于B，C中的bar使用了super，此时D的两个parent都需要执行一遍，因此为D-> C -> B -> A，整个过程中A合约只会被调用一次。具体原因是Solidity借鉴了Python的方式，强制一个由基类构成的DAG（有向无环图）使其保证一个特定的顺序。
*/