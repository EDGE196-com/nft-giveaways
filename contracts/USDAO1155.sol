// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract USDAO1155 is ERC1155 {
    address public owner;
    uint256 public totalSupply;
    uint256 public supplyCap;
    string public name;
    string public symbol;
    mapping(uint256 => string) private _tokenURI;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "only owner has the permission to access this function!!!"
        );
        _;
    }

    constructor() ERC1155("") {
        totalSupply = 0;
        owner = msg.sender;
        supplyCap = 1000;
        name = "USDAO NFT Collection";
        symbol = "USDAO-NFT";
    }

    function uri(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        return _tokenURI[_tokenId];
    }

    function changeSupplyCap(uint256 _newSupplyCap) public onlyOwner {
        supplyCap = _newSupplyCap;
    }

    function mintNFT(address minter, string memory _uri) external {
        //this will only mint single copy of an nft
        require(totalSupply < 1000, "cannot mint more NFTs!!!");
        totalSupply++;
        _setURI(_uri);
        emit URI(_uri, totalSupply);
        _mint(minter, totalSupply, 1, "");
        _tokenURI[totalSupply] = _uri;
    }
}
