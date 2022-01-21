// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract USDAO721 is ERC721 {
    address public owner;
    uint256 public totalSupply;
    mapping(uint256 => string) private _tokenURI;

    constructor() ERC721("USDAO NFT Collection", "USDAO-NFT") {
        totalSupply = 0;
        owner = msg.sender;
    }

    // function _baseURI() internal view virtual override returns (string memory) {
    //     return "ipfs://QmSLMv1UbbtJztwTg9UjfF3YCEeFmwFnmvy2sYPsFnoiCd/{id}.json";
    // }

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        return _tokenURI[_tokenId];
    }

    function mintNFT(address minter, string memory _uri) external {
        totalSupply++;
        _tokenURI[totalSupply] = _uri;
        _safeMint(minter, totalSupply);
    }
}
