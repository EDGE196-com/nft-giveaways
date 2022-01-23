//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTGiveawayAllocation {
    uint public nonce = 0;

    uint[] public totalNFTArray;
    uint[] public giveAwayNFTArray;

    mapping(uint => bool) checkNftInArray;
    
    // this function will be modified according to actual NFT Token IDs that will be created.
    // value of i = 1 because generally NFT token id starts from 1 and not from 0. 
    function createTokenIdArray(uint arrayLength) public {
        
        for(uint i = 1 ; i < arrayLength+1 ; i++){
            totalNFTArray.push(i);
        }
    }

    // Returns array of total NFTs 
    function getTotalNFTArray() public view returns(uint[] memory){
        return totalNFTArray;
    }

    // This function will generate random number within a specified range
    function randModules(uint lowerRange,uint upperRange ) internal returns(uint){
        nonce++ ;
        uint randomNumber = uint(keccak256(abi.encodePacked(nonce, block.timestamp, block.difficulty, msg.sender)));
        return randomNumber % (upperRange - lowerRange) + lowerRange;
    }
    // Total NFTs 1000
    // Giveaway NFTs 200 (Rare 30% = 60 , Premium 30% = 60, Normal 40% = 80)

    // This function has to be run three time, each for Rare, Premium and Common NFT distribution

    function distributeNFT(uint NumberOfNft, uint lowerRange, uint upperRange) public {
        uint i = 0;
        while(i < NumberOfNft){
            uint randNFT = randModules(lowerRange,upperRange);

            if(checkNftInArray[randNFT] == false){
                giveAwayNFTArray.push(randNFT);
                checkNftInArray[randNFT] = true;
                i++ ;
            }
        }
    }

    // Returns the GiveAway NFTS randomly choosen from total NFT array
    // First 60 IDs: rare, next 60 IDs: Premium, last 80 IDs: Common
    function getGiveAwayNFTArray() public view returns(uint[] memory){
        return giveAwayNFTArray;
    }
}