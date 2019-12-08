const Migrations = artifacts.require("Migrations");
const storeState = artifacts.require("storeState");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(storeState);
};
