const NFTGiveaway = artifacts.require("NFTGiveaway");
const USDAO1155 = artifacts.require("USDAO1155");
module.exports = function (deployer) {
    deployer.deploy(NFTGiveaway, USDAO1155.address);
    // USDAO1155.deployed().then(function (instance) {
    //     ethInstance = instance;
    //     return ethInstance.changeFreeMintAllowed(NFTGiveaway.address, true);
    // })
};