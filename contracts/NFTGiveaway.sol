// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./USDAO721.sol";

interface IUSDAO721 {
    function mintNFT(address, string memory) external;
}

contract NFTGiveaway {
    IUSDAO721 USDAO721;
    address immutable owner;
    mapping(address => string) winnersUri;
    mapping(address => bool) claimed;

    constructor(address _usdao721) {
        owner = msg.sender;
        USDAO721 = IUSDAO721(_usdao721);
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
