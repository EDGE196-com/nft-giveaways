// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;

import "./USDAO721.sol";

interface IUSDAO {
    function mintNFT(address, string memory) external;
}

contract NFTGiveaway {
    IUSDAO USDAO721;
    address immutable owner;
    mapping(address => string) winnersUri;
    mapping(address => bool) claimed;

    constructor(address _usdao721) {
        owner = msg.sender;
        USDAO721 = IUSDAO(_usdao721);
    }

    function compareStrings(string memory a, string memory b)
        internal
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }

    function setWinners(address[] memory _addresses, string[] memory _uris)
        external
    {
        require(
            owner == msg.sender,
            "only owner has access to this function!!!"
        );
        require(_addresses.length == _uris.length, "invalid arguments!!!");
        for (uint256 i = 0; i < _addresses.length; i++) {
            winnersUri[_addresses[i]] = _uris[i];
        }
    }

    function claim() external {
        require(
            !compareStrings(winnersUri[msg.sender], ""),
            "invalid caller!!!"
        );
        require(claimed[msg.sender] == false, "already claimed!!!");
        //lazy minting
        USDAO721.mintNFT(msg.sender, winnersUri[msg.sender]);
        claimed[msg.sender] = true;
    }
}
