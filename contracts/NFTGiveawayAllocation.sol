pragma solidity ^0.8.0;

contract NFTGiveawayAllocation {
    uint public nonce = 0;

    uint[] public totalNFTArray;
    uint[] public giveAwayNFTArray;

    mapping(uint => bool) checkNftInArray;
    

    function createTokenIdArray(uint arrayLength) public {
        
        for(uint i = 0 ; i <arrayLength ; i++){
            totalNFT.push(i);
        }
    }

    function getTotalNFTArray() public view returns(uint[] memory){
        return totalNFTArray;
    }

    function randModules(uint lowerRange,uint upperRange ) internal returns(uint){
        nonce++ ;
        uint randomNumber = uint(keccak256(abi.encodePacked(nonce, block.timestamp, block.difficulty, msg.sender)));
        return randomNumber % (upperRange - lowerRange) + lowerRange;
    }
    // Total NFTs 1000
    // Giveaway NFTs 200 (Rare 30% = 60 , Premium 30% = 60, Normal 40% = 80)

 
    function distributeNFT(uint NumberOfNft, uint lowerRange, uint upperRange) public {
        for (uint i =0 ; i< NumberOfNft ; i++){
            uint randNFT = randModules(lowerRange,upperRange);

            if(checkNftInArray[randNFT] == false){
                giveAwayNFTArray.push(randNFT);
                checkNftInArray[randNFT] = true;
            }            
        }
    }

    function getGiveAwayNFTArray() public view returns(uint[] memory){
        return giveAwayNFTArray;
    }
}