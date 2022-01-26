const USDAO1155 = artifacts.require("USDAO1155");
const { expectRevert } = require('@openzeppelin/test-helpers');

contract("USDAO1155", accounts => {

    it('should deploy the smart contract properly', async () => {
        const ethContract = await USDAO1155.deployed();
        assert(ethContract.address != '', 'the smart contract is not deployed properly');
    })

    it('should set the name correctly', function () {
        return USDAO1155.deployed().then(function (instance) {
            ethInstance = instance;
            return ethInstance.name();
        }).then(function (result) {
            assert.equal(result, "USDAO NFT Collection", 'name not correct!!!')
        })
    })

    it('should set the symbol correctly', function () {
        return USDAO1155.deployed().then(function (instance) {
            ethInstance = instance;
            return ethInstance.symbol();
        }).then(function (result) {
            assert.equal(result, "USDAO-NFT", 'symbol not correct!!!')
        })
    })

    it('should be able to mint a new NFT', function () {
        return USDAO1155.deployed().then(function (instance) {
            ethInstance = instance;
            return ethInstance.mintNFT(accounts[0], "123.json", 0);
        }).then(function () {
            return ethInstance.balanceOf(accounts[0], 1);
        }).then(function (result) {
            assert.equal(result.toNumber(), 1, 'NFT not minted!!!')
        })
    })
})