const { expectRevert } = require('@openzeppelin/test-helpers');
const USDAO1155 = artifacts.require("USDAO1155");
const NFTGiveaway = artifacts.require("NFTGiveaway");

contract("NFTGiveaway", accounts => {

    it('should deploy the smart contract properly', async () => {
        const ethContract = await NFTGiveaway.deployed();
        assert(ethContract.address != '', 'the smart contract is not deployed properly');
    })

    it('reverts if setWinners function is called by someone other than the owner', function () {
        return NFTGiveaway.deployed().then(async function (instance) {
            ethInstance = instance;
        }).then(async function () {
            let addresses = [];
            addresses.push(accounts[1]);
            let uris = [];
            uris.push("456.json");
            await expectRevert(ethInstance.setWinners(addresses, uris, { from: accounts[1] }), "only owner has the permission to access this function!!!");
        })
    })

    it('reverts if arrays are not passed in the setWinners function correctly', function () {
        return NFTGiveaway.deployed().then(async function (instance) {
            ethInstance = instance;
        }).then(async function () {
            let addresses = [];
            addresses.push(accounts[1]);
            let uris = [];
            await expectRevert(ethInstance.setWinners(addresses, uris, { from: accounts[0] }), "invalid arguments!!!");
        })
    })

    it('owner should be able to set giveaway winners', function () {
        return NFTGiveaway.deployed().then(function (instance) {
            ethInstance = instance;
            let addresses = [];
            addresses.push(accounts[1]);
            let uris = [];
            uris.push("456.json");
            return ethInstance.setWinners(addresses, uris, { from: accounts[0] });
        }).then(function () {
            return ethInstance.winnersUri(accounts[1]);
        }).then(function (result) {
            assert.equal(result, "456.json", 'giveaway winners not set!!!')
        })
    })


    it('reverts if someone other than the winner trys to claim/lazy mint the NFT', function () {
        return NFTGiveaway.deployed().then(async function (instance) {
            ethInstance = instance;
        }).then(async function (result) {
            await expectRevert(ethInstance.claim({ from: accounts[2] }), "invalid caller!!!");
        })
    })

    it('winner should be able to claim/lazy mint its NFT', function () {
        return NFTGiveaway.deployed().then(function (instance) {
            ethInstance = instance;
            return ethInstance.claim({ from: accounts[1] });
        }).then(async function () {
            const usdao1155 = await USDAO1155.deployed();
            return usdao1155.balanceOf(accounts[1], 1);
        }).then(function (result) {
            assert.equal(result.toNumber(), 1, 'lazy mint failed!!!')
        })
    })

    it('reverts if the winner trys to claim an NFT twice', function () {
        return NFTGiveaway.deployed().then(async function (instance) {
            ethInstance = instance;
        }).then(async function (result) {
            await expectRevert(ethInstance.claim({ from: accounts[1] }), "already claimed!!!");
        })
    })

})
