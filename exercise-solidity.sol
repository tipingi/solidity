//pragma: 사용 중인 Solidity의 버전을 나타내는 문구 - 코드 파일의 호환성을 확인하는데 도움을 줌
pragma solidity >=0.7.0 <0.9.0; // 0.7.0 버전 이상 0.9.0 버전 미만 사용


// create a contract that can sotre data and reutrn the data block
// be abel to do the following:
// 1. reciece information 2. store information 3. return the inforamtion blcok

contract simpleStorage { 
    // write all the code inside here - functions and its state

    uint storeData = 23;

    // set function
    // public: 외부에서 호출 가능
    function set(uint x) public
    {
        storeData = x;

    }

    // get function
    // view: 이 함수에 상태를 수정할 수 없다는 것을 알리는 전역 제어자
    // returns : 가시성을 부여 상태가 수정되지 않도록 하고 계약에 대한 정수를 반환하게 함 - 명시적 선언
    function get() public view returns (uint)
    {
        return storeData;
    }
}



// 1. create a storage contract that sets and gets values - only the value it returns is multiplied 5x
pragma solidity >= 0.7.0 < 0.9.0

contract mutiplied{
    uint number = 15;

    function set(uint x) public{
    number = x * 5;
    }

    function get() public view returns (uint){
        return number;
    }
}

// 2. create a storage contract that sets and gets values of names
pragma solidity >= 0.7.0 < 0.9.0

contract mutiplied{
    string name = "";

    function set(string str) public{
    name = str;
    }

    function get() public view returns (uint){
        return name;
    }


}