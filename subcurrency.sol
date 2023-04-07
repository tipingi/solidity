pragma solidity >= 0.7.0 < 0.9.0;

// purpose of cryptocoin
// 코인을 만든 본인ㅁ나 코인을 발행 할 수 있어야함.
// 계약 주소와 수량만 입력 -> 주소로 정해진 수량만큼 전송

contract Coin{
    //minting = 주조, 코인을 만드는 것
    //public 설정 이유는 다른 계약에서 접근하게끔 하기 위해서
    address public minter;
    mapping(address => uint) public balances; 

    // 계약을 배포할 때만 생성자 함수가 실행된다.
    constructor(){
        minter = msg.sender;
        // 생성자 = minter
    }

    // 새로운 코인을 생성하는 건 작성자만 생성, 주소로 보냄
    // 소유자만 코인을 보냄
    function mint(address receiver, uint amount) public{
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested, uint available);
    event Sent(address from, address to, uint amount);

    function send(address receiver, uint amount) public {
        // require amount to be greater than msg.sender amount
        if(balances[msg.sender] < amount)
        {
            //revert는 이 트랜잭션이 발생치 않도록 해주면서 트랜잭션의 정보를 알려줌
            revert insufficientBalance({
              requested: amount,
              available: balances[msg.sender]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        // event를 발생함 -> emit
        emit Sent(msg.sender, receiver, amount);
    }
}
