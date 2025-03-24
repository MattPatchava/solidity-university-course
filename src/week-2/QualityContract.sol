// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract QualityContract {
    address public singleStakeholder;
    uint256 public qualityScore;

    constructor(address _singleStakeholder) {
        require(_singleStakeholder != address(0), "Invalid stakeholder address");
        singleStakeholder = _singleStakeholder;
        qualityScore = 0;
    }

    modifier onlyStakeholder() {
        require(msg.sender == singleStakeholder, "Only the stakeholder can call this function");
        _;
    }

    function updateQualityScore(uint256 newScore) public onlyStakeholder {
        qualityScore = newScore;
    }
}
