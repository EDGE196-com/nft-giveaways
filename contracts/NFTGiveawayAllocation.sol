// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract NFTGiveawayAllocation {
    uint256 public nonce = 0;

    uint256[] public totalNFTArray;
    uint256[] public giveAwayNFTArray;

    mapping(uint256 => bool) checkNftInArray;

    // this function will be modified according to actual NFT Token IDs that will be created.
    // value of i = 1 because generally NFT token id starts from 1 and not from 0.
    function createTokenIdArray(uint256 arrayLength) public {
        for (uint256 i = 1; i < arrayLength + 1; i++) {
            totalNFTArray.push(i);
        }
    }

    // Returns array of total NFTs
    function getTotalNFTArray() public view returns (uint256[] memory) {
        return totalNFTArray;
    }

    // This function will generate random number within a specified range
    function randModules(uint256 lowerRange, uint256 upperRange)
        internal
        returns (uint256)
    {
        nonce++;
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    nonce,
                    block.timestamp,
                    block.difficulty,
                    msg.sender
                )
            )
        );
        return (randomNumber % (upperRange - lowerRange)) + lowerRange;
    }

    // Total NFTs 1000
    // Giveaway NFTs 200 (Rare 30% = 60 , Premium 30% = 60, Normal 40% = 80)

    // This function has to be run three time, each for Rare, Premium and Common NFT distribution

    function distributeNFT(
        uint256 NumberOfNft,
        uint256 lowerRange,
        uint256 upperRange
    ) public {
        uint256 i = 0;
        while (i < NumberOfNft) {
            uint256 randNFT = randModules(lowerRange, upperRange);

            if (checkNftInArray[randNFT] == false) {
                giveAwayNFTArray.push(randNFT);
                checkNftInArray[randNFT] = true;
                i++;
            }
        }
    }

    // Returns the GiveAway NFTS randomly choosen from total NFT array
    // First 60 IDs: rare, next 60 IDs: Premium, last 80 IDs: Common
    function getGiveAwayNFTArray() public view returns (uint256[] memory) {
        return giveAwayNFTArray;
    }
}
