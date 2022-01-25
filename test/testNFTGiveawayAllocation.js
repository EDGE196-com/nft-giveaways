const { expectRevert } = require('@openzeppelin/test-helpers');
const NFTGiveawayAllocation = artifacts.require("NFTGiveawayAllocation");

contract("NFTGiveawayAllocation", accounts => {

    it('should create array', function () {
        
        return NFTGiveawayAllocation.deployed().then(async function (instance) {
            ethInstance = instance;
            await ethInstance.createTokenIdArray(10);
            
            const arrayLength = await ethInstance.getTotalNFTArray;
            console.log(arrayLength.length);
            return arrayLength.length;
        }).then(function (result) {
            assert.equal(result, 10, 'length not same')
        })
    })
})
