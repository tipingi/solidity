pragma solidity ^0.8.4;

//인스턴스화: 메모리나 디스크에 이를 위한 자원이 할당
contract Will{
    // 1. 증여자 게정 주소 2. 증여 유산 정도 3. 사망 여부

    //1. 증여자 계정 주소
    address owner;
    
    // 2. 중요 유산 정도
    uint fortune;

    // 3. 사망 여부
    bool isDead;

    // payable: 함수가 이더를 보내고 받을 수 있게 만들음 
    // payable과 함께 계약을 배포하면 이더 잔고에 따라 fortune을 초기화할 수 있음
    constructor() payable public {
        owner = msg.sender;
        // msg = message, owner라는 변수가 address 를 호출하는 이를 대변한다는 의미
        // 호출하는게 누구든 간에 함수를 호출하는 address를 대표
        // msg sender represents address that is being called


        fortune = msg.value;
        // value = 전송하는 이더의 양
        // msg value represents address that is being sent

        isDead = false;
    }

    // ===: 반드시 서로 같아야 함, ==: 서로 같아야 함
    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
 
    // create modifier so that we only allocate funds if owners dead
    modifier mustBeDeceased{
        require(isDead);
        _; 
    }

    //list of family wallets
    address payable[] familyWallets;

    //iteration iterating - looping through - when we map through we iterate through key store
    //mapping
    mapping(address => uint) inheritance;

    // payable 명시한 함수에서만 이더(ether)를 보낼 수 있음
    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        // to add wallets to the family wallets
        familyWallets.push(wallet);
        inheritance[wallet] = amount;

    }

    // 지급 자동화 기능
    // pay each family member based on their wallet address
    function payout() private mustBeDeceased{
        for(uint i = 0; i < familyWallets.length; i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    // oracle switch simulation
    function hasDeceased() public onlyOwner{
        isDead = true;
        payout();
    } 
}z