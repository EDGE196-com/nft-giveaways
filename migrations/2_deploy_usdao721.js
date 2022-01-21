const USDAO721 = artifacts.require("USDAO721");

module.exports = function (deployer) {
  deployer.deploy(USDAO721);
};
