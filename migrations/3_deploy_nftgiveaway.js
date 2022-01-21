const NFTGiveaway = artifacts.require("NFTGiveaway");
const USDAO721 = artifacts.require("USDAO721");
module.exports = function (deployer) {
    deployer.deploy(NFTGiveaway, USDAO721.address);
};