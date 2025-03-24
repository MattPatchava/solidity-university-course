// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract QualityContract {
    address public owner;

    struct QualityContractData {
        string contractName;
        address[] stakeholders;
        string qualityCriteria;
        bool isCompleted;
    }

    mapping(uint256 => QualityContractData) public qualityContracts;
    uint256 public contractCount;

    event QualityContractCreated(
        uint256 contractId, string contractName, address[] stakeholders, string qualityCriteria
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can execute this function");
        _;
    }

    function createQualityContract(
        string memory _contractName,
        address[] memory _stakeholders,
        string memory _qualityCriteria
    ) public onlyOwner {
        contractCount++;
        qualityContracts[contractCount] = QualityContractData(_contractName, _stakeholders, _qualityCriteria, false);

        emit QualityContractCreated(contractCount, _contractName, _stakeholders, _qualityCriteria);
    }

    function completeQualityContract(uint256 _contractId) public onlyOwner {
        require(_contractId > 0 && _contractId < contractCount, "Invalid contract ID");

        qualityContracts[_contractId].isCompleted = true;
    }

    function getQualityContractDetails(uint256 _contractId)
        public
        view
        returns (string memory, address[] memory, string memory, bool)
    {
        require(_contractId > 0 && _contractId < contractCount, "Invalid contract ID");

        QualityContractData storage contractData = qualityContracts[_contractId];
        return (
            contractData.contractName, contractData.stakeholders, contractData.qualityCriteria, contractData.isCompleted
        );
    }

    function performQualityCheck(uint256 _contractId) public {
        require(_contractId > 0 && _contractId < contractCount, "Invalid contract ID");

        bool isStakeholder = false;
        for (uint256 i = 0; i < qualityContracts[_contractId].stakeholders.length; i++) {
            if (qualityContracts[_contractId].stakeholders[i] == msg.sender) {
                isStakeholder = true;
                break;
            }
        }
        require(isStakeholder, "Only stakeholders can perform a quality check");

        qualityContracts[_contractId].isCompleted = true;
    }
}
